import logging
import os
import time
import socket
import redis
import yaml
import json
import helpers
import hashlib
from hera_corr_f import SnapFengine
import numpy as np
from casperfpga import utils

LOGGER = helpers.add_default_log_handlers(logging.getLogger(__name__))

class HeraCorrelator(object):
    def __init__(self, redishost='redishost', config=None, logger=LOGGER, passive=False, use_redis=True):
        """
        Instantiate a HeraCorrelator instance.
        optional inputs:
            redishost (str): Hostname (or IP address) or redis database.
            config (str): Path to configuration file. If None, config will be grabbed from redis.
            logger (logging.Logger): Logging object this class will use.
            passive (Boolean): If True, won't connect to SNAPs. If False, will establish SNAP connections and check the connected boards are alive.
            use_redis (Boolean): If True, will use a redis proxy (at `redishost`) for talking to SNAP boards, rather than direct TFTP.
        """
        self.logger = logger
        self.redishost = redishost
        self.r = redis.Redis(redishost)

        self.get_config(config)

        # Lists of connected SnapFengine objects
        self.fengs = []
        # Dictionary of {hostname: time (float)} where keys are hostnames
        # of dead boards and time entries are unix times when the host was declared dead
        self.dead_fengs = {}
        
        if not passive:
            self.establish_connections(use_redis=use_redis)
            # Get antenna<->SNAP maps
            self.compute_hookup()

        self.config_is_valid= self._verify_config()

    def do_for_all_f(self, method, block=None, block_index=None, args=(), kwargs={}, timeout=3, dead_count_threshold=3, check_programmed=False):
        """
        Call `method` against all F-Engine instances.
        inputs:
            method (str): Method to call
            block (str or None): What block should the method call -- eg SnapFengine.`block`.`method`(...).
                         Use None to indicate that the call is against the SnapFengine instance directly
            block_index (int): Use to specify an index if the SnapFengine.`block` attribute is a list
            args (tuple): positional arguments to pass to the underlying method
            kwargs (dict): keyword arguments to pass to the underlying method
            timeout (float): Timeout in seconds
            dead_count_threshold (int): Number of failed connection attempts allowed before declaring an F-Engine dead. Set to None to skip error tracking
            check_programmed (bool): Set to True to call against only programmed F-Engines
        returns:
            dictionary of return values from the underlying method. Keys are f-engine hostnames.
            If *any* fengines fail to return before timeout, then this method returns None
        """
        # If all fengs are dead, leave.
        if len(self.fengs) == 0:
            return {}
        # Look for the block we're calling methods against
        # If block is None, we're calling against SnapFengine objects. If it's a string,
        # we're calling against some block class
        # TODO: We only check the first instance, and assume the others are the same
        if block is None:
            if not check_programmed:
                instances = self.fengs
            else:
                instances = [feng for feng in self.fengs if feng.is_programmed()]
        else:
            if not hasattr(self.fengs[0], block):
                return None
            if not check_programmed:
                instances = [getattr(f, block) for f in self.fengs]
            else:
                instances = [getattr(f, block) for f in self.fengs if f.is_programmed()]
        # If the instances are themselves lists, demand the user specify a block index
        #TODO just checking the first entry
        if isinstance(instances[0], list):
            if block_index is None:
                self.logger.error("Instances of block %s are lists, but no block_index was specified!" % block)
                return None
            else:
                temp = [instance[block_index] for instance in instances]
                instances = temp
        
        # Check that the method is an attribute (may or may not be callable)
        if not hasattr(instances[0], method):
            return None

        rv = {} # return value dictionary
        # Check if the method is callable. If so, call
        # if not, just get the attribute for all FEngines in a single-threaded manner
        if not callable(getattr(instances[0], method)):
            for instance in instances:
                if isinstance(instance.host, basestring):
                    rv[instance.host] = instance.__getattribute__(method)
                else:
                    rv[instance.host.host] = instance.__getattribute__(method)
        else:
            try:
                x = utils.threaded_fpga_function(instances, timeout, (method, args, kwargs))
                for x, val in x.iteritems():
                    if not isinstance(x, basestring):
                        host = x.host
                    else:
                        host = x
                    rv[host] = val
            except RuntimeError:
                return None

        if dead_count_threshold is not None:
            # count dead engines
            for feng in self.fengs:
                if feng.host not in rv.keys():
                    feng.error_count += 1
                else:
                    feng.error_count = 0
                if feng.error_count > dead_count_threshold:
                    self.logger.warning("Declaring %s dead after %d errors" % (feng.host, feng.error_count))
                    self.declare_feng_dead(feng) 
        return rv

    def get_config(self, config=None):
        """
        Parse a configuration file.
        inputs:
            config (str): Path to configuration file. If None, a configuration will be pulled from redis.
        """
        if config is None:
            self.config_str  = self.r.hget('snap_configuration', 'config')
            self.config_name = self.r.hget('snap_configuration', 'name')
            self.config_hash = self.r.hget('snap_configuration', 'md5')
            self.config_time  = float(self.r.hget('snap_configuration', 'upload_time'))
            self.config_time_str  = self.r.hget('snap_configuration', 'upload_time_str')
            self.logger.info('Using configuration from redis, uploaded at %s' % self.config_time_str)
        else:
            with open(config, 'r') as fp:
                self.config_str = fp.read()
            self.config_name = config
            self.config_hash = hashlib.md5(self.config_str).hexdigest()
            self.config_time = time.time()
            self.config_time_str = time.ctime(self.config_time)
        self.config = yaml.load(self.config_str)

    def establish_connections(self, use_redis=True):
        """
        Connect to SNAP boards listed in the current configuration.
        inputs:
            use_redis (Boolean): If True, will use a redis proxy for talking to SNAPs. If False, will attempt a direct TFTP connection.
        """
        # Instantiate CasperFpga connections to all the F-Engine.
        self.fengs = []
        self.dead_fengs = {}
        ant_index = 0
        for host in self.config['fengines'].keys():
            ant_indices = self.config['fengines'][host].get('ants', range(ant_index, ant_index + 3))
            ant_index += 3
            self.logger.info("Setting Feng %s antenna indices to %s" % (host, ant_indices))
            try:
                if use_redis:
                    feng = SnapFengine(host, ant_indices=ant_indices, redishost=self.redishost)
                else:
                    feng = SnapFengine(host, ant_indices=ant_indices, redishost=None)
                if feng.fpga.is_connected():
                    self.fengs += [feng]
                    feng.error_count = 0
                else:
                    self.logger.warning("Board %s is not connected" % host)
                    self.dead_fengs[host] = time.time()
            except:
                self.logger.exception("Exception whilst connecting to board %s" % host)
                self.dead_fengs[host] = time.time()
        self.fengs_by_name = {}
        self.fengs_by_ip = {}
        for feng in self.fengs:
            feng.ip = socket.gethostbyname(feng.host)
            self.fengs_by_name[feng.host] = feng
            self.fengs_by_ip[feng.ip] = feng
        self.logger.info('SNAPs are: %s' % ', '.join([feng.host for feng in self.fengs]))

    def reestablish_dead_connections(self, age=0.0, programmed_only=False):
        """
        Try to reconnect to all boards in `self.dead_fengs`,
        if the board was declared dead more than `age` seconds ago.
        Is non-disruptive to connected boards.
        """
        t_thresh = time.time() - age # Try to connect to boards which were declared dead before this time
        new_fengs = []
        for host, deadtime in self.dead_fengs.items():
            if deadtime > t_thresh:
                self.logger.info("Ignoring host %s, which was only declared dead %d seconds ago" % (time.time() - deadtime))
                continue
            try:
                feng = SnapFengine(host)
                if feng.fpga.is_connected():
                    if (not programmed_only) or (programmed_only and feng.is_programmed()):
                        new_fengs += [feng]
                        feng.error_count = 0
                        self.dead_fengs.pop(host)
                    else:
                        self.logger.warning("Tried to reconnect to host %s. It is alive but not programmed." % host)
                else:
                    self.logger.warning("Tried to reconnect to host %s and failed" % host)
            except:
                self.logger.warning("Tried to reconnect to host %s and failed" % host)

        for feng in new_fengs:
            feng.ip = socket.gethostbyname(feng.host)
            self.fengs_by_name[feng.host] = feng
            self.fengs_by_ip[feng.ip] = feng
        
        if len(new_fengs) > 0:
            self.logger.info('Re-established connections to SNAPs : %s' % ', '.join([feng.host for feng in new_fengs]))

        # Don't forget to actually add the new F-engines!
        self.fengs += new_fengs

    def declare_feng_dead(self, feng):
        """
        Delare the Fengine `feng` dead. Remove it from the active list
        of connected boards. Add it to the list of dead boards if it's not there
        already. `feng` can either be a SnapFengine object (i.e., an entry from self.fengs)
        or a hostname.
        """
        deadfeng = None
        # if `feng` is a string, find the object corresponding to the SNAP with that hostname
        if isinstance(feng, str):
            self.logger.info("Trying to declare SNAP %s dead" % feng)
            for f in self.fengs:
                if f.host == feng:
                    deadfeng = f
            if deadfeng is None:
                self.logger.warning("Couldn't find SNAP %s by hostname" % feng)
                return
        # If `feng` is a SnapFengine instance, check it's known
        else:
            if feng not in self.fengs:
                self.logger.warning("Couldn't find SNAP %s by object match" % feng.host)
                return
            deadfeng = feng

        # If the SnapFengine instance has been found. Remove it from the active SNAP list
        try:
            self.fengs.remove(deadfeng)
        except ValueError:
            # Shouldn't be able to error here -- we've already checked the SNAP is there
            self.logger("Tried to declare %s dead but couldn't remove it" % deadfeng.host)

        self.dead_fengs[deadfeng.host] = time.time()

    def disable_monitoring(self, expiry=60):
        """
        Set the "disable_monitoring" key in redis. Hopefully other processes will respect this
        key and stop monitoring. Useful if you are going to hammer the TFTP connection and don't
        want interference from the monitoring loop.
        Inputs:
            expiry (float): Period (in seconds) for which the monitoring loop should be disabled.
        """
        self.r.set('disable_monitoring', 1, ex=expiry)

    def enable_monitoring(self):
        """
        Delete the "disable_monitoring" key in redis.
        """
        self.r.delete('disable_monitoring')

    def program(self, bitstream=None, unprogrammed_only=True):
        """
        Program SNAPs.
        Inputs:
            bitstream (str): Path to fpgfile to program. If None, the bitstream described in the current configuration will be used.
            unprogrammed_only (Boolean): If True, only program boards which aren't yet programmed.
        """
        TEMP_BITSTREAM_STORE = "/tmp/"
        progfile = bitstream or self.config['fpgfile']
        self.logger.info('Programming all SNAPs with %s' % progfile)
        if progfile.startswith("redis:"):
            progfile = progfile.split(":")[-1]
            try:
                bitstream = self.r.hget("fpg:%s" % progfile, "fpg")
            except KeyError:
                self.logger.error("FPG file %s not available in redis. Cannot program" % progfile)
                return
            progfile = os.path.join(TEMP_BITSTREAM_STORE, progfile)
            with open(progfile, "wb") as fh:
                fh.write(bitstream)
            
        if unprogrammed_only:
            to_be_programmed = []
            for feng in self.fengs:
                if not feng.is_programmed():
                    to_be_programmed += [feng]
            if len(to_be_programmed) == 0:
                self.logger.info("Skipping programming because all boards seem ready")
                return
        else:
            to_be_programmed = self.fengs
        self.logger.info("Actually programming %s" % ([f.host for f in self.fengs]))
        utils.program_fpgas([f.fpga for f in to_be_programmed], progfile, timeout=300.0)
        for f in to_be_programmed:
            self.r.hset('status:snap:%s' % f.host, 'last_programmed', time.ctime())
        
    def phase_switch_disable(self):
        """
        Disable all phase switches.
        """
        self.logger.info('Disabling all phase switches')
        for feng in self.fengs:
            feng.phaseswitch.set_all_walsh(self.config['walsh_order'], [0]*feng.phaseswitch.nstreams, self.config['log_walsh_step_size'])
        self.do_for_all_f("disable_mod", "phaseswitch")
        self.do_for_all_f("disable_demod", "phaseswitch")
        self.r.hmset('corr:status_phase_switch', {'state':'off', 'time':time.time()})

    def phase_switch_enable(self):
        """
        Enable all phase switches.
        """
        self.logger.info('Enabling all phase switches')
        for feng in self.fengs:
            feng.phaseswitch.set_all_walsh(self.config['walsh_order'], self.config['fengines'][feng.host]['phase_switch_index'], self.config['log_walsh_step_size'])
        self.do_for_all_f("set_delay", "phaseswitch", args=(self.config["walsh_delay"],))
        self.do_for_all_f("enable_mod", "phaseswitch")
        self.do_for_all_f("enable_demod", "phaseswitch")
        self.r.hmset('corr:status_phase_switch', {'state':'on', 'time':time.time()})

    def noise_diode_enable(self):
        """
        Enable all noise switches.
        """
        self.logger.info('Enabling all noise inputs')
        for feng in self.fengs:
           for fem in feng.fems:
               fem.switch(name='noise')
        self.r.hmset('corr:status_noise_diode', {'state':'on', 'time':time.time()})

    def noise_diode_disable(self):
        """
        Disable all noise switches.
        """
        self.logger.info('Disabling all noise inputs')
        for feng in self.fengs:
           for fem in feng.fems:
               fem.switch(name='antenna')
        self.r.hmset('corr:status_noise_diode', {'state':'off', 'time':time.time()})

    def get_ant_snap_chan(self, ant, pol):
        """
        Get the input number and SnapFengine object for a given ant, pol.
 
        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
        Returns:
           (snap_instance [SnapFengine], channel_num [int])
        """
        assert isinstance(ant, basestring), "`ant` input should be a string"
        assert isinstance(pol, basestring), "`pol` input should be a string"
        pol = pol.lower()
        assert pol in ['e', 'n'], "`pol` input should be 'e' or 'n'"
        if ant not in self.ant_to_snap.keys():
            self.logger.warning("Tried to find antenna %s but it is not on a known SNAP" % ant)
            return None, None
        if pol not in self.ant_to_snap[ant]:
            self.logger.warning("Tried to find antenna %s:%s but it is not on a known SNAP" % (ant, pol))
            return None, None
        x = self.ant_to_snap[ant][pol]
        return x['host'], x['channel']

    def set_pam_attenuation(self, ant, pol, val=None):
        """
        Set the PAM attenuation of Antenna `ant`, polarization `pol` to
        `val` dB.
        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
           val: Int attenuation value.
                If None, an attempt will be made to load previous value from redis.
        """
        pol = pol.lower()
        snap, chan = self.get_ant_snap_chan(ant, pol)
        if snap is None:
            self.logger.warning("Tried to set EQ for an antenna we don't recognize!")
            return
        elif not isinstance(snap, SnapFengine):
            self.logger.warning("Tried to set EQ for an antenna whose SNAP can't be reached!")
            return
        else:
            if val is None:
               # Try to reload coefficients from redis
               self.logger.debug("Trying to set PAM attenuation for Ant %s%s from redis" % (ant, pol))
               redval = self.r.hgetall("atten:ant:%s:%s" % (ant, pol))
               if redval != {}:
                   self.logger.debug("Loading attenuation of %ddB from time %s" % (int(redval['value']),time.ctime(float(redval['time']))))
                   self.set_pam_attenuation(ant, pol, int(redval['value']))
                   return
               # If there are no coeffs in redis. Look at whatever is actually loaded and update redis
               else:
                   self.logger.debug("Failed to find attenuation value in redis!")
                   val = self.get_pam_attenuation(ant, pol, update_redis=True)
                   return
            if pol == 'e':
                snap.pams[chan//2].set_attenuation(east=val)
            else:
                snap.pams[chan//2].set_attenuation(north=val)
            self.get_pam_attenuation(ant, pol, update_redis=True)

    def get_pam_attenuation(self, ant, pol, update_redis=False):
        """
        Get the PAM attenuation values of Antenna `ant`, polarization `pol`.
        Optionally update the coefficients stored in redis
        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
           update_redis: Boolean. If True, update this antennas redis PAM attenkey
        Returns:
           Current attenuation value (int)
        """
        snap, chan = self.get_ant_snap_chan(ant, pol)
        if snap is None:
            self.logger.warning("Tried to set EQ for an antenna we don't recognize!")
            return
        elif not isinstance(snap, SnapFengine):
            self.logger.warning("Tried to set EQ for an antenna whose SNAP can't be reached!")
            return
        else:
            val_e, val_n = snap.pams[chan//2].get_attenuation()
            if pol.lower() == 'e':
                val = val_e
            else:
                val = val_n
        if update_redis:
            self.r.hmset('atten:ant:%s:%s' % (ant, pol), {'value': str(val), 'time':time.time()})
        return val


    def set_eq(self, ant, pol, eq=None):
        """
        Set the EQ coefficients of Antenna `ant`, polarization `pol` to
        a constant or vector `eq`.
        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
            eq: Float/Int coefficients. If a single number, all coefficients will be
                set to this value. If a vector, each entry is one coefficient.
                If None, an attempt will be made to load coefficients from redis.
        """
        snap, chan = self.get_ant_snap_chan(ant, pol)
        if snap is None:
            self.logger.warning("Tried to set EQ for an antenna we don't recognize!")
            return
        elif not isinstance(snap, SnapFengine):
            self.logger.warning("Tried to set EQ for an antenna whose SNAP can't be reached!")
            return
        else:
            if eq is None:
               # Try to reload coefficients from redis
               self.logger.debug("Trying to set coeffs for Ant %s%s from redis" % (ant, pol))
               redval = self.r.hgetall("eq:ant:%s:%s" % (ant, pol))
               if redval != {}:
                   self.logger.debug("Loading coeffs from time %s" % (time.ctime(float(redval['time']))))
                   coeffs = np.array(json.loads(redval['values']))
                   self.set_eq(ant, pol, coeffs)
                   return
               # If there are no coeffs in redis. Look at whatever is actually loaded and update redis
               else:
                   self.logger.debug("Failed to find coefficients in redis!")
                   coeffs = self.get_eq(ant, pol, update_redis=True)
                   return
            elif not isinstance(eq, np.ndarray):
                try:
                    eq = np.ones(snap.eq.ncoeffs) * eq
                except:
                    self.logger.error("Couldn't understand EQ coefficients!")
                    return
            snap.eq.set_coeffs(chan, eq)
            self.get_eq(ant, pol, update_redis=True)
            

    def get_eq(self, ant, pol, update_redis=False):
        """
        Get the EQ coefficients of Antenna `ant`, polarization `pol`.
        Optionally update the coefficients stored in redis
        Inputs:
           ant: Antenna string. Eg. '0', for HH0
           pol: String polarization -- 'e' or 'n'
           update_redis: Boolean. If True, update this antenna's redis eq vector key
        Returns:
           Current EQ vector (numpy.array)
        """
        snap, chan = self.get_ant_snap_chan(ant, pol)
        if snap is None:
            self.logger.warning("Tried to set EQ for an antenna we don't recognize!")
            return
        elif not isinstance(snap, SnapFengine):
            self.logger.warning("Tried to set EQ for an antenna whose SNAP can't be reached!")
            return
        else:
            coeffs = snap.eq.get_coeffs(chan)
        if update_redis:
            self.r.hmset('eq:ant:%s:%s' % (ant, pol), {'values':json.dumps(coeffs.tolist()), 'time':time.time()})
        return coeffs

    def _initialize_all_eq(self):
        """
        Initialize PAM attenuation and SNAP EQ settings to the values currently held in redis.
        """
        for feng in self.fengs:
            for antpol in feng.ants:
                if antpol is not None:
                   self.logger.info("Initializing EQ for %s" % antpol)
                   ant, pol = helpers.hera_antpol_to_ant_pol(antpol)
                   self.set_eq(str(ant), pol)
                   self.set_pam_attenuation(str(ant), pol)

    def initialize(self, multithread=True, timeout=120):
        """
        Initialize all F-Engines.

        1. Initialize F-Eengine blocks.
        2. Disable noise/phase switches
        3. Return PAM attenuation and digital EQ to last known state.

        If `multithread` is True, the underlying code will to use
        this class's `do_for_all_f` method to intialize everyone.
        In this case, the `timeout` parameter specifies (in seconds)
        how long the threads should wait before timing out.
        NB: initialization takes about 30 seconds if things are going well,
        and longer if individual transactions fail and have to be retried.
        """
        if not multithread:
            for feng in self.fengs:
                self.logger.info('Initializing %s'%feng.host)
                feng.initialize()
        else:
            self.logger.info('Initializing all hosts using multithreading')
            self.do_for_all_f("initialize", timeout=timeout)
        #TODO multithread these:
        self.noise_diode_disable()
        self.phase_switch_disable()
        self._initialize_all_eq()

    def compute_hookup(self):
        """
        Generate an antenna-map from antenna names to
        Fengine instances.
        """
        hookup = helpers.read_maps_from_redis(self.r)
        if hookup is None:
            self.logger.error('Failed to compute antenna hookup from redis maps')
            return
        self.ant_to_snap = hookup['ant_to_snap']
        self.snap_to_ant = hookup['snap_to_ant']
        for ant in self.ant_to_snap.keys():
            for pol in self.ant_to_snap[ant].keys():
                host = self.ant_to_snap[ant][pol]['host']
                if host in self.fengs_by_name:
                    try:
                        self.ant_to_snap[ant][pol]['host'] = self.fengs_by_ip[socket.gethostbyname(host)]
                    except socket.gaierror:
                        self.logger.debug("Failed to get hostname for SNAP %s. Using this name" % host)
                        self.ant_to_snap[ant][pol]['host'] = host
        # Make the snap->ant dict, but make sure the hostnames match what is expected by this class's Fengines
        for hooked_up_snap in hookup['snap_to_ant'].keys():
            try:
                ip = socket.gethostbyname(hooked_up_snap)
                for feng in self.fengs:
                    if feng.ip == ip:
                        self.snap_to_ant[feng.host] = hookup['snap_to_ant'][hooked_up_snap]
                        feng.ants = self.snap_to_ant[feng.host]
            except socket.gaierror:
                self.logger.debug("Failed to get hostname for SNAP %s" % hooked_up_snap)
        # Fill any unconnected SNAPs with Nones
        for feng in self.fengs:
            if feng.host not in self.snap_to_ant.keys():
                self.snap_to_ant[feng.host] = [None] * 6

    def _verify_config(self):
        """
        Do some basic sanity checking on the currently loaded config.
        Returns:
            Bool : True if tests pass, False otherwise.
        """
        test_passed = True
        # Check that there are only three antennas per board
        for fn,(host,params) in enumerate(self.config['fengines'].items()):
            if 'ants' in params.keys():
                if len(params['ants']) != 3: 
                    self.logger.warning("%s: Number of antennas is not 3!" % host)
                    test_passed = False
        # Check that there are only 48 channels per x-engine.
        for host,params in self.config['xengines'].items():
            if 'chan_range' in params.keys():
                chan_range= params['chan_range']
                chans = np.arange(chan_range[0], chan_range[1])
                if len(chans) > 384:
                    self.logger.warning("%s: Cannot process >384 channels." % host)
                    test_passed = False
        return test_passed

    def configure_freq_slots(self, multithread=True):
        """
        Configure F-Engine destination packet slots.
        """
        n_xengs = self.config.get('n_xengs', 16)
        chans_per_packet = self.config.get('chans_per_packet', 384) # Hardcoded in firmware
        self.logger.info('Configuring frequency slots for %d X-engines, %d channels per packet' % (n_xengs, chans_per_packet))
        dest_port = self.config['dest_port'] 
        self.r.delete("corr:snap_ants")
        self.r.delete("corr:xeng_chans")
        for xn, xparams in self.config['xengines'].items():
            chan_range = xparams.get('chan_range', [xn*384, (xn+1)*384])
            chans = range(chan_range[0], chan_range[1])
            self.r.hset("corr:xeng_chans", xn, json.dumps(chans))
            if (xn > n_xengs): 
               self.logger.error("Cannot have more than %d X-engs!!" % n_xengs)
               return False
            ip = [int(i) for i in xparams['even']['ip'].split('.')]
            ip_even = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
            ip = [int(i) for i in xparams['odd']['ip'].split('.')]
            ip_odd = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]

            for fn, feng in enumerate(self.fengs):
                self.logger.info('%s: Setting Xengine %d: chans %d-%d: %s (even) / %s (odd)' % (feng.fpga.host, xn, chans[0], chans[-1], xparams['even']['ip'], xparams['odd']['ip']))
                # Update redis to reflect current assignments
                self.r.hset("corr:snap_ants", feng.host, json.dumps(feng.ant_indices))
                # if the user hasn't specified a source port, auto increment mod 4
                source_port = self.config['fengines'][feng.host].get('source_port', dest_port + (fn%4))
                if not multithread:
                    # if not multithreading use the original packetizer method, which is known good.
                    feng.packetizer.assign_slot(xn, chans, [ip_even,ip_odd], feng.reorder, feng.ant_indices[0])
                    feng.eth.add_arp_entry(ip_even,xparams['even']['mac'])
                    feng.eth.add_arp_entry(ip_odd,xparams['odd']['mac'])
            else:
                self.do_for_all_f("assign_slot", args=[xn, chans, [ip_even,ip_odd]])
                self.do_for_all_f("add_arp_entry", block="eth", args=[ip_even, xparams['even']['mac']])
                self.do_for_all_f("add_arp_entry", block="eth", args=[ip_odd, xparams['odd']['mac']])
        if not multithread:
            for fn, feng in enumerate(self.fengs):
                feng.eth.set_source_port(source_port)
                feng.eth.set_port(dest_port)
        else:
            self.do_for_all_f("set_source_port", block="eth", args=[source_port])
            self.do_for_all_f("set_port", block="eth", args=[dest_port])
        return True

    def resync(self, manual=False):
        """
        Resynchronize boards to PPS.
        
        Inputs:
            manual (Boolean): True if you want to synchronize on a software trigger. False (default) to sync on an external PPS.
        """
        self.logger.info('Sync-ing Fengines')
        self.do_for_all_f("set_delay", block="sync", args=(0,))
        if not manual:
            self.logger.info('Waiting for PPS at time %.2f' % time.time())
            self.fengs[0].sync.wait_for_sync()
            self.logger.info('Sync passed at time %.2f' % time.time())
        before_sync = time.time()
        for feng in self.fengs:
            feng.sync.arm_sync()
        after_sync = time.time()
        if manual:
            self.logger.warning('Using manual sync trigger')
            for i in range(3): # takes 3 syncs to trigger
                for feng in self.fengs:
                    feng.sync.sw_sync()
            sync_time = int(time.time()) # roughly
        else:
            sync_time = int(before_sync) + 1 + 3 # Takes 3 PPS pulses to arm
        # Store sync time in ms!!!
        self.r['corr:feng_sync_time'] = 1000*sync_time
        self.r['corr:feng_sync_time_str'] = time.ctime(sync_time)
        self.logger.info('Syncing took %.2f seconds' % (after_sync - before_sync))
        if after_sync - before_sync > 0.5:
            self.logger.warning("It took longer than expected to arm sync!")

    def sync_with_delay(self, sync_time_s, delay_ms, adc_clk_rate=500e6, adc_demux=2):
        """
        Resync all boards at the integer UNIX time `sync_time_s`,
        delaying the internal trigger until `delay_clocks` fpga
        clocks after the PPS pulse.
        """
        if (delay_ms > 1000):
            self.logger.error("I refuse to sync with a delay > 1 second")
            return
        sync_delay_fpga_clocks = (delay_ms / 1e3) / (adc_clk_rate / adc_demux)
        target_sync_time_ms = sync_time_s*1000 + (sync_delay_fpga_clocks*(adc_clk_rate / adc_demux)) # sync time in unix ms
        self.do_for_all_f("set_delay", block="sync", args=(sync_delay_fpga_clocks,))
        if (time.time()+5) > (target_sync_time_ms/1000.):
            self.logger.error("I refuse to sync less than 5s in the future")
            return
        if (time.time()+120) < (target_sync_time_ms/1000.):
            self.logger.error("I refuse to sync more than 120s in the future")
            return
        # it takes 3 PPS pulses to arm. Arm should occur < 4 seconds and > 3 seconds before sync target
        now = time.time()
        time_to_sync = sync_time_s - now - 4
        time.sleep(time_to_sync + 0.1) # This should be 3.9 seconds before target PPS
        time_before_arm = time.time()
        self.logger.info("Arming sync at %.2f" % time_before_arm)
        self.do_for_all_f("arm_sync", "sync")
        time_after_arm = time.time()
        self.logger.info("Finished arming sync at %.2f" % time_after_arm)
        self.logger.info('Syncing took %.2f seconds' % (time_after_arm - time_before_arm))
        if time_after_arm - time_before_arm > 0.5:
            self.logger.warning("It took longer than expected to arm sync!")
        # Update sync time -- in ms!!!!
        sync_time_ms = 1000*(int(time_before_arm) + 1 + 3) + delay_ms
        self.r['corr:feng_sync_time'] = sync_time_ms
        self.r['corr:feng_sync_time_str'] = time.ctime(sync_time_ms/1000.)
        return sync_time_ms

    def sync_noise(self, manual=False):
        """
        Resynchronize internal noise generators to PPS.
        
        Inputs:
            manual (Boolean): True if you want to synchronize on a software trigger. False (default) to sync on an external PPS.
        """
        self.logger.info('Sync-ing noise generators')
        if not manual:
            self.logger.info('Waiting for PPS at time %.2f' % time.time())
            self.fengs[0].sync.wait_for_sync()
            self.logger.info('Sync passed at time %.2f' % time.time())
        before_sync = time.time()
        for feng in self.fengs:
            feng.sync.arm_noise()
        after_sync = time.time()
        if manual:
            self.logger.warning('Using manual sync trigger')
            for i in range(3): # takes 3 syncs to trigger
                for feng in self.fengs:
                    feng.sync.sw_sync()
            sync_time = int(time.time()) # roughly
        self.logger.info('Syncing took %.2f seconds' % (after_sync - before_sync))
        if after_sync - before_sync > 0.5:
            self.logger.warning("It took longer than expected to arm sync!")

    def enable_output(self):
        """
        Enable all ethernet outputs.
        """
        self.logger.info('Enabling ethernet output')
        for feng in self.fengs:
            feng.eth.enable_tx()

    def disable_output(self):
        """
        Disable all ethernet outputs.
        """
        self.logger.info('Disabling ethernet output')
        for feng in self.fengs:
            feng.eth.disable_tx()
