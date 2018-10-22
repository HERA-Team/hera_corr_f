import logging
import numpy as np
import struct
import time
import casperfpga
from blocks import *
logger = logging.getLogger(__name__)


class SnapFengine(object):
    def __init__(self, host):
        self.host = host
        self.fpga = casperfpga.CasperFpga(host=host)
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
        try:
            self._add_i2c()
        except:
            pass
        
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
        self.blocks += self.pams
        self.blocks += self.fems
        self.i2c_initialized = True

    def initialize(self):
        if not self.i2c_initialized:
            self._add_i2c()
        for block in self.blocks:
            logger.info("Initializing block: %s" % block.name)
            block.initialize()

