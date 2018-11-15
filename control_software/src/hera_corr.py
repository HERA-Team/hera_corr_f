import logging
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
    def __init__(self, redishost='redishost', config=None, logger=LOGGER, passive=False):
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
            self.establish_connections()
            # Get antenna<->SNAP maps
            self.compute_hookup()

        self.config_is_valid= self._verify_config()

    def get_config(self, config=None):
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

    def establish_connections(self):
        # Instantiate CasperFpga connections to all the F-Engine.
        self.fengs = []
        self.dead_fengs = {}
        ant_index = 0
        for host in self.config['fengines'].keys():
            ant_indices = self.config['fengines'][host].get('ants', range(ant_index, ant_index + 3))
            ant_index += 3
            self.logger.info("Setting Feng %s antenna indices to %s" % (host, ant_indices))
            try:
                feng = SnapFengine(host, ant_indices=ant_indices)
                if feng.fpga.is_connected():
                    self.fengs += [feng]
                else:
                    self.logger.warning("Board %s is not connected" % host)
                    self.dead_fengs[host] = time.time()
            except:
                self.logger.warning("Exception whilst connecting to board %s" % host)
                self.dead_fengs[host] = time.time()
        self.fengs_by_name = {}
        self.fengs_by_ip = {}
        for feng in self.fengs:
            feng.ip = socket.gethostbyname(feng.host)
            self.fengs_by_name[feng.host] = feng
            self.fengs_by_ip[feng.ip] = feng
        self.logger.info('SNAPs are: %s' % ', '.join([feng.host for feng in self.fengs]))

    def reestablish_dead_connections(self, age=0.0):
        """
        Try to reconnect to all boards in `self.dead_fengs`,
        if the board was declared dead more than `age` seconds ago.
        Is non-disruptive to connected boards.
        """
        t_thresh = time.time() - age # Try to connect to boards which were declared dead before this time
        self.logger.info("Trying to re-establish connections to fengines dead before %s" % time.ctime(t_thresh))
        new_fengs = []
        for host, deadtime in self.dead_fengs.iteritems():
            if deadtime > t_thresh:
                self.logger.info("Ignoring host %s, which was only declared dead %d seconds ago" % (time.time() - deadtime))
                continue
            try:
                feng = SnapFengine(host)
                if feng.fpga.is_connected():
                    new_fengs += [feng]
                    self.dead_fengs.pop(host)
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
        self.r.set('disable_monitoring', 1, ex=expiry)

    def enable_monitoring(self):
        self.r.delete('disable_monitoring')

    def program(self, bitstream=None):
        progfile = bitstream or self.config['fpgfile']
        self.logger.info('Programming all SNAPs with %s' % progfile)
        utils.program_fpgas([feng.fpga for feng in self.fengs], progfile, timeout=300.0)
        self.r['corr:snap:last_programmed'] =  time.ctime()
        
    def phase_switch_disable(self):
        self.logger.info('Disabling all phase switches')
        for feng in self.fengs:
           for stream in range(feng.phaseswitch.nstreams):
               feng.phaseswitch.set_walsh(stream, 1, 0, 1) 
        self.r['corr:status_phase_switch'] = 'off'

    def phase_switch_enable(self):
        self.logger.info('Enabling all phase switches')
        for feng in self.fengs:
           for stream in range(feng.phaseswitch.nstreams):
               #TODO figure out what the patterns should be per antenna
               feng.phaseswitch.set_walsh(stream, 1, 0, 1) 
        self.r['corr:status_phase_switch'] = 'on'

    def noise_diode_enable(self):
        self.logger.info('Enabling all noise inputs')
        for feng in self.fengs:
           for fem in feng.fems:
               fem.switch(name='noise')
        self.r['corr:status_noise_diode'] = 'on'

    def noise_diode_disable(self):
        self.logger.info('Disabling all noise inputs')
        for feng in self.fengs:
           for fem in feng.fems:
               fem.switch(name='antenna')
        self.r['corr:status_noise_diode'] = 'off'

    def initialize(self):
        for feng in self.fengs:
            self.logger.info('Initializing %s'%feng.host)
            feng.initialize()
        self.noise_diode_disable()
        self.phase_switch_disable()

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
                    self.ant_to_snap[ant][pol]['host'] = self.fengs_by_ip[socket.gethostbyname(host)]
        # Make the snap->ant dict, but make sure the hostnames match what is expected by this classes Fengines
        for hooked_up_snap in hookup['snap_to_ant'].keys():
            try:
                ip = socket.gethostbyname(hooked_up_snap)
                for feng in self.fengs:
                    if feng.ip == ip:
                        self.snap_to_ant[feng.host] = hookup['snap_to_ant'][hooked_up_snap]
                        feng.ants = self.snap_to_ant[feng.host]
            except socket.gaierror:
                self.logger.warning("Failed to get hostname for SNAP %s" % hooked_up_snap)
        # Fill any unconnected SNAPs with Nones
        for feng in self.fengs:
            if feng.host not in self.snap_to_ant.keys():
                self.snap_to_ant[feng.host] = [None] * 6

    def _verify_config(self):
        test_passed = True
        # Check that there are only three antennas per board
        for fn,(host,params) in enumerate(self.config['fengines'].items()):
            if 'ants' in params.keys():
                if len(params['ants']) != 3: 
                    self.logger.warngin("%s: Number of antennas is not 3!" % host)
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

    def configure_freq_slots(self):
        n_xengs = self.config.get('n_xengs', 16)
        chans_per_packet = self.config.get('chans_per_packet', 384) # Hardcoded in firmware
        self.logger.info('Configuring frequency slots for %d X-engines, %d channels per packet' % (n_xengs, chans_per_packet))
        dest_port = self.config['dest_port'] 
        for fn, feng in enumerate(self.fengs):
            # Update redis to reflect current assignments
            self.r.hset("corr:snap_ants", feng.host, json.dumps(feng.ant_indices))
            # if the user hasn't specified a source port, auto increment mod 4
            source_port = self.config['fengines'][feng.host].get('source_port', dest_port + (fn%4))
            for xn, xparams in self.config['xengines'].items():
                chan_range = xparams.get('chan_range', [xn*384, (xn+1)*384])
                chans = range(chan_range[0], chan_range[1])
                self.r.hset("corr:xeng_chans", xn, json.dumps(chans))
                if (xn > n_xengs): 
                   self.logger.error("Cannot have more than %d X-engs!!" % n_xengs)
                   return False
                self.logger.info('%s: Setting Xengine %d: chans %d-%d: %s (even) / %s (odd)' % (feng.fpga.host, xn, chans[0], chans[-1], xparams['even']['ip'], xparams['odd']['ip']))
                ip = [int(i) for i in xparams['even']['ip'].split('.')]
                ip_even = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
                ip = [int(i) for i in xparams['odd']['ip'].split('.')]
                ip_odd = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
                feng.packetizer.assign_slot(xn, chans, [ip_even,ip_odd], feng.reorder, feng.ant_indices[0])
                feng.eth.add_arp_entry(ip_even,xparams['even']['mac'])
                feng.eth.add_arp_entry(ip_odd,xparams['odd']['mac'])
            feng.eth.set_source_port(source_port)
            feng.eth.set_port(dest_port)
        return True

    def resync(self, manual=False):
        self.logger.info('Sync-ing Fengines')
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
        self.r['corr:feng_sync_time'] = sync_time
        self.r['corr:feng_sync_time_str'] = time.ctime(sync_time)
        self.logger.info('Syncing took %.2f seconds' % (after_sync - before_sync))
        if after_sync - before_sync > 0.5:
            self.logger.warning("It took longer than expected to arm sync!")

    def sync_noise(self, manual=False):
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
        self.logger.info('Enabling ethernet output')
        for feng in self.fengs:
            feng.eth.enable_tx()

    def disable_output(self):
        self.logger.info('Disabling ethernet output')
        for feng in self.fengs:
            feng.eth.disable_tx()
