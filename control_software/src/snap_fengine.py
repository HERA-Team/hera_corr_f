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

        # blocks
        self.synth       = Synth(self.fpga, 'lmx_ctrl')
        self.adc         = Adc(self.fpga) # not a subclass of Block
        self.sync        = Sync(self.fpga, 'sync')
        self.noise       = NoiseGen(self.fpga, 'noise', nstreams=6)
        self.input       = Input(self.fpga, 'input', nstreams=12)
        self.delay       = Delay(self.fpga, 'delay', nstreams=6)
        self.pfb         = Pfb(self.fpga, 'pfb')
        self.eq          = Eq(self.fpga, 'eq', nstreams=6)
        self.eq_tvg      = EqTvg(self.fpga, 'eqtvg', nstreams=4, nchans=2**11)
        self.reorder     = ChanReorder(self.fpga, 'chan_reorder', nchans=2**11)
        self.packetizer  = Packetizer(self.fpga, 'packetizer')
        self.eth         = Eth(self.fpga, 'eth')
        self.corr        = Corr(self.fpga,'corr')
        self.phaseswitch = PhaseSwitch(self.fpga, 'phase_switch')
        self.pam         = Pam(self.fpga, 'i2c_ant0')
        
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
            self.pam,
        ]

    def initialize(self):
        for block in self.blocks:
            logger.info("Initializing block: %s" % block.name)
            block.initialize()

