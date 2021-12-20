"""HeraCorrelator."""

import logging
import os
import time
import redis
import yaml
import json
from hera_corr_cm.handlers import add_default_log_handlers
from hera_corr_cm import redis_cm
import hashlib
from Queue import Queue
from threading import Thread
from hera_corr_f import SnapFengine
import numpy as np

LOGGER = add_default_log_handlers(logging.getLogger(__name__))
TEMP_BITSTREAM_STORE = "/tmp/"  # location to store bitfiles from redis
MAJOR_VERSION = [6, 7]


class HeraCorrelator(object):
    """HERA Correlator control class."""

    def __init__(self, hosts=None, redishost='redishost', config=None,
                 logger=LOGGER, passive=False, redis_transport=False,
                 block_monitoring=True):
        """
        Instantiate a HeraCorrelator instance.

        Inputs:
            hosts (list): List of F-Engine hosts to connect to.
            redishost (str): Hostname (or IP address) of redis database.
                Default: 'redishost'
            config (str): Path to configuration file. If None, will be
                grabbed from redis. Default: None
            logger (logging.Logger): Logging object for this class.
            passive (Boolean): Disable SNAP connections. Default False.
            redis_transport (Boolean): Use redis proxy for talking to SNAP
                boards, rather than direct TFTP. Default: False
            block_monitoring (Boolean): Disable monitoring before
                connecting to boards.  Default: True
        """
        self.logger = logger
        self.redishost = redishost
        self.r = redis.Redis(redishost, decode_responses=True)
        # also keep a non-decoded redis connection for reading
        # values with byte-strings like the .fpg files
        self.r_bytes = redis.Redis(redishost, decode_responses=False)
        self.redis_transport = redis_transport  # XXX why have this (ARP 11/3/21)?
        self.passive = passive
        if isinstance(hosts, str):  # So that you can just use one as a str.
            hosts = [hosts]

        self.fengs = {}
        self.get_config(config)  # sets self.config
        self.set_default_progfile()  # sets self._progfile

        if not passive:
            if block_monitoring:  # XXX still necessary (ARP 11/3/21)?
                self.disable_monitoring(60, verify=True)
            self._hookup_from_redis()
            self._unconnected = self.connect_fengs(hosts=hosts)

    def get_config(self, config=None, verify=True):
        """
        Parse configuration file and set self.config accordingly.

        Inputs:
            config (str): Path to configuration file. If None,
                configuration pulled from redis. Default: None
            verify (bool): Do basic sanity checking on configuration.
                           Default: True
        """
        if config is None:
            # Pull configuration from redis
            self.config_str = self.r.hget('snap_configuration', 'config')
            self.config_name = self.r.hget('snap_configuration', 'name')
            self.config_hash = self.r.hget('snap_configuration', 'md5')
            self.config_time = float(self.r.hget('snap_configuration',
                                                 'upload_time'))
            self.config_time_str = self.r.hget('snap_configuration',
                                               'upload_time_str')
            self.logger.info('Using redis config (uploaded %s)' %
                             self.config_time_str)  # noqa
        else:
            # Read configuration from file
            with open(config, 'r') as fp:
                self.config_str = fp.read()
            self.config_name = config
            self.config_hash = hashlib.md5(self.config_str).hexdigest()
            self.config_time = time.time()
            self.config_time_str = time.ctime(self.config_time)
        self.config = yaml.load(self.config_str)
        if verify:
            self._verify_config()

    def feng_connect(self, host, verify=True):
        '''
        Connect to an F-Engine.

        Inputs:
            host (str): F-Engine host to connect to.
            verify (bool): Do basic sanity checking on configuration.
                           Default: True
        '''
        # Not supporting auto assignment of antenna indices
        ant_indices = self.config['fengines'][host]['ants']
        self.logger.info("Connecting %s with antenna indices %s" %
                         (host, ant_indices))
        if self.redis_transport:
            redishost = self.redishost
        else:
            redishost = None
        feng = SnapFengine(host, ant_indices=ant_indices,
                           redishost=redishost)
        if feng.fpga.is_connected():
            self.fengs[host] = feng  # single dict call is threadsafe
            self.r.hset('status:snap:%s' % host, 'connected', '1')
        else:
            self.feng_declare_disconnected(host)
            if verify:
                raise RuntimeError('Failed to connect: %s' % (host))

    def feng_declare_disconnected(self, host):
        '''
        If an F-Engine is not responding, mark it in redis and remove it
        from host list.

        Inputs:
            host (str): F-Engine host to connect to.
        '''
        self.r.hset('status:snap:%s' % host, 'connected', '0')
        try:
            del self.fengs[host]
        except(KeyError):
            pass

    def _call_on_hosts(self, target, args, kwargs,
                       hosts, multithread, timeout):
        '''
        Low-level interface for calling target function on many hosts.

        Inputs:
            target (func): Function to call on a host. Must have 'host'
                as first argument.
            args (tuple): Arguments to target, appended to (host,)
            kwargs (dict): Keyword arguments to target.
            hosts (list): List of hosts to call target on.
            multithread (bool): Use multithreading.
            timeout (float): Timeout in seconds for thread call.
        '''
        q = Queue()

        def wrap_target(host, args, kwargs):
            '''Wrapper to capture target output and exceptions.'''
            try:
                # Automatically puts host as first argument
                val = target(host, *args, **kwargs)
                q.put((host, val))
            except(RuntimeError, AssertionError) as e:
                self.logger.warning('%s: %s' % (host, e.message))
        threads = {host: Thread(
                            target=wrap_target,
                            args=(host, args, kwargs),
                         ) for host in hosts}
        for thread in threads.values():
            if multithread:
                thread.daemon = True
            thread.start()
            # serialize execution if we are not multithreading
            if not multithread:
                thread.join(timeout)
        if multithread:
            for host, thread in threads.items():
                thread.join(timeout)
            # XXX think about killing live threads
        successes = set([q.get()[0] for i in range(q.qsize())])
        failed = [host for host in hosts if host not in successes]
        if len(failed) > 0:
            self.logger.warning('Call %s failed on: %s'
                                % (target.__name__, ','.join(failed)))
        return failed

    def connect_fengs(self, hosts=None, multithread=False, timeout=300.):
        """
        Connect to SNAP boards listed in the current configuration.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds for multithreading.
                             Default: 300.
        """
        # Instantiate CasperFpga connections to all the F-Engine.

        if hosts is None:
            # in this one case, get list direct from config
            hosts = [host for host in self.config['fengines']
                     if host not in self.fengs]
        failed = self._call_on_hosts(
                            target=self.feng_connect,
                            args=(),
                            kwargs={'verify': True},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout,
        )
        return failed

    def set_default_progfile(self, progfile=None):
        """
        Set the FPGA progamming file to use.

        Inputs:
            progfile (str): Programming file path or redis key. If None,
                read from config['fpgfile']. Default None
        """
        if progfile is None:
            progfile = self.config['fpgfile']
        if progfile.startswith("redis:"):
            progfile = progfile.split(":")[-1]
            bitstream = self.r_bytes.hget("fpg:%s" % progfile, "fpg")
            progfile = os.path.join(TEMP_BITSTREAM_STORE, progfile)
            with open(progfile, "wb") as fh:
                fh.write(bitstream)
        self._progfile = progfile

    def feng_program(self, host, progfile=None, force=False,
                     verify=True, timeout=10):
        """
        Program F-Engine on specified host.

        Inputs:
            host (str): Host to target.
            progfile (str): Path to fpga file to program. If None, the
                bitstream in current config will be used.
            force (bool): Force reprogram.  Default: False
            verify (bool): Check success.  Default: True
            timeout (float): Timeout in seconds.  Default: 10.
        """
        feng = self.fengs[host]
        if not force and feng.is_programmed():
            # XXX might add a parameter for forcing a re-upload
            # of the progfile
            return
        if progfile is None:
            progfile = self._progfile
        self.logger.info("Programming FPGA on %s with %s" %
                         (host, progfile))
        # XXX may lie and say it programmed when it didn't
        # XXX might also try multiple times and/or revert to golden image
        feng.program(progfile, force=force, verify=verify, timeout=timeout)
        sample_rate = self.config['target_sample_rate']
        # configure synth/clk and reprogram FPGA one more time
        feng.initialize_adc(sample_rate=sample_rate, verify=verify)
        # cannot read version until after initialization happens
        if verify:
            # if not forced, may leave feng programmed w/ wrong bitstream
            self.feng_check_version(host)

    def program_fengs(self, hosts=None, progfile=None, force=False,
                      verify=True, multithread=True, timeout=300.):
        """
        Program SNAPs.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            progfile (str): Path to fpga file to program. If None, the
                bitstream in current config will be used.
            force (bool): Force reprogram.  Default: False
            verify (bool): Check success.  Default: True
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds. Default: 300.
        """
        hosts = self.get_feng_hostnames(hosts=hosts, programmed=False)
        failed = self._call_on_hosts(
                            target=self.feng_program,
                            args=(),
                            kwargs={
                               'progfile': progfile,
                               'force': force,
                               'verify': verify,
                            },
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout,
        )
        # record actual sample frequency to redis
        h = hosts[0]
        clk_MHz = self.fengs[h].adc.lmx.getFreq()
        self.r['feng:sample_freq'] = clk_MHz * 1e6 # in Hz
        self.r['feng:samples_per_mcnt'] = self.config['samples_per_mcnt']
        self.r['feng:sync_time'] = -1 # not sync'd yet
        return failed

    def get_feng_hostnames(self, hosts=None, programmed=True,
                           adc_aligned=False, initialized=False,
                           dest_configed=False):
        """
        Generate list of hosts with various filters applied.

        Inputs:
            hosts (list): Lists of hosts to filter. Default: all
            programmed (bool): Only return hosts with programmed fpgas
            adc_aligned (bool): Only return hosts with aligned adcs
            initialized (bool): Only return hosts that are initialized
            dest_configed (bool): Only return hosts with eth dest configed
        """
        if hosts is None:
            hosts = self.fengs.keys()
        filtered_hosts = []
        for h in hosts:
            try:
                if programmed and not self.fengs[h].is_programmed():
                    continue
                if adc_aligned and not self.fengs[h].adc_is_configured():
                    continue
                if initialized and not self.fengs[h].is_initialized():
                    continue
                if dest_configed and not self.fengs[h].dest_is_configured():
                    continue
                filtered_hosts.append(h)
            except Exception as e:
                self.logger.warn("Comms failed on %s: %s" % (h, e.message))
        return filtered_hosts

    def feng_set_redis_status(self, host):
        """
        Upload SnapFengine.get_status() dict to redis under key
        'status:snap:<host>'.

        Inputs:
            host (str): Host to target.
        """
        _p = ['e', 'n']
        ap = ["{}{}".format(ant, _p[i % 2]) for i, (ant, pol) in enumerate(self.snap_to_ant[host])]
        status = self.fengs[host].get_status(jsonify=True)
        status.update({'antpols': json.dumps(ap)})
        self.r.hmset('status:snap:%s' % host, status)

    def set_redis_status_fengs(self, hosts=None,
                               multithread=True, timeout=300.):
        """
        Upload status dictionaries to redis for specified hosts.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds.  Default: 300.
        """
        hosts = self.get_feng_hostnames(hosts=hosts)
        failed = self._call_on_hosts(
                            target=self.feng_set_redis_status,
                            args=(),
                            kwargs={},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout,
        )
        return failed

    def feng_get_redis_status(self, host):
        """
        Return status dict from redis under 'status:snap:<host>'.

        Inputs:
            host (str): Host to target.
        """
        stats = self.r.hgetall('status:snap:%s' % host)
        return stats

    def get_redis_status_fengs(self, hosts=None):
        """
        Return nested dict of status keys in redis for specified hosts.

        Inputs:
            hosts (list): List of hosts to target. Default: all
        """
        hosts = self.get_feng_hostnames(hosts=hosts)
        stats = [self.feng_get_redis_status(h) for h in hosts]
        return dict(zip(hosts, stats))

    def feng_check_version(self, host, major=MAJOR_VERSION):
        """
        Ensure host is programmed with compatible bitfile version.

        Inputs:
            host (str): Host to target.
            major (int): Major version to match. Default MAJOR_VERSION
        """
        feng = self.fengs[host]
        _maj,_min = feng.version()
        if major is not None:
            assert(_maj in major)

    def disable_monitoring(self, expiry=60, verify=True, timeout=60):
        """
        Set "disable_monitoring" key in redis, signaling other processes
        to stop monitoring (which can interfere with TFTP traffic).

        Inputs:
            expiry (float): Period (in seconds) to disable monitoring
            verify (bool): Check success.  Default: True
            timeout (float): Timeout in seconds. Default: 60.
        """
        self.r.set('disable_monitoring', 1, ex=expiry)
        if verify:
            start = time.time()
            while self.is_monitoring():
                if time.time() > (start + timeout):
                    raise RuntimeError('Timeout waiting on monitor stop.')
                time.sleep(1)
            return

    def enable_monitoring(self):
        """
        Delete the "disable_monitoring" key in redis.
        """
        self.r.delete('disable_monitoring')

    def is_monitoring(self):
        """
        Check if monitoring daemon is polling. Returns False if monitor
        is suspended or not running at all.
        """
        for key in self.r.scan_iter("status:*hera_snap_redis_monitor.py"):
            state = self.r.get(key)
            return state == "alive"
        # no status key => monitor isn't running
        return False

    def phase_switch_disable(self, host, verify=False):
        """
        Disable phase switching on specified host.

        Inputs:
            host (str): Host to target.
            verify (bool): Check success.  Default: False
        """
        self.logger.info('Disabling phase switch on %s' % (host))
        feng = self.fengs[host]
        feng.phase_switch.disable_mod(verify=verify)
        feng.phase_switch.disable_demod(verify=verify)
        self.r.hset('status:snap:%s' % host, 'phase_switch', '0')

    def disable_phase_switches(self, hosts=None, verify=True,
                               multithread=False, timeout=300.):
        """
        Disable phase switching.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            verify (bool): Check success.  Default: True
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds for multithreading.
                             Default: 300.
        """
        if hosts is None:
            # if controlling phase switch for all fengs, record to
            # master redis flag
            self.r.hmset('corr:status:phase_switch',
                         {'state':'off', 'time':time.time()})
        hosts = self.get_feng_hostnames(hosts=hosts)
        failed = self._call_on_hosts(
                            target=self.phase_switch_disable,
                            args=(),
                            kwargs={'verify': verify},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout,
        )
        return failed

    def phase_switch_enable(self, host, verify=False):
        """
        Enable phase switching on specified host.

        Inputs:
            host (str): Host to target.
            verify (bool): Check success.  Default: False
        """
        self.logger.info('Enabling phase switch on %s' % (host))
        feng = self.fengs[host]
        feng.phase_switch.set_all_walsh(
            self.config['walsh_order'],
            self.config['fengines'][host]['phase_switch_index'],
            self.config['log_walsh_step_size'],
            verify=verify,
        )
        feng.phase_switch.set_delay(self.config["walsh_delay"],
                                    verify=verify)
        feng.phase_switch.enable_mod(verify=verify)
        feng.phase_switch.enable_demod(verify=verify)
        self.r.hset('status:snap:%s' % host, 'phase_switch', '1')

    def enable_phase_switches(self, hosts=None, verify=True,
                               multithread=False, timeout=300.):
        """
        Enable phase switching.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            verify (bool): Check success.  Default: True
            multithread (bool): Multithread across hosts. Default: False
            timeout (float): Timeout in seconds for multithreading.
                             Default: 300.
        """
        if hosts is None:
            # if controlling phase switch for all fengs, record to
            # master redis flag
            self.r.hmset('corr:status:phase_switch',
                         {'state':'on', 'time':time.time()}
            )
        hosts = self.get_feng_hostnames(hosts=hosts)
        failed = self._call_on_hosts(
                            target=self.phase_switch_enable,
                            args=(),
                            kwargs={'verify': True},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout,
        )
        return failed

    def feng_set_input(self, host, source, seed=0, stream=None, verify=True):
        """
        Set F-Engine Input to ADC or digital noise.

        Inputs:
            host (str): Host to target.
            source (str): Either 'adc' or 'noise'.
            seed (int): Initialization seed if source is 'noise'.
            stream (int): Which stream to switch. If None, switch all.
            verify (bool): Verify configuration. Default True.
        """
        feng = self.fengs[host]
        feng.set_input(source, seed=seed, stream=stream, verify=verify)

    def set_input_fengs(self, hosts=None, source='adc', seed='same',
                        manual_sync=False, verify=True):
        """
        Set F-Engine Inputs to ADC or digital noise and then sync the noises.

        Inputs:
            host (str): Host to target.
            source (str): Either 'adc' or 'noise'.
            seed (str): If 'same', use same seed for all, otherwise different.
            stream (int): Which stream to switch. If None, switch all.
            manual_sync (bool): Sync noises manually. Default False.
            verify (bool): Verify configuration. Default True.
        """
        if hosts is None:
            # if controlling phase switch for all fengs, record to
            # master redis flag
            self.r.hmset('corr:status:input',
                         {'source':source, 'seed':seed, 'time':time.time()}
            )
        hosts = self.get_feng_hostnames(hosts=hosts)
        failed = []
        seed_cnt = 0
        for host in hosts:
            feng = self.fengs[host]
            for cnt in range(feng.input.ninput_mux_streams):
                self.logger.info('Switching %s.input[%d] to %s' %
                                 (host, cnt, source))
                try:
                    # will error if verification fails
                    # overwrites previous seed for streams that share noise,
                    # but that is okay.
                    feng.set_input(source, seed=seed_cnt, stream=cnt,
                                   verify=verify)
                    if seed != 'same':
                        seed_cnt = (seed_cnt + 1) % 256
                except(RuntimeError,AssertionError,IOError):
                    self.logger.warning('Failed to switch %s.input[%d]' %
                                        (host, cnt))
                    # only logging failures at resolution of host
                    failed.append(host)
        self.sync_noise(manual=manual_sync) # necessary to make seeds "take"
        return set(failed) # only return unique hosts


    def switch_fems(self, mode, east=True, north=True, verify=True,
                    hosts=None, multithread=False, timeout=300.):
        """
        Switch FEMs to the specified mode.

        Inputs:
            mode (str): 'load','noise', or 'antenna'
            east (bool): apply to east pol. Default True
            north (bool): apply to north pol. Default True
            verify (bool): Check success.  Default: True
            hosts (list): List of hosts to target. Default: all
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds for multithreading.
                             Default: 300.
        """
        assert(mode in ('load', 'noise', 'antenna'))
        if hosts is None:
            # Assumes we succeed in setting entire array to fem state
            t = time.time()
            self.r.hmset('corr:fem_switch_state',
                         {'state': mode, 'time': t})
        hosts = self.get_feng_hostnames(hosts=hosts)
        failed = []
        for host in hosts:
            for cnt,fem in enumerate(self.fengs[host].fems):
                self.logger.info('Switching %s.fem[%d] to %s' %
                                 (host, cnt, mode))
                try:
                    # will error if verification fails
                    fem.switch(mode,east=east,north=north,verify=verify)
                    self.r.hset('status:snap:%s' % host,
                                'fem%d_switch' % cnt, mode)
                except(RuntimeError,AssertionError,IOError):
                    self.logger.warning('Failed to switch %s.fem%d' %
                                        (host, cnt))
                    self.r.hset('status:snap:%s' % host,
                                'fem%d_switch' % cnt, 'failed')
                    # only logging failures at resolution of host
                    failed.append(host)
        return set(failed) # only return unique hosts

    def lookup_ant_host_stream(self, ant, pol):
        """
        Get the host and input number for a given ant, pol.

        Inputs:
           ant: Antenna string or integer. Eg. '0' or 0.
           pol: String polarization -- 'e' or 'n'
        Returns:
           (host [str], stream_num [int])
        """
        hookup = self.ant_to_snap[str(ant)][pol.lower()]
        return hookup['host'], hookup['channel']

    def lookup_pam_attenuation(self, ant, pol):
        """
        Return PAM attenuation for specified ant/pol from redis.

        Inputs:
           ant: Antenna string or integer. Eg. '0' or 0.
           pol: String polarization -- 'e' or 'n'
        """
        redval, _ = self.r.hmget("atten:ant:%s:%s" % (str(ant), pol),
                                 "commanded", "command_time")
        if redval is None:
            raise RuntimeError('Failed to find PAM settings for (%s,%s)' %
                               (str(ant), pol))
        return int(redval)

    def store_pam_attenuation(self, ant, pol, attenuation, verify=True):
        """
        Store PAM attenuation for specified ant/pol to redis.

        Inputs:
           ant: Antenna string or integer. Eg. '0' or 0.
           pol: String polarization -- 'e' or 'n'
           attenuation: String attenuation, in dB
           verify (bool): Check success.  Default: True
        """
        self.logger.info("Commanding (%s,%s) PAM atten=%s dB in redis" \
                         % (str(ant), pol, str(attenuation)))
        self.r.hmset("atten:ant:%s:%s" % (str(ant), pol),
                     {"commanded": str(attenuation),
                      "command_time": time.time()}
        )
        if verify:
            assert(self.lookup_pam_attenuation(ant, pol) == attenuation)

    def get_fem_switch(self, ant, pol):
        """
        Read FEM switch for specified ant/pol via SNAP.

        Inputs:
           ant: Antenna string or integer. Eg. '0' or 0.
           pol: String polarization -- 'e' or 'n'
        """
        host, stream = self.lookup_ant_host_stream(ant, pol)
        switch, east, north = self.fengs[host].fems[stream//2].switch()
        return switch

    def get_pam_attenuation(self, ant, pol):
        """
        Read PAM attenuation for specified ant/pol from SNAP.

        Inputs:
           ant: Antenna string or integer. Eg. '0' or 0.
           pol: String polarization -- 'e' or 'n'
        """
        host, stream = self.lookup_ant_host_stream(ant, pol)
        pam = self.fengs[host].pams[stream//2]
        atten = dict(zip('en', pam.get_attenuation()))
        return atten[pol]

    def set_pam_attenuation(self, ant, pol, attenuation,
                            verify=True, safe=True, update_redis=False):
        """
        Set PAM attenuation for specified ant/pol.

        Inputs:
           ant: Antenna string or integer. Eg. '0' or 0.
           pol: String polarization -- 'e' or 'n'
           attenuation: String attenuation, in dB
           verify (bool): Check success.  Default: True
           safe (bool): Ensure read value is same as redis before updating
                in case there are read errors.  Default: True
           update_redis (bool): Store new value in redis.  Default: True
        """
        self.logger.info("Setting PAM for (%s,%s)" % (str(ant), pol))
        host, stream = self.lookup_ant_host_stream(ant, pol)
        pam = self.fengs[host].pams[stream//2]
        east_north = pam.get_attenuation()
        if safe:
            # make sure we read the same value as commanded
            commanded = pam._cached_atten  # commanded values stored here
            if commanded is None:
                commanded = (self.lookup_pam_attenuation(ant, 'e'),
                             self.lookup_pam_attenuation(ant, 'n'))
            assert(east_north == commanded)
        atten = dict(zip('en', east_north))
        atten[pol] = attenuation
        pam.set_attenuation(atten['e'], atten['n'], verify=verify)
        if update_redis:
            self.store_pam_attenuation(ant, pol, attenuation, verify=verify)

    def lookup_eq_coeffs(self, ant, pol):
        """
        Lookup the EQ coefficients of an antenna and polarization from
        redis.

        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
        Returns:
           Current EQ vector (numpy.array)
        """
        redval = self.r.hgetall("eq:ant:%s:%s" % (str(ant), pol))
        if len(redval) == 0:
            raise RuntimeError('Failed to find EQ coeffs for (%s,%s)' %
                               (str(ant), pol))
        coeffs = np.array(json.loads(redval['values']), dtype=np.float)
        return coeffs

    def store_eq_coeffs(self, ant, pol, coeffs, verify=True):
        """
        Store the EQ coefficients of an antenna and polarization to redis.

        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
           coeffs: EQ vector (numpy.array)
           verify (bool): Check success.  Default: True
        """
        self.r.hmset('eq:ant:%s:%s' % (str(ant), pol),
                     {'values': json.dumps(coeffs.tolist()),
                      'time': time.time()})
        if verify:
            np.testing.assert_allclose(coeffs,
                                       self.lookup_eq_coeffs(ant,pol))

    def get_eq_coeffs(self, ant, pol):
        """
        Read the EQ coefficients of an antenna and polarization from
        the FPGA stream mapped to it.

        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
        Returns:
           Current EQ vector (numpy.array)
        """
        host, stream = self.lookup_ant_host_stream(ant, pol)
        return self.fengs[host].eq.get_coeffs(stream)

    def set_eq_coeffs(self, ant, pol, coeffs,
                      verify=False, update_redis=False):
        """
        Write the EQ coefficients of an antenna and polarization to
        the FPGA stream mapped to it.

        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
           coeffs: EQ vector (numpy.array)
           verify (bool): Check success.  Default: False
           update_redis (bool): Store new value in redis.  Default: False
        """
        self.logger.info("Setting EQ for (%s,%s)" % (str(ant), pol))
        host, stream = self.lookup_ant_host_stream(ant, pol)
        # broadcast shape based on ncoeffs
        coeffs = np.ones(self.fengs[host].eq.ncoeffs) * coeffs
        self.fengs[host].eq.set_coeffs(stream, coeffs, verify=verify)
        if update_redis:
            self.store_eq_coeffs(ant, pol, coeffs, verify=verify)

    def eq_initialize(self, host, verify=True):
        """
        Initialize digital equalization coeffs on specified host.

        Inputs:
            host (str): Host to target.
            verify (bool): Check success.  Default: True
        """
        self.logger.info("Initializing EQ on %s" % (host))
        feng = self.fengs[host]
        antpols = self.snap_to_ant[host]
        failed = []
        for stream, (ant, pol) in enumerate(antpols):
            if ant is not None:
                coeffs = self.lookup_eq_coeffs(ant, pol)
                try:
                    feng.eq.set_coeffs(stream, coeffs, verify=verify)
                except(AssertionError,RuntimeError):
                    # Catch errs so an attempt is made for each stream
                    failed.append((stream, (ant, pol)))
        if len(failed) > 0:
            raise RuntimeError('Failed to initialize EQ on %s: %s' %
                               (host, ','.join(['%d=(%d%s)' % (ant,pol)
                                      for stream,(ant,pol) in failed])))

    def initialize_eqs(self, hosts=None, verify=True,
                        multithread=False, timeout=300.):
        """
        Initialized equalization coeffs.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            verify (bool): Check success.  Default: True
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds for multithreading.
                             Default: 300.
        """
        hosts = self.get_feng_hostnames(hosts=hosts)
        failed = self._call_on_hosts(
                            target=self.eq_initialize,
                            args=(),
                            kwargs={'verify': verify},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout
        )
        return failed

    def pam_initialize(self, host, default=8, verify=True):
        """
        Initialize PAM coefficients on specified host.

        Inputs:
            host (str): Host to target.
            default (int): Default PAM attenuation value. Default: 8
            verify (bool): Check success.  Default: True
        """
        self.logger.info("Initializing PAMs on %s" % (host))
        feng = self.fengs[host]
        antpols = self.snap_to_ant[host]
        failed = []
        for cnt,pam in enumerate(feng.pams):
            # Antpols are hooked up in n/e order in snap_to_ant, but
            # pams address them in e/n order
            (ant_n, pol_n) = antpols[2*cnt]
            (ant_e, pol_e) = antpols[2*cnt + 1]
            atten_e, atten_n = None, None
            if ant_n is not None:
                try:
                    atten_n = self.lookup_pam_attenuation(ant_n, pol_n)
                except(RuntimeError):
                    self.logger.warn("(%d,%s) PAM Attenuation not in redis. Setting to default." % (ant_n, pol_n))
                    self.store_pam_attenuation(ant_n, pol_n, default)
                    atten_n = default
            if ant_e is not None:
                try:
                    atten_e = self.lookup_pam_attenuation(ant_e, pol_e)
                except(RuntimeError):
                    self.logger.warn("(%d,%s) PAM Attenuation not in redis. Setting to default." % (ant_e, pol_e))
                    self.store_pam_attenuation(ant_e, pol_e, default)
                    atten_e = default
            if atten_e is None and atten_n is None:
                continue
            try:
                pam.set_attenuation(atten_e, atten_n, verify=verify)
            except(AssertionError, RuntimeError, IOError):
                # Catch errs so an attempt is made for each pam
                failed.append((cnt, ant_e, pol_e, ant_n, pol_n))
        if len(failed) > 0:
            raise RuntimeError('Failed to initialize PAMs on %s: %s' % (
                host, ','.join(['%d=(%s%s/%s%s)' % f for f in failed])))

    def initialize_pams(self, hosts=None, default=8, verify=True,
                        multithread=False, timeout=300.):
        """
        Initialize PAM coefficients.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            default (int): Default PAM attenuation value. Default: 8
            verify (bool): Check success.  Default: True
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds for multithreading.
                             Default: 300.
        """
        hosts = self.get_feng_hostnames(hosts=hosts)
        failed = self._call_on_hosts(
                            target=self.pam_initialize,
                            args=(),
                            kwargs={'verify': verify, 'default':default},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout
        )
        return set(failed) # only return unique hosts

    def fft_shift_pfbs(self, fft_shift=None, verify=True, hosts=None,
                       multithread=False, timeout=300.):
        """
        Set FFT shift schedule in PFBs.

        Inputs:
            fft_shift (int): bitwise shift schedule. Default None pulls
                value from config.
            verify (bool): Check success.  Default: True
            hosts (list): List of hosts to target. Default: all
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds for multithreading.
        """
        if fft_shift is None:
            fft_shift = self.config['fft_shift']
        self.logger.info('Setting fft_shift to %s' % (bin(fft_shift)))
        hosts = self.get_feng_hostnames(hosts=hosts)
        unconfigured = [h for h in self.fengs.keys() if h not in hosts]
        if len(unconfigured) > 0:
            self.logger.warning('Not configuring unconfiged hosts: %s'
                               % (','.join(unconfigured)))
        failed = []
        for host in hosts:
            try:
                self.fengs[host].pfb.set_fft_shift(fft_shift, verify=verify)
            except(AssertionError,RuntimeError):
                self.logger.warning('Failed to set fft_shift on %s.pfb'
                                    % (host))
                failed.append(host)
        return failed

    def adc_align(self, host, reinit=False, force=False, verify=True):
        """
        Align the ADC bit lanes on the specified host.

        Inputs:
            host (str): Host to target.
            reinit (bool): Reinit ADC before aligning. Default: False.
            force (bool): Force reprogram.  Default: False
            verify (bool): Check success.  Default: True
        """
        feng = self.fengs[host]
        self.logger.info("Initializing ADC on %s" % (host))
        if reinit:
            feng.initialize_adc()
        feng.align_adc(force=force, verify=verify)

    def align_adcs(self, hosts=None, reinit=False, verify=True,
                   force=False, multithread=True, timeout=300.):
        """
        Align ADC bit lanes.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            reinit (bool): Reinit ADC before aligning. Default: False.
            verify (bool): Check success.  Default: True
            force (bool): Force reprogram.  Default: False
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds for multithreading.
        """
        hosts = self.get_feng_hostnames(hosts=hosts)
        failed = self._call_on_hosts(
                            target=self.adc_align,
                            args=(),
                            kwargs={
                               'reinit': reinit,
                               'force': force,
                               'verify': verify,
                            },
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout
        )
        return failed

    def dsp_initialize(self, host, force=False, verify=True):
        """
        Initialize DSP on specified host.

        Inputs:
            host (str): Host to target.
            force (bool): Force reprogram.  Default: False
            verify (bool): Check success.  Default: True
        """
        feng = self.fengs[host]
        self.logger.info("Initializing DSP logic on %s" % (host))
        feng.initialize(force=force, verify=verify)
        self.r.hset('status:snap:%s' % host,
                    'last_initialized', time.ctime())

    def initialize_dsps(self, verify=True, hosts=None, force=False,
                        multithread=False, timeout=300.):
        """
        Initialize DSPs.

        Inputs:
            verify (bool): Check success.  Default: True
            hosts (list): List of hosts to target. Default: all
            force (bool): Force reprogram.  Default: False
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds for multithreading.
                             Default: 300.
        """
        hosts = self.get_feng_hostnames(hosts=hosts)
        unconfigured = [h for h in self.fengs.keys() if h not in hosts]
        if len(unconfigured) > 0:
            self.logger.warning('Not initializing unconfiged hosts: %s'
                               % (','.join(unconfigured)))
        failed = self._call_on_hosts(
                            target=self.dsp_initialize,
                            args=(),
                            kwargs={
                               'force': force,
                               'verify': verify,
                            },
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout
        )
        return failed

    def _hookup_from_redis(self):
        """
        Generate a mapping of antenna names to F-engines.
        """
        hookup = redis_cm.read_maps_from_redis(self.r)
        assert(hookup is not None) # antenna hookup missing in redis
        self.ant_to_snap = hookup['ant_to_snap']
        self.snap_to_ant = {key: [(int(v[2:-1]), v[-1].lower())
                                        if v is not None else (None, None)
                                        for v in val]
                            for key,val in hookup['snap_to_ant'].items()}

    def _verify_config(self):
        """
        Do some basic sanity checking on the currently loaded config.
        """
        # Check that there are only three antennas per board
        for host, prms in self.config['fengines'].items():
            if 'ants' in prms.keys():
                assert(len(prms['ants']) == 3)
        # Check that there are only 48 channels per x-engine.
        for host, params in self.config['xengines'].items():
            if 'chan_range' in params.keys():
                chan_range = params['chan_range']
                assert(chan_range[1] - chan_range[0] <= 384)

    def _eth_config_dest(self, host, source_ports, dest_port, xinfo,
                         force=False, verify=False):
        """
        Configure F-Engine destination packet slots on specified host.

        Inputs:
            host (str): Host to target.
            source_ports (int): Ports to use on F-Engine side
            dest_port (int): Port to use on X-Engine side
            xinfo (dict): Dictonary of info about X-Engines
            force (bool): Force reprogram.  Default: False
            verify (bool): Check success.  Default: False
        """
        feng = self.fengs[host]
        if force:
            feng._set_dest_configured(0)
        if feng.dest_is_configured():
            return
        source_port = source_ports[host]
        feng.eth.set_source_port(source_port, verify=verify)
        feng.eth.set_port(dest_port, verify=verify)
        failed = []
        for xn, xval in xinfo.items():
            chans = xval['chans']
            ip_even = xval['ip_even']
            ip_odd = xval['ip_odd']
            mac_even = xval['mac_even']
            mac_odd = xval['mac_odd']

            self.logger.info(
                '%s: Setting Xengine %d: ch %d-%d: %s (even) / %s (odd)' \
                % (host, xn, chans[0], chans[-1], ip_even, ip_odd)
            )
            # Update redis to reflect current assignments
            self.r.hset("corr:snap_ants", host,
                        json.dumps(feng.ant_indices))
            try:
                feng.assign_dest(xn, chans, [ip_even,ip_odd], verify=verify)
                feng.eth.add_arp_entry(ip_even, mac_even, verify=verify)
                feng.eth.add_arp_entry(ip_odd, mac_odd, verify=verify)
            except(AssertionError, RuntimeError) as e:
                failed.append((xn, e.message))
        if len(failed) > 0:
            raise RuntimeError('Failed to configure %s.eth: %s' % (
                host, '\n'.join(['xeng[%d]: %s' % f for f in failed])))
        else:
            feng._set_dest_configured(1)

    def config_dest_eths(self, hosts=None, verify=True, force=False,
                        multithread=False, timeout=300.):
        """
        Configure ethernet destinations.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            verify (bool): Check success.  Default: True
            force (bool): Force reprogram.  Default: False
            multithread (bool): Multithread across hosts. Default: True
            timeout (float): Timeout in seconds for multithreading.
                             Default: 300.
        """
        hosts = self.get_feng_hostnames(hosts=hosts)
        unconfigured = [h for h in self.fengs.keys() if h not in hosts]
        if len(unconfigured) > 0:
            self.logger.warning('Not configuring eth on unconfiged hosts: %s'
                               % (','.join(unconfigured)))
        dest_port = self.config['dest_port']
        # Map fengs to ports
        source_ports = {
            # if source port unspecified, auto-increment mod 4
            h: self.config['fengines'][h].get('source_port',
                                              dest_port + (cnt % 4))
            for cnt,h in enumerate(self.fengs.keys())
        }
        # Extract xeng channel mappings, ips, and macs
        n_xengs = self.config.get('n_xengs', 16)
        assert(len(self.config['xengines'].items()) == n_xengs)
        chans_per_packet = self.config.get('chans_per_packet', 384)
        assert(chans_per_packet == 384) # Hardcoded in firmware
        xinfo = {} # holds what an feng needs to be configured
        # Clear current mapping and generate new one
        self.r.delete("corr:xeng_chans")
        for xn, xparams in self.config['xengines'].items():
            xinfo[xn] = {}
            ch0,ch1 = xparams.get('chan_range', (xn*384, (xn+1)*384))
            xinfo[xn]['chans'] = chans = range(ch0, ch1)
            self.r.hset("corr:xeng_chans", str(xn), json.dumps(chans))
            ip = [int(i) for i in xparams['even']['ip'].split('.')]
            ip_even = (ip[0] << 24) + (ip[1] << 16) + (ip[2] << 8) + ip[3]
            xinfo[xn]['ip_even'] = ip_even
            ip = [int(i) for i in xparams['odd']['ip'].split('.')]
            ip_odd = (ip[0] << 24) + (ip[1] << 16) + (ip[2] << 8) + ip[3]
            xinfo[xn]['ip_odd'] = ip_odd
            xinfo[xn]['mac_even'] = xparams['even']['mac']
            xinfo[xn]['mac_odd'] = xparams['odd']['mac']
        # Clear current mapping and generate new one
        self.r.delete("corr:snap_ants")
        failed = self._call_on_hosts(
                            target=self._eth_config_dest,
                            args=(source_ports, dest_port, xinfo),
                            kwargs={'verify': verify, 'force': force},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout
        )
        return failed

    def sync(self, manual=False, hosts=None, maxtime=0.8):
        """
        Synchronize boards to PPS.

        Inputs:
            manual (bool): synchronize to software trigger instead of
                external PPS. Default: False
            hosts (list): List of hosts to target. Default: all
            maxtime (float): Max seconds to wait for a sync. Default: 0.8
        """
        self.logger.info('Synchronizing F-Engines')
        hosts = self.get_feng_hostnames(hosts=hosts)
        unconfigured = [h for h in self.fengs.keys() if h not in hosts]
        if len(unconfigured) > 0:
            self.logger.warning('Not syncing unconfiged hosts: %s'
                               % (','.join(unconfigured)))
        for host in hosts:
            self.fengs[host].sync.set_delay(0)
        if not manual:
            # Wait for a sync to pass to arm between 1PPS edges
            self.logger.info('Waiting for PPS (t=%.2f)' % time.time())
            # this is hanging forever if ADC is not configured
            # consider adding a timeout
            self.fengs.values()[0].sync.wait_for_sync()
        start = time.time()
        self.logger.info('Sync passed (t=%.2f)' % (start))
        # Consider multithreading if gets too slow
        for host in hosts:
            self.fengs[host].sync.arm_sync()
        elapsed_time = time.time() - start
        if not manual:
            # XXX use sync.count to verify no sync has passed
            if elapsed_time > maxtime:
                raise RuntimeError("Sync time (%.2f) exceeded max (%.2f)"\
                                   % (elapsed_time, maxtime))
            sync_time = int(start) + 1 + 3  # Takes 3 PPS pulses to arm
        else:
            self.logger.warning('Using manual sync trigger')
            for i in range(3):  # takes 3 syncs to trigger
                for host in hosts:
                    self.fengs[host].sync.sw_sync()
            sync_time = int(time.time())  # roughly  # noqa
        # Store sync time in ms
        self.r['corr:feng_sync_time'] = 1000 * sync_time # ms
        self.r['corr:feng_sync_time_str'] = time.ctime(sync_time)
        self.r['feng:sync_time'] = sync_time # in UTC seconds

    def sync_noise(self, manual=False, hosts=None, maxtime=0.8):
        """
        Synchronize internal noise generators to PPS.

        Inputs:
            manual (bool): synchronize to software trigger instead of
                external PPS. Default: False
            hosts (list): List of hosts to target. Default: all
            maxtime (float): Max seconds to wait for a sync. Default: 0.8
        """
        self.logger.info('Synchronizing noise generators')
        hosts = self.get_feng_hostnames(hosts=hosts)
        if not manual:
            self.logger.info('Waiting for PPS (t=%.2f)' % time.time())
            self.fengs.values()[0].sync.wait_for_sync()
        start = time.time()
        self.logger.info('Sync passed (t=%.2f)' % (start))
        for host in hosts:
            self.fengs[host].sync.arm_noise()
        elapsed_time = time.time() - start
        if not manual:
            if elapsed_time > maxtime:
                raise RuntimeError("Sync time (%.2f) > maximum (%.2f)" %
                                   (elapsed_time, maxtime))
        else:
            self.logger.warning('Using manual sync trigger')
            for i in range(3):  # takes 3 syncs to trigger
                for host in hosts:
                    self.fengs[host].sync.sw_sync()
            sync_time = int(time.time())  # roughly  # noqa
        self.logger.info('Synchronized noise.')

    def enable_eths(self, hosts=None, verify=True):
        """
        Enable ethernet outputs.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            verify (bool): Check success.  Default: False
        """
        self.logger.info('Enabling ethernet output')
        # Only enable snaps that are fully configured
        hosts = self.get_feng_hostnames(hosts=hosts, adc_aligned=True,
                                        dest_configed=True)
        unconfigured = [h for h in self.fengs.keys() if h not in hosts]
        if len(unconfigured) > 0:
            self.logger.warning('Not enabling eths on unconfiged hosts: %s'
                               % (','.join(unconfigured)))
        failed = []
        for host in hosts:
            try:
                assert host not in unconfigured
                self.fengs[host].eth.enable_tx(verify=verify)
            except(AssertionError, RuntimeError):
                self.logger.warning('Failed to enable %s.eth' % (host))
                failed.append(host)
        return failed

    def disable_eths(self, hosts=None, verify=True):
        """
        Disableall ethernet outputs.

        Inputs:
            hosts (list): List of hosts to target. Default: all
            verify (bool): Check success.  Default: False
        """
        self.logger.info('Disabling ethernet output')
        hosts = self.get_feng_hostnames(hosts=hosts)
        failed = []
        for host in hosts:
            try:
                self.fengs[host].eth.disable_tx(verify=verify)
            except(AssertionError):
                self.logger.warning('Failed to enable %s.eth' % (host))
                failed.append(host)
        return failed
