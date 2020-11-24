"""HeraCorrelator."""

import logging
import os
import time
import socket
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
from casperfpga import utils

LOGGER = add_default_log_handlers(logging.getLogger(__name__))
TEMP_BITSTREAM_STORE = "/tmp/" # location to store bitfiles from redis


class HeraCorrelator(object):
    """HERA Correlator control class."""


    def __init__(self, hosts=None, redishost='redishost', config=None, logger=LOGGER,
                 passive=False, use_redis=False, block_monitoring=True):
        """
        Instantiate a HeraCorrelator instance.

        optional inputs:
            redishost (str): Hostname (or IP address) or redis database.
            config (str): Path to configuration file. If None, config will be grabbed from redis.
            logger (logging.Logger): Logging object this class will use.
            passive (Boolean): If True, won't connect to SNAPs. If False, will establish
                SNAP connections and check the connected boards are alive.
            use_redis (Boolean): If True, will use a redis proxy (at `redishost`) for talking to
            SNAP boards, rather than direct TFTP.
            block_monitoring (Boolean): If True, will disable monitoring before connecting to boards
        """
        self.logger = logger
        self.redishost = redishost
        self.r = redis.Redis(redishost, decode_responses=True)
        # also keep a non-decoded redis connection for reading
        # values with byte-strings like the .fpg files
        self.r_bytes = redis.Redis(redishost, decode_responses=False)
        self.use_redis = use_redis
        self.passive = passive

        self.fengs = {}
        self.get_config(config) # sets self.config with result
        self.set_default_progfile() # sets self._progfile from config

        if not passive:
            if block_monitoring:
                self.disable_monitoring(60, verify=True)
            self._hookup_from_redis()
            self._unconnected = self.connect_fengs(hosts=hosts)


    def get_config(self, config=None, verify=True):
        """
        Parse a configuration file and set self.config accordingly.

        inputs:
            config (str): Path to configuration file. If None, 
                configuration will be pulled from redis.
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
        # XXX not supporting auto assignment of antenna indices
        ant_indices = self.config['fengines'][host]['ants']
        self.logger.info("Connecting %s with antenna indices %s" % 
                         (host, ant_indices))
        if self.use_redis:
            redishost = self.redisthost
        else:
            redishost = None
        feng = SnapFengine(host, ant_indices=ant_indices,
                           redishost=redishost)
        if feng.fpga.is_connected():
            self.fengs[host] = feng # single dict call is threadsafe
        elif verify:
            raise RuntimeError('Failed to connect: %s' % (host))

    def _call_on_hosts(self, target, args, kwargs,
                       hosts, multithread, timeout):
        q = Queue()
        def wrap_target(host, args, kwargs):
            '''Wrapper to capture target output and exceptions.'''
            try:
                # Automatically puts host as first argument
                val = target(host, *args, **kwargs)
                q.put((host,val))
            except(RuntimeError,AssertionError) as e:
                self.logger.warning('%s: %s' % (host, e.message))
        threads = {host: Thread(
                            target=wrap_target,
                            args=(host, args, kwargs),
                         ) for host in hosts}
        for thread in threads.values():
            if multithread:
                thread.daemon = True
            thread.start()
            # XXX add some sleep here?
            # serialize execution if we are not multithreading
            if not multithread:
                thread.join(timeout)
        if multithread:
            for host,thread in threads.items():
                thread.join(timeout)
            # XXX think about killing live threads
        successes = set([q.get()[0] for i in range(q.qsize())])
        failed = [host for host in hosts if not host in successes]
        if len(failed) > 0:
            self.logger.warning('Call %s failed on: %s'
                                % (target.__name__, ','.join(failed)))
        return failed

    def connect_fengs(self, hosts=None,
                          multithread=False, timeout=300.):
        """Connect to SNAP boards listed in the current configuration."""
        # Instantiate CasperFpga connections to all the F-Engine.
        
        if hosts is None:
            hosts = [host for host in self.config['fengines']
                        if not host in self.fengs]
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
                        verify=True, sleep=20):
        """
        Inputs:
            progfile (str): Path to fpga file to program. If None, the
                bitstream in current config will be used.
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
        # XXX need to check how this behaves in real life
        # XXX it may lie and say it programmed when it didn't
        # XXX it might also try multiple times and/or revert to golden image
        # this call should block until success
        feng.fpga.upload_to_ram_and_program(progfile)
        # XXX maybe not do this b/c of multithreading
        feng.initialize_adc() # configures synth/clk and reprograms FPGA
        if verify:
            #time.sleep(sleep) # probably unnecessary
            # XXX could also check version of programmed image against
            # XXX current version
            if not feng.fpga.is_running():
                raise RuntimeError('Failed to program FPGA: %s' % (host))
            self.r.hset('status:snap:%s' % host,
                        'last_programmed', time.ctime())

    def program_fengs(self, hosts=None, progfile=None, force=False,
                      multithread=True, timeout=300.):
        """
        Program SNAPs.

        Inputs:
            progfile (str): Path to fpga file to program. If None, the
                bitstream in current config will be used.
        """
        if hosts is None:
            hosts = self.fengs.keys()
        failed = self._call_on_hosts(
                            target=self.feng_program,
                            args=(),
                            kwargs={
                                'progfile': progfile,
                               'force': force, # prefiltered list
                               'verify': True,
                               'sleep': 0.,
                            },
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout,
        )
        return failed

    def disable_monitoring(self, expiry=60, verify=True, timeout=60):
        """
        Set the "disable_monitoring" key in redis. Asks other processes
        to respect this key and stop monitoring (which can interfere
        with TFTP traffic).
        Inputs:
            expiry (float): Period (in seconds) to disable monitoring
            wait (bool): Wait for monitor script confirmation
        """
        self.r.set('disable_monitoring', 1, ex=expiry)
        if verify: # XXX is this necessary
            start = time.time()
            while self.is_monitoring():
                if time.time() > (start + timeout):
                    raise RuntimeError('Timed out waiting for monitor to stop')
                time.sleep(1)
            return

    def enable_monitoring(self):
        """Delete the "disable_monitoring" key in redis."""
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
        self.logger.info('Disabling phase switch on %s' % (host))
        feng = self.fengs[host]
        feng.phase_switch.disable_mod(verify=verify)
        feng.phase_switch.disable_demod(verify=verify)
        
    def disable_phase_switches(self, hosts=None, verify=True,
                               multithread=False, timeout=300.):
        """Disable all phase switches."""
        if hosts is None:
            hosts = self.fengs.keys()
            self.r.hmset('corr:status_phase_switch',
                         {'state':'off', 'time':time.time()})
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

    def enable_phase_switches(self, hosts=None, verify=True,
                               multithread=False, timeout=300.):
        """Enable all phase switches."""
        if hosts is None:
            hosts = self.fengs.keys()
            self.r.hmset('corr:status_phase_switch',
                         {'state':'on', 'time':time.time()}
            )
        failed = self._call_on_hosts(
                            target=self.phase_switch_enable,
                            args=(),
                            kwargs={'verify': True},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout,
        )
        return failed

    def switch_fems(self, mode, east=True, north=True, verify=True,
                    hosts=None, multithread=False, timeout=300.):
        assert(mode in ('load', 'noise', 'antenna'))
        if hosts is None:
            hosts = self.fengs.keys()
            # Assuming we will succeed in setting entire array to fem state
            t = time.time()
            self.r.hmset('corr:fem_switch_state',
                         {'state': mode, 'time': t})
        failed = []
        for host in hosts:
            for cnt,fem in enumerate(self.fengs[host].fems):
                self.logger.info('Switching %s.fem[%d] to %s' %
                                 (host, cnt, mode)) 
                try:
                    # will error if verification fails
                    fem.switch(mode, east=east, north=north, verify=verify)
                except(RuntimeError,AssertionError,IOError):
                    self.logger.warning('Failed to switch %s.fem[%d]' %
                                        (host, cnt)) 
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
        redval, redtime = self.r.hmget("atten:ant:%s:%s" % (ant, pol),
                                       "commanded", "command_time")
        if redval is None:
            raise RuntimeError('Failed to find PAM settings for (%s,%s)' %
                               (str(ant), pol))
        return int(redval)

    def store_pam_attenuation(self, ant, pol, attenuation):
        self.logger.info("Commanding (%s,%s) PAM atten=%d dB in redis" \
                         % (str(ant), pol, str(atten)))
        self.r.hmset("atten:ant:%s:%s" % (ant, pol),
                     {"commmanded": str(attenuation),
                      "command_time": time.time()}
        )

    def get_pam_attenuation(self, ant, pol, log_to_redis=True):
        host, stream = self.lookup_ant_host_stream(ant, pol)
        pam = self.fengs[host].pam[stream//2]
        east, north = pam.get_attenuation()
        atten = (east, north)[stream % 2]
        if log_to_redis:
            self.logger.info("Logging (%s,%s) PAM atten=%d dB to redis" \
                             % (str(ant), pol, str(atten)))
            self.r.hmset('atten:ant:%s:%s' % (ant, pol),
                         {'value': str(atten), 'time': time.time()})
        return atten

    def set_pam_attenuation(self, ant, pol, attenuation,
                            verify=True, safe=True, update_redis=True):
        self.logger.info("Setting PAM for (%s,%s)" % (ant, pol))
        host, stream = self.lookup_ant_host_stream(ant, pol)
        pam = self.fengs[host].pam[stream//2]
        east_north = pam.get_attenuation()
        if safe:
            # make sure we read the same value as commanded
            if pam._cached_atten is not None:
                assert(east_north == pam._cached_atten)
            else:
                other_stream = 2*(stream // 2) + ((stream + 1) % 2)
                other = self.fengs[host].ants[other_stream]
                # fails if PAM not reading value it was initialized to
                assert(east_north[other_stream % 2] == \
                       self.lookup_pam_attenuation(*other))
        east_north[stream % 2] = attenuation
        pam.set_attenuation(*east_north, verify=verify)
        if update_redis:
            self.store_pam_attenuation(ant, pol, attenuation)

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

    def store_eq_coeffs(self, ant, pol, coeffs):
        """
        Store the EQ coefficients of an antenna and polarization to
        redis.

        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
           coeffs: EQ vector (numpy.array)
        """
        self.r.hmset('eq:ant:%s:%s' % (ant, pol),
                     {'values': json.dumps(coeffs.tolist()),
                      'time': time.time()})

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

    def set_eq_coeffs(self, ant, pol, coeffs, verify=False):
        """
        Write the EQ coefficients of an antenna and polarization to
        the FPGA stream mapped to it.

        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
           coeffs: EQ vector (numpy.array)
        """
        self.logger.info("Setting EQ for (%s,%s)" % (ant, pol))
        host, stream = self.lookup_ant_host_stream(ant, pol)
        coeffs = np.ones(feng.eq.ncoeffs) * coeffs # broadcast shape
        self.fengs[host].eq.set_coeffs(stream, coeffs, verify=verify)

    def eq_initialize(self, host, verify=True):
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
        if hosts is None:
            hosts = self.fengs.keys()
        failed = self._call_on_hosts(
                            target=self.eq_initialize,
                            args=(),
                            kwargs={'verify': verify},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout
        )
        return failed

    def pam_initialize(self, host, verify=True):
        self.logger.info("Initializing PAMs on %s" % (host))
        feng = self.fengs[host]
        antpols = self.snap_to_ant[host]
        failed = []
        for cnt,pam in enumerate(feng.pams):
            (ant_e, pol_e) = antpols[2*cnt]
            (ant_n, pol_n) = antpols[2*cnt + 1]
            atten_e, atten_n = None, None
            if ant_e is not None:
                atten_e = self.lookup_pam_attenuation(ant_e, pol_e)
            if ant_n is not None:
                atten_n = self.lookup_pam_attenuation(ant_n, pol_n)
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

    def initialize_pams(self, hosts=None, verify=True,
                        multithread=False, timeout=300.):
        if hosts is None:
            hosts = self.fengs.keys()
        failed = self._call_on_hosts(
                            target=self.pam_initialize,
                            args=(),
                            kwargs={'verify': verify},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout
        )
        return set(failed) # only return unique hosts

    def fft_shift_pfbs(self, fft_shift=None, verify=True, hosts=None,
                       multithread=False, timeout=300.):
        if fft_shift is None:
            fft_shift = self.config['fft_shift']
        self.logger.info('Setting fft_shift to %s' % (bin(fft_shift)))
        if hosts is None:
            hosts = self.fengs.keys()
        failed = []
        for host in hosts:
            try:
                self.fengs[host].pfb.set_fft_shift(fft_shift, verify=verify)
            except(AssertionError):
                self.logger.warning('Failed to set fft_shift on %s.pfb'
                                    % (host)) 
                failed.append(host)
        return failed

    def adc_align(self, host, reinit=False, force=False, verify=True):
        feng = self.fengs[host]
        self.logger.info("Initializing ADC on %s" % (host))
        if reinit:
            feng.initialize_adc()
        feng.align_adc(force=force, verify=verify)
        
    def align_adcs(self, hosts=None, reinit=False, verify=True, force=False,
                        multithread=False, timeout=300.):
        if hosts is None:
            hosts = self.fengs.keys()
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
        feng = self.fengs[host]
        self.logger.info("Initializing DSP logic on %s" % (host))
        feng.initialize(force=force, verify=verify)
        self.r.hset('status:snap:%s' % host,
                    'last_initialized', time.ctime())

    def initialize_dsps(self, verify=True, hosts=None, force=False,
                        multithread=False, timeout=300.):
        if hosts is None:
            hosts = self.fengs.keys()
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
        """Generate an antenna-map from antenna names to Fengine instances."""
        hookup = redis_cm.read_maps_from_redis(self.r)
        assert(hookup is not None) # antenna hookup missing in redis
        self.ant_to_snap = hookup['ant_to_snap']
        self.snap_to_ant = {key: [(int(v[2:-1]), v[-1].lower())
                                        if v is not None else (None, None)
                                        for v in val]
                            for key,val in hookup['snap_to_ant'].items()}
        #for ant in self.ant_to_snap.keys():
        #    for pol in self.ant_to_snap[ant].keys():
        #        host = self.ant_to_snap[ant][pol]['host']
        #        if host in self.fengs:
        #            self.ant_to_snap[ant][pol]['host'] = host
        # Make the snap->ant dict, but make sure the hostnames match what
        # is expected by this class's Fengines
        #for hooked_up_snap in hookup['snap_to_ant'].keys():
        #        for host in self.fengs:
        #            self.snap_to_ant[host] = hookup['snap_to_ant'][hooked_up_snap]
        #            self.fengs[host].ants = self.snap_to_ant[host]
        ## Fill any unconnected SNAPs with Nones
        #for host in self.fengs:
        #    if host not in self.snap_to_ant.keys():
        #        self.snap_to_ant[host] = [None] * 6

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
                         verify=False):
        """Configure F-Engine destination packet slots."""
        feng = self.fengs[host]
        source_port = source_ports[host]
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
                feng.packetizer.assign_slot(xn, chans, [ip_even,ip_odd],
                            feng.reorder, feng.ant_indices[0], verify=verify)
                feng.eth.add_arp_entry(ip_even, mac_even, verify=verify)
                feng.eth.add_arp_entry(ip_odd, mac_odd, verify=verify)
                feng.eth.set_source_port(source_port, verify=verify)
                feng.eth.set_port(dest_port, verify=verify)
            except(AssertionError, RuntimeError) as e:
                failed.append((xn, e.message))
        if len(failed) > 0:
            raise RuntimeError('Failed to configure %s.eth: %s' % (
                host, '\n'.join(['xeng[%d]: %s' % f for f in failed])))

    def config_dest_eths(self, hosts=None, verify=True, force=False,
                        multithread=False, timeout=300.):
        if hosts is None:
            hosts = self.fengs.keys()
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
        self.r.delete("corr:xeng_chans")
        failed = self._call_on_hosts(
                            target=self._eth_config_dest,
                            args=(source_ports, dest_port, xinfo),
                            kwargs={'verify': verify},
                            hosts=hosts,
                            multithread=multithread,
                            timeout=timeout
        )
        return failed


#    def configure_freq_slots(self, multithread=True):
#        """Configure F-Engine destination packet slots."""
#        n_xengs = self.config.get('n_xengs', 16)
#        chans_per_packet = self.config.get('chans_per_packet', 384)
#        assert(chans_per_packet == 384) # Hardcoded in firmware
#        self.logger.info('Configuring frequency slots for %d X-engines, %d channels per packet' % (n_xengs, chans_per_packet))
#        dest_port = self.config['dest_port']
#        self.r.delete("corr:snap_ants")
#        self.r.delete("corr:xeng_chans")
#        for xn, xparams in self.config['xengines'].items():
#            chan_range = xparams.get('chan_range', [xn*384, (xn+1)*384])
#            chans = range(chan_range[0], chan_range[1])
#            self.r.hset("corr:xeng_chans", str(xn), json.dumps(chans))
#            assert(xn <= n_xengs) # Too many x-engines listed
#            ip = [int(i) for i in xparams['even']['ip'].split('.')]
#            ip_even = (ip[0] << 24) + (ip[1] << 16) + (ip[2] << 8) + ip[3]
#            ip = [int(i) for i in xparams['odd']['ip'].split('.')]
#            ip_odd = (ip[0] << 24) + (ip[1] << 16) + (ip[2] << 8) + ip[3]
#
#            for fn, feng in enumerate(self.fengs):
#                self.logger.info('%s: Setting Xengine %d: chans %d-%d: %s (even) / %s (odd)' % (feng.fpga.host, xn, chans[0], chans[-1], xparams['even']['ip'], xparams['odd']['ip']))
#                # Update redis to reflect current assignments
#                self.r.hset("corr:snap_ants", feng.host, json.dumps(feng.ant_indices))
#                # if the user hasn't specified a source port, auto increment mod 4
#                source_port = self.config['fengines'][feng.host].get('source_port', dest_port + (fn % 4))
#                if not multithread:
#                    # if not multithreading use the original packetizer method, which is known good.
#                    feng.packetizer.assign_slot(xn, chans, [ip_even,ip_odd], feng.reorder, feng.ant_indices[0])
#                    feng.eth.add_arp_entry(ip_even, xparams['even']['mac'])
#                    feng.eth.add_arp_entry(ip_odd, xparams['odd']['mac'])
#            if multithread:
#                self.do_for_all_f("assign_slot", args=[xn, chans, [ip_even, ip_odd]])
#                self.do_for_all_f("add_arp_entry", block="eth", args=[ip_even, xparams['even']['mac']])
#                self.do_for_all_f("add_arp_entry", block="eth", args=[ip_odd, xparams['odd']['mac']])
#
#        if not multithread:
#            for fn, feng in enumerate(self.fengs):
#                feng.eth.set_source_port(source_port)
#                feng.eth.set_port(dest_port)
#        else:
#            self.do_for_all_f("set_source_port", block="eth", args=[source_port])
#            self.do_for_all_f("set_port", block="eth", args=[dest_port])
#                
#        return True

    def sync(self, manual=False, hosts=None, maxtime=0.8):
        """
        Synchronize boards to PPS.

        Inputs:
            manual (Boolean): synchronize to software trigger instead of
                external PPS.
        """
        self.logger.info('Synchronizing F-Engines')
        if hosts is None:
            hosts = self.fengs.keys()
        unconfigured = [host for host in hosts
                            if not self.fengs[host].adc_is_configured()]
        if len(unconfigured) > 0:
            raise RuntimeError('ADCs not initialized on: %s'
                               % (','.join(unconfigured)))
        for host in hosts:
            # self.fengs[host].sync.change_period(0) # already done in initialize_dsps
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
        for host,feng in self.fengs.items():
            feng.sync.arm_sync()
        sync_time = time.time() - start
        if not manual:
            # XXX use sync.count to verify no sync has passed
            if sync_time > maxtime:
                raise RuntimeError("Sync time (%.2f) exceeded max (%.2f)" %
                                   (sync_time, maxtime))
            sync_time = int(start) + 1 + 3  # Takes 3 PPS pulses to arm
        else:
            self.logger.warning('Using manual sync trigger')
            for i in range(3):  # takes 3 syncs to trigger
                for host,feng in self.fengs.items():
                    feng.sync.sw_sync()
            sync_time = int(time.time())  # roughly  # noqa
        # Store sync time in ms
        self.r['corr:feng_sync_time'] = 1000 * sync_time # ms
        self.r['corr:feng_sync_time_str'] = time.ctime(sync_time)

#    def sync_with_delay(self, sync_time_s, delay_ms, adc_clk_rate=500e6, adc_demux=2):
#        """
#        Resync all boards at the integer UNIX time `sync_time_s`.
#
#        Delays the internal trigger until `delay_clocks` fpga
#        clocks after the PPS pulse.
#        """
#        if (delay_ms > 1000):
#            self.logger.error("I refuse to sync with a delay > 1 second")
#            return
#        sync_delay_fpga_clocks = (delay_ms / 1e3) / (adc_clk_rate / adc_demux)
#        target_sync_time_ms = sync_time_s*1000 + (sync_delay_fpga_clocks*(adc_clk_rate / adc_demux))  # sync time in unix ms
#        self.do_for_all_f("set_delay", block="sync", args=(sync_delay_fpga_clocks,))
#        if (time.time()+5) > (target_sync_time_ms/1000.):
#            self.logger.error("I refuse to sync less than 5s in the future")
#            return
#        if (time.time()+120) < (target_sync_time_ms/1000.):
#            self.logger.error("I refuse to sync more than 120s in the future")
#            return
#        # it takes 3 PPS pulses to arm. Arm should occur < 4 seconds and > 3 seconds before sync target
#        now = time.time()
#        time_to_sync = sync_time_s - now - 4
#        time.sleep(time_to_sync + 0.1)  # This should be 3.9 seconds before target PPS
#        time_before_arm = time.time()
#        self.logger.info("Arming sync at %.2f" % time_before_arm)
#        self.do_for_all_f("arm_sync", "sync")
#        time_after_arm = time.time()
#        self.logger.info("Finished arming sync at %.2f" % time_after_arm)
#        self.logger.info('Syncing took %.2f seconds' % (time_after_arm - time_before_arm))
#        if time_after_arm - time_before_arm > 0.5:
#            self.logger.warning("It took longer than expected to arm sync!")
#        # Update sync time -- in ms!!!!
#        sync_time_ms = 1000*(int(time_before_arm) + 1 + 3) + delay_ms
#        self.r['corr:feng_sync_time'] = sync_time_ms
#        self.r['corr:feng_sync_time_str'] = time.ctime(sync_time_ms/1000.)
#        return sync_time_ms

    def sync_noise(self, manual=False, maxtime=0.8):
        """
        Synchronize internal noise generators to PPS.

        Inputs:
            manual (Boolean): synchronize to software trigger instead of
                external PPS.
        """
        self.logger.info('Synchronizing noise generators')
        if not manual:
            self.logger.info('Waiting for PPS (t=%.2f)' % time.time())
            self.fengs.values()[0].sync.wait_for_sync()
        start = time.time()
        self.logger.info('Sync passed (t=%.2f)' % (start))
        for feng in self.fengs:
            feng.sync.arm_noise()
        sync_time = time.time() - start
        if not manual:
            if sync_time > maxtime:
                raise RuntimeError("Sync time (%.2f) > maximum (%.2f)" %
                                   (sync_time, maxtime))
        else:
            self.logger.warning('Using manual sync trigger')
            for i in range(3):  # takes 3 syncs to trigger
                for feng in self.fengs:
                    feng.sync.sw_sync()
            sync_time = int(time.time())  # roughly  # noqa
        self.logger.info('Synchronized in %.2f seconds' % 
                         (after_sync - before_sync))

    def enable_eths(self, hosts=None, verify=True):
        """Enable all ethernet outputs."""
        self.logger.info('Enabling ethernet output')
        if hosts is None:
            hosts = self.fengs.keys()
        failed = []
        for host in hosts:
            try:
                self.fengs[host].eth.enable_tx(verify=verify)
            except(AssertionError):
                self.logger.warning('Failed to enable %s.eth' % (host)) 
                failed.append(host)
        return failed

    def disable_eths(self, hosts=None, verify=True):
        """Disable all ethernet outputs."""
        self.logger.info('Disabling ethernet output')
        if hosts is None:
            hosts = self.fengs.keys()
        failed = []
        for host in hosts:
            try:
                self.fengs[host].eth.disable_tx(verify=verify)
            except(AssertionError):
                self.logger.warning('Failed to enable %s.eth' % (host)) 
                failed.append(host)
        return failed
