import logging
import helpers
import numpy as np
import struct
import time
import datetime
import casperfpga
from blocks import *

class SnapFengine(object):
    def __init__(self, host, ant_indices=None, logger=None):
        self.host = host
        self.logger = logger or helpers.add_default_log_handlers(logging.getLogger(__name__ + "(%s)" % host))
        self.fpga = casperfpga.CasperFpga(host=host, transport=casperfpga.TapcpTransport)
        # Try and get the canonical name of the host
        # to use as a serial number
        try:
            self.serial = socket.gethostbyaddr(self.host)[0]
        except:
            self.serial = None

        # blocks
        self.synth       = Synth(self.fpga, 'lmx_ctrl')
        self.adc         = Adc(self.fpga) # not a subclass of Block
        self.sync        = Sync(self.fpga, 'sync')
        self.noise       = NoiseGen(self.fpga, 'noise', nstreams=6)
        self.input       = Input(self.fpga, 'input', nstreams=12)
        self.delay       = Delay(self.fpga, 'delay', nstreams=6)
        self.pfb         = Pfb(self.fpga, 'pfb')
        self.eq          = Eq(self.fpga, 'eq_core', nstreams=6, ncoeffs=2**10)
        self.eq_tvg      = EqTvg(self.fpga, 'eqtvg', nstreams=6, nchans=2**13)
        self.reorder     = ChanReorder(self.fpga, 'chan_reorder', nchans=2**10)
        self.rotator     = Rotator(self.fpga, 'rotator')
        self.packetizer  = Packetizer(self.fpga, 'packetizer', n_time_demux=2) # Round robin time packets to two destinations
        self.eth         = Eth(self.fpga, 'eth')
        self.corr        = Corr(self.fpga,'corr_0')
        self.phaseswitch = PhaseSwitch(self.fpga, 'phase_switch')
        self.i2c_initialized = False
        # The I2C devices mess with FPGA registers
        # when instantiated. This fails if the board
        # isn't programmed yet, so run it in a try block.
        try:
            self._add_i2c()
        except:
            pass

        self.ants = [None] * 6 # An attribute to store the antenna names of this board's inputs
        self.ant_indices = ant_indices or range(3) # An attribute to store the antenna numbers used in packet headers
        
        # The order here can be important, blocks are initialized in the
        # order they appear here
        self.blocks = [
            self.synth,
            self.adc,
            self.sync,
            self.noise,
            self.input,
            self.delay,
            self.pfb,
            self.eq,
            self.eq_tvg,
            self.reorder,
            self.packetizer,
            self.eth,
            self.corr,
            self.phaseswitch,
        ]

    def _add_i2c(self):
        self.pams        = [Pam(self.fpga, 'i2c_ant%d' % i) for i in range(3)]
        self.fems        = []#[Fem(self.fpga, 'i2c_ant%d' % i) for i in range(3)]
        # Need to initialize the Pams to get access to their methods.
        for pam in self.pams:
            pam.initialize()
        self.blocks += self.pams
        self.blocks += self.fems
        self.i2c_initialized = True

    def initialize(self):
        if not self.i2c_initialized:
            self._add_i2c()
        for block in self.blocks:
            self.logger.info("Initializing block: %s" % block.name)
            block.initialize()

    def get_fpga_stats(self):
        """
        Get FPGA stats.
        returns: Dictionary of stats
        """
        stat = {}
        stat['temp'] = self.fpga.transport.get_temp()
        stat['timestamp'] = datetime.datetime.now().isoformat()
        stat['uptime'] = self.sync.uptime()
        stat['pps_count'] = self.sync.count()
        stat['serial'] = self.serial
        stat['pmb_alert'] = self.fpga.read_uint('pmbus_alert')
        return stat

