import logging
import numpy as np
import struct
from casperfpga import CasperFpga
from snap_fengine import Block, Sync, NoiseGen, Eq, EqTvg
logger = logging.getLogger(__name__)


class RoachFengine(object):
    def __init__(self, host):
        self.host = host
        self.fpga = CasperFpga(host=host, port=7147)

        # blocks
        self.sync        = Sync(self.fpga, 'sync'),
        self.noise       = NoiseGen(self.fpga, '', nstreams=32),
        self.input       = RoachInput(self.fpga, 'input', nstreams=32),
        self.delay       = RoachDelay(self.fpga, 'delay', nstreams=6),
        self.pfb         = RoachPfb(self.fpga, 'pfb'),
        self.eq          = Eq(self.fpga, 'eq', nstreams=16, ncoeffs=2**11),
        self.eq_tvg      = EqTvg(self.fpga, 'eq_tvg', nstreams=16, nchans=2**11),
        self.packetizer  = Packetizer(self.fpga, 'transpose_packetizer'),
        self.eth         = Eth(self.fpga, 'eth'),

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


class RoachInput(Block):
    def __init__(self, host, name, nstreams=32):
        super(RoachInput, self).__init__(host, name)
        self.nstreams  = nstreams
        self.nregs      = nstreams // 4
        self.nstreams_per_reg = 4
        self.USE_NOISE = 0
        self.USE_ADC   = 1
        self.USE_ZERO  = 2

    def use_noise(self, stream=None):
        if stream is None:
            for reg in range(self.nregs):
                v = 0
                for stream in range(self.nstreams_per_reg):
                    v += self.USE_NOISE*(2<<stream)
                self.write_int('sel%d' % reg, v)
        else:
            raise NotImplementedError('Different input selects not supported yet!')

    def use_adc(self, stream=None):
        if stream is None:
            for reg in range(self.nregs):
                v = 0
                for stream in range(self.nstreams_per_reg):
                    v += self.USE_ADC*(2<<stream)
            self.write_int('source_sel', v)
        else:
            raise NotImplementedError('Different input selects not supported yet!')

    def use_zero(self, stream=None):
        if stream is None:
            for reg in range(self.nregs):
                v = 0
                for stream in range(self.nstreams_per_reg):
                    v += self.USE_ZERO*(2<<stream)
            self.write_int('source_sel', v)
        else:
            raise NotImplementedError('Different input selects not supported yet!')

    def get_stats(self):
        self.write_int('rms_enable', 1)
        time.sleep(0.01)
        self.write_int('rms_enable', 0)
        x = np.array(struct.unpack('>%dl' % (2*self.nstreams), self.read('rms_levels', self.nstreams * 8)))
        self.write_int('rms_enable', 1)
        means = x[0::2]
        sds   = x[1::2]
        return {'means':means, 'sds':sds}

    def initialize(self):
        self.use_adc()
        self.write_int('rms_enable', 1)

    def print_status(self):
        print self.get_stats()

class RoachDelay(Block):
    def __init__(self, host, name, nstreams=6):
        super(RoachDelay, self).__init__(host, name)
        self.nstreams = nstreams
        self.nregs = nstreams // 4

    def set_delay(self, stream, delay):
        if stream > self.nstreams:
            logger.error('Tried to set delay for stream %d > nstreams (%d)' % (stream, self.nstreams))
        delay_reg = stream // 4
        reg_pos   = stream % 4
        self.write_int(change_reg_bits(self.host.read_uint('%d' % delay_reg), delay, 8*reg_pos, 8))

    def initialize(self):
        for i in range(self.nregs):
            self.write_int('%d' % i, 0)

class RoachPfb(Block):
    def __init__(self, host, name):
        super(RoachPfb, self).__init__(host, name)
        self.SHIFT_OFFSET = 0
        self.SHIFT_WIDTH  = 11
        self.PRESHIFT_OFFSET = 11
        self.PRESHIFT_WIDTH  = 2
        #self.STAT_RST_BIT = 14

    def set_fft_shift(self, shift):
        self.change_reg_bits('fft_shift', shift, self.SHIFT_OFFSET, self.SHIFT_WIDTH)

    def set_fft_preshift(self, shift):
        self.change_reg_bits('fft_shift', shift, self.PRESHIFT_OFFSET, self.PRESHIFT_WIDTH)

    def initialize(self):
        self.host.write_int('fft_shift', 0)

class Eth(Block):
    def __init__(self, host, name, port=10000):
        super(Eth, self).__init__(host, name)
        self.port = port

    def set_arp_table(self, macs):
        """
        Set the ARP table with a list of MAC addresses.
        The list, `macs`, is passed such that the zeroth
        element is the MAC address of the device with
        IP XXX.XXX.XXX.0, and element N is the MAC
        address of the device with IP XXX.XXX.XXX.N
        """
        macs = list(macs)
        macs_pack = struct.pack('>%dQ' % (len(macs)), *macs)
        self.write('sw', macs_pack, offset=0x3000)


    def get_status(self):
        stat = self.read_uint('sw_status')
        rv = {}
        rv['rx_overrun'  ] = (stat >> 0) & 1
        rv['rx_bad_frame'] = (stat >> 1) & 1
        rv['tx_of'       ] = (stat >> 2) & 1
        rv['tx_afull'    ] = (stat >> 3) & 1
        rv['tx_led'      ] = (stat >> 4) & 1
        rv['rx_led'      ] = (stat >> 5) & 1
        rv['up'          ] = (stat >> 6) & 1
        rv['eof_cnt'     ] = (stat >> 7) & (2**25-1)
        return rv

    def status_reset(self):
        self.change_reg_bits('ctrl', 0, 18)
        self.change_reg_bits('ctrl', 1, 18)
        self.change_reg_bits('ctrl', 0, 18)

    def set_port(self, port):
        self.change_reg_bits('ctrl', port, 2, 16)

    def reset(self):
        # disable core
        self.change_reg_bits('ctrl', 0, 1)
        # toggle reset
        self.change_reg_bits('ctrl', 0, 0)
        self.change_reg_bits('ctrl', 1, 0)
        self.change_reg_bits('ctrl', 0, 0)

    def enable_tx(self):
        self.change_reg_bits('ctrl', 1, 1)



