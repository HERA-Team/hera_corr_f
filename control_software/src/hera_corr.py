import logging
import time
import redis
import yaml
from helpers import add_default_log_handlers
from hera_corr_f import SnapFengine

LOGGER = add_default_log_handlers(logging.getLogger(__name__))

class HeraCorrelator(object):
    def __init__(self, redishost='redishost', config=None, logger=LOGGER):
        self.r = redis.Redis(redishost)
        if config is None:
            config_str  = self.r.hget('snap_configuration', 'config')
            config_time = self.r.hget('snap_configuration', 'upload_time_str')
            logger.info('Using configuration from redis, uploaded at %s' % config_time)
            self.config = yaml.load(config_str)
        else:
            with open(config, 'r') as fp:
                self.config = yaml.load(fp)

        self.logger = logger

        # Instantiate CasperFpga connections to all the F-Engine.
        # TODO: this is fragile and will break if any board fails to co-operate
        self.fengs = [SnapFengine(host) for host in self.config['fengines'].keys()]
        self.logger.info('SNAPs are: %s' % ', '.join([feng.host for feng in self.fengs]))
        # Access to low level functionality
        self.fpgas = [feng.fpga for feng in self.fengs]

    def program(self, bitstream=None):
        progfile = bitstream or self.config['fpgfile']
        self.logger.info('Programming all SNAPs with %s' % progfile)
        casperfpga.utils.program_fpgas(self.fpgas, bitstream, timeout=300)
        
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
        self.logger.info('Initializing all F-engine blocks')
        for feng in self.fengs:
            feng.initialize()
        self.noise_diode_disable()
        self.phase_switch_disable()
