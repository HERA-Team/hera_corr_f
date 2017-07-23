import logging
import numpy as np
import struct
#from casperfpga import CasperFpga
import katcp_wrapper
from blocks import *
logger = logging.getLogger(__name__)


class RoachFengine(object):
    def __init__(self, host):
        self.host = host
        #self.fpga = CasperFpga(host=host, port=7147)
	self.fpga = katcp_wrapper.FpgaClient(host)

        # blocks
        self.sync        = Sync(self.fpga, 'sync')
        self.noise       = NoiseGen(self.fpga, None, nstreams=32)
        self.input       = RoachInput(self.fpga, 'input', nstreams=32)
        self.delay       = RoachDelay(self.fpga, 'delay', nstreams=6)
        self.pfb         = RoachPfb(self.fpga, None)
        self.eq          = Eq(self.fpga, 'eq', nstreams=16, ncoeffs=2**11)
        self.eq_tvg      = EqTvg(self.fpga, 'eq_tvg', nstreams=16, nchans=2**11)
        self.packetizer  = Packetizer(self.fpga, 'transpose_packetizer')
        self.eth         = RoachEth(self.fpga, 'eth')

        # The order here can be important, blocks are initialized in the
        # order they appear here
        self.blocks = [
            self.sync,
            self.noise,
            self.input,
            self.delay,
            self.pfb,
            self.eq,
            self.eq_tvg,
            self.packetizer,
            self.eth,
        ]

    def initialize(self):
        for block in self.blocks:
            block.initialize()
    
    def set_fid(self, fid):
        self.fpga.write_int('fid', fid)

    def set_ctmode(self, mode):
        self.fpga.write_int('ctmode', mode)
