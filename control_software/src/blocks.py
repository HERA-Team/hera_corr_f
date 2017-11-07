import logging
import numpy as np
import struct
import time
import casperfpga
import casperfpga.snapadc
logger = logging.getLogger(__name__)

# Block Classes
class Block(object):
    def __init__(self, host, name):
        self.host = host
        self.name = name
        if (name is None) or (name == ''):
            self.prefix = ''
        else:
            self.prefix = name + '_'
    
    def print_status(self):
        """
        Individual blocks should override this
        method to print some useful information.
        """
        pass

    def initialize(self):
        """
        Individual blocks should override this
        method to configure themselves appropriately
        """

    def listdev(self):
        """
        return a list of all register names within
        the block.
        """
        devs = self.host.listdev()
        return [x[len(self.prefix):] for x in devs if x.startswith(self.prefix)]

    def read_int(self, reg, word_offset=0, **kwargs):
        return self.host.read_int(self.prefix + reg, word_offset=word_offset, **kwargs)

    def write_int(self, reg, val, word_offset=0, **kwargs):
        self.host.write_int(self.prefix + reg, val, word_offset=word_offset, **kwargs)

    def read_uint(self, reg, word_offset=0, **kwargs):
        return self.host.read_uint(self.prefix + reg, word_offset=word_offset, **kwargs)

    def write_uint(self, reg, val, word_offset=0, **kwargs):
        self.host.write_int(self.prefix + reg, val, word_offset=word_offset, **kwargs)

    def read(self, reg, nbytes, **kwargs):
        return self.host.read(self.prefix + reg, nbytes, **kwargs)

    def write(self, reg, val, offset=0, **kwargs):
        self.host.write(self.prefix + reg, val, offset=offset, **kwargs)

    def blindwrite(self, reg, val, **kwargs):
        self.host.blindwrite(self.prefix + reg, val, **kwargs)

    def change_reg_bits(self, reg, val, start, width=1):
        orig_val = self.read_uint(reg)
        masked   = orig_val & (0xffffffff - ((2**width - 1) << start))
        new_val  = masked + (val << start)
        self.write_int(reg, new_val)

class Synth(casperfpga.synth.LMX2581):
    def __init__(self, host, name):
         super(Synth, self).__init__(host, name)

    def initialize(self):
        """
        Seem to have to do this if reference
        was not present when board was powered up(?)
        """
        self.powerOff()
        self.powerOn()

class Adc(casperfpga.snapadc.SNAPADC):
    def __init__(self, host, sample_rate=500, num_chans=2, resolution=8):
        super(Adc, self).__init__(host)
        self.name            = 'SNAP_adc'
        self.num_chans       = num_chans
        self.interleave_mode = 4 >> num_chans
        self.clock_divide    = 1
        self.sample_rate     = sample_rate
        self.resolution      = resolution

    def initialize(self):
        self.init(self.sample_rate, self.num_chans) # from the SNAPADC class
        #self.alignLineClock(mode='dual_pat')
        #self.alignFrameClock()
        ##If aligning complete, alignFrameClock should not output any warning
        self.selectADC()
        self.adc.selectInput([1,1,3,3])

class Sync(Block):
    def __init__(self, host, name):
        super(Sync, self).__init__(host, name)
        self.OFFSET_ARM_SYNC  = 0
        self.OFFSET_ARM_NOISE = 1
        self.OFFSET_SW_SYNC   = 4
    
    def uptime(self):
        """
        Returns uptime in seconds, assumes 250 MHz FPGA clock
        """
        return self.read_uint('uptime')

    def period(self):
        """
        Returns period of sync in pulses, in FPGA clock ticks
        """
        return self.read_uint('period')

    def change_period(self,period):
        """
        Change the period of the sync pulse
        """
        self.host.write_int('timebase_sync_period',period)
        print "Changed period to %.2f"%period

    def count(self):
        """
        Returns Number of external sync pulses received.
        """
        return self.read_uint('count')
    
    def wait_for_sync(self):
        """
        Block until a sync has been received.
        """
        c = self.count()
        while(self.count() == c):
            time.sleep(0.05)

    def arm_sync(self):
        """
        Arm sync pulse generator.
        """
        self.change_reg_bits('arm', 0, self.OFFSET_ARM_SYNC)
        self.change_reg_bits('arm', 1, self.OFFSET_ARM_SYNC)
        self.change_reg_bits('arm', 0, self.OFFSET_ARM_SYNC)

    def arm_noise(self):
        """
        Arm noise generator resets
        """
        self.change_reg_bits('arm', 0, self.OFFSET_ARM_NOISE)
        self.change_reg_bits('arm', 1, self.OFFSET_ARM_NOISE)
        self.change_reg_bits('arm', 0, self.OFFSET_ARM_NOISE)

    def sw_sync(self):
        """
        Issue a software sync pulse
        """
        self.change_reg_bits('arm', 0, self.OFFSET_SW_SYNC)
        self.change_reg_bits('arm', 1, self.OFFSET_SW_SYNC)
        self.change_reg_bits('arm', 0, self.OFFSET_SW_SYNC)

    def print_status(self):
        print 'Sync block: %s: Uptime: %d seconds' % (self.name, self.uptime())
        print 'Sync block: %s: Period: %d FPGA clocks' % (self.name, self.period())
        print 'Sync block: %s: Count : %d' % (self.name, self.count())

    def initialize(self):
        self.write_int('arm', 0)
        #self.change_period(2**16 * 9*7*6*5*3)
        self.change_period(0)

class NoiseGen(Block):
    def __init__(self, host, name, nstreams=6):
        super(NoiseGen, self).__init__(host, name)
        self.nstreams = nstreams

    def set_seed(self, stream, seed):
        """
        Set the seed of the noise generator for a given stream.
        """
        if stream > self.nstreams:
            logger.error('Tried to set noise generator seed for stream %d > nstreams (%d)' % (stream, self.nstreams))
            return
        if seed > 255:
            logger.error('Seed value is an 8-bit integer. It cannot be %d' % seed)
            return
        regname = 'seed_%d' % (stream // 4)
        self.change_reg_bits(regname, seed, 8 * (stream % 4), 8)

    def get_seed(self, stream):
        """
        Get the seed of the noise generator for a given stream.
        """
        if stream > self.nstreams:
            logger.error('Tried to get noise generator seed for stream %d > nstreams (%d)' % (stream, self.nstreams))
            return
        reg_name = 'seed_%d' % (stream // 4)
        return (self.read_uint(regname) >> (8 * stream % 4)) & 0xff


    def initialize(self):
        for stream in range(self.nstreams):
            self.set_seed(0, stream)

    def print_status(self):
        for stream in range(self.nstreams):
            print 'NoiseGen block: %s: stream %d seed: %d' % (self.name, stream, self.get_seed(stream))
       

class Input(Block):
    def __init__(self, host, name, nstreams=6):
        super(Input, self).__init__(host, name)
        self.nstreams = nstreams
        self.USE_NOISE = 0
        self.USE_ADC   = 1
        self.USE_ZERO  = 2

    def use_noise(self, stream=None):
        if stream is None:
            v = 0
            for stream in range(self.nstreams):
                v += self.USE_NOISE << (2 * stream)
            self.write_int('source_sel', v)
        else:
            raise NotImplementedError('Different input selects not supported yet!')

    def use_adc(self, stream=None):
        if stream is None:
            v = 0
            for stream in range(self.nstreams):
                v += self.USE_ADC << (2 * stream)
            self.write_int('source_sel', v)
        else:
            raise NotImplementedError('Different input selects not supported yet!')

    def use_zero(self, stream=None):
        if stream is None:
            v = 0
            for stream in range(self.nstreams):
                v += self.USE_ZERO << (2 * stream)
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

class Delay(Block):
    def __init__(self, host, name, nstreams=6):
        super(Delay, self).__init__(host, name)
        self.nstreams = nstreams

    def set_delay(self, stream, delay):
        if stream > self.nstreams:
            logger.error('Tried to set delay for stream %d > nstreams (%d)' % (stream, self.nstreams))
        self.write_int(change_reg_bits(self.host.read_uint('delays'), delay, 4*stream, 4))

    def initialize(self):
        self.write_int('delays', 0)

class Pfb(Block):
    def __init__(self, host, name):
        super(Pfb, self).__init__(host, name)
        self.SHIFT_OFFSET = 0
        self.SHIFT_WIDTH  = 12
        self.PRESHIFT_OFFSET = 12
        self.PRESHIFT_WIDTH  = 2
        self.STAT_RST_BIT = 14

    def set_fft_shift(self, shift):
        self.change_reg_bits('ctrl', shift, self.SHIFT_OFFSET, self.SHIFT_WIDTH)

    def set_fft_preshift(self, shift):
        self.change_reg_bits('ctrl', shift, self.PRESHIFT_OFFSET, self.PRESHIFT_WIDTH)

    def rst_stats(self):
        self.change_reg_bits('ctrl', 1, self.STAT_RST_BIT)
        self.change_reg_bits('ctrl', 0, self.STAT_RST_BIT)

    def is_overflowing(self):
        return self.read_uint('status') != 0
        
    def initialize(self):
        self.write_int('ctrl', 0)
        self.rst_stats()

class Eq(Block):
    def __init__(self, host, name, nstreams=6, ncoeffs=2**11):
        super(Eq, self).__init__(host, name)
        self.nstreams = nstreams
        self.ncoeffs = ncoeffs
        self.width = 18
        self.bp = 7
        self.format = 'H'#'L'

    def set_coeffs(self, stream, coeffs):
        coeffs *= 2**self.bp
        if np.any(coeffs > (2**self.width - 1)):
            logger.warning("Some coefficients out of range")
        # saturate coefficients
        coeffs[coeffs>(2**self.width - 1)] = 2**self.width - 1
        coeffs = list(coeffs)
        coeffs_str = struct.pack('>%d%s' % (len(coeffs), self.format), *coeffs)
        self.write('%d_coeffs' % stream, coeffs_str)

    def get_coeffs(self, stream):
        coeffs_str = self.read('%d_coeffs' % stream, self.ncoeffs*struct.calcsize(self.format))
        coeffs = np.array(struct.unpack('>%d%s' % (self.ncoeffs, self.format), coeffs_str))
        return coeffs / (2.**self.bp)

    def initialize(self):
        for stream in range(self.nstreams):
            self.set_coeffs(stream, np.ones(self.ncoeffs,dtype='>%s'%self.format))

class EqTvg(Block):
    def __init__(self, host, name, nstreams=3, nchans=2**11):
        super(EqTvg, self).__init__(host, name)
        self.nstreams = nstreams
        self.nchans = nchans
        self.format = 'Q'

    def tvg_enable(self):
        self.write_int('tvg_en', 1)

    def tvg_disable(self):
        self.write_int('tvg_en', 0)

    def write_freq_ramp(self):
        ramp = np.arange(self.nchans)
        ramp = np.array(ramp%16384,dtype='>%s'%self.format) # tvg values are only 16 bits
        tv = np.zeros(self.nchans, dtype='>%s'%self.format) 
        for stream in range(self.nstreams):
            tv += ((ramp + (self.nstreams - stream - 1)*(self.nchans)) << (16*stream))
        self.write('tv', tv.tostring())

    def initialize(self):
        self.tvg_disable()
        self.write_freq_ramp()

class ChanReorder(Block):
    def __init__(self, host, name, nchans):
        super(ChanReorder, self).__init__(host, name)
        self.nchans = nchans

    def set_channel_order(self, order):
        """
        Re-order the channels to that they are
        sent with the order in the specified map
        """
        order = list(order)
        if len(order) != self.nchans:
            logger.Error("Tried to reorder channels, but map was the wrong length")
            return
        order_str = struct.pack('>%dL' % self.nchans, *order)
        self.write('reorder1_map1', order_str)

    def reindex_channel(self, actual_index, output_index):
        self.write_int('reorder1_map1', actual_index, word_offset=output_index)

    def initialize(self):
        self.set_channel_order(np.arange(self.nchans))
        

class Packetizer(Block):
    def __init__(self, host, name, n_interfaces=1):
        super(Packetizer, self).__init__(host, name)
        self.n_interfaces = n_interfaces

    def set_nants(self, nants):
        self.write_int('n_ants', nants)

    def use_gpu_packing(self):
        self.write_int('stupid_gpu_packing', 1)

    def use_fpga_packing(self):
        self.write_int('stupid_gpu_packing', 0)

    def set_dest_ips(self, ips, slot_offset=0):
        self.write('ips', struct.pack('>%dL' % len(ips), *ips), offset=4*slot_offset)

    def set_ant_headers(self, ants):
        self.write('ants', struct.pack('>%dL' % len(ants), *ants))
        
    def set_chan_headers(self, chans, slot_offset=0):
        self.write('chans', struct.pack('>%dL' % len(chans), *chans), offset=4*slot_offset)

    def initialize(self):
        self.set_dest_ips(np.zeros(128))
        self.set_ant_headers(np.zeros(512))
        self.set_chan_headers(np.zeros(128))
        self.use_fpga_packing()

    def assign_slot(self, slot_num, chans, dest, reorder_block):
        """
        The F-engine generates 2048 channels, but can only
        output 1536, in order to keep within the output data rate cap.
        Each output packet contain 16 frequency channels for a single antenna.
        There are thus effectively 96 output slots, each corresponding
        to a block of 16 frequency channels. Each block can be filled with
        16 arbitrary channels (they can repeat, if you want), and sent
        to a particular IP address.
        slot_num -- a value from 0 to 95 -- the slot you want to allocate
        chans    -- an array of 16 channels, which you want to put in this slot's packet
        dest     -- an IP integer that is the destination of this packet
        reorder_block -- a ChanReorder block object, which allows the
                         packetizer to manipulate the channel ordering of the design. Bit gross.
        """
        chans = np.array(chans, dtype='>L')
        if slot_num > 95:
            raise ValueError("Only 95 output slots can be specified")
        if chans.shape[0] != 16:
            raise ValueError("Each slot must contain 16 frequency channels")
        # Since there are 2048 channels, and 16 channels per packet,
        # there are really 128 slots, but every 4th one must be zero.
        # The following map figures out where in the 128 slots one of the
        # 96 valid slots should go.
        slot128 = int(4*(slot_num//3) + slot_num%3)
        # Set the frequency header of this slot to be the first specified channel
        self.set_chan_headers(chans[0:1], slot_offset=slot128)
        # Set the destination address of this slot to be the specified IP address
        self.set_dest_ips([dest], slot_offset=slot128)
        # set the channel orders
        # The channels supplied need to emerge at indices slot128*16 : (slot128+1)*16
        for cn, chan in enumerate(chans):
            reorder_block.reindex_channel(chan, slot128*16 + cn)



        
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

    def add_arp_entry(self, ip, mac):
        """
        Set a single arp entry.
        """
        mac_pack = struct.pack('>Q', mac)
        ip_offset = ip % 256
        self.write('sw', mac_pack, offset=0x3000 + ip_offset*8)

    def get_status(self):
        stat = self.read_uint('sw_txs_ss_status')
        rv = {}
        rv['rx_overrun'  ] =  (stat >> 0) & 1   
        rv['rx_bad_frame'] =  (stat >> 1) & 1
        rv['tx_of'       ] =  (stat >> 2) & 1   # Transmission FIFO overflow
        rv['tx_afull'    ] =  (stat >> 3) & 1   # Transmission FIFO almost full
        rv['tx_led'      ] =  (stat >> 4) & 1   # Transmission LED
        rv['rx_led'      ] =  (stat >> 5) & 1   # Receive LED
        rv['up'          ] =  (stat >> 6) & 1   # LED up
        rv['eof_cnt'     ] =  (stat >> 7) & (2**25-1)
        return rv

    def status_reset(self):
        self.change_reg_bits('ctrl', 0, 18)
        self.change_reg_bits('ctrl', 1, 18)
        self.change_reg_bits('ctrl', 0, 18)

    def set_port(self, port):
        self.change_reg_bits('ctrl', port, 2, 16)

    def reset(self):
        # stop traffic before reset
        self.disable_tx()
        # toggle reset
        self.change_reg_bits('ctrl', 0, 0)
        self.change_reg_bits('ctrl', 1, 0)
        self.change_reg_bits('ctrl', 0, 0)

    def enable_tx(self):
        self.change_reg_bits('ctrl', 1, 1)

    def disable_tx(self):
        self.change_reg_bits('ctrl', 0, 1)

    def initialize(self):
        #Set ip address of the SNAP
        ipaddr = (10 << 24) + (0 << 16) + (10 << 8) + 110
        self.blindwrite('sw', struct.pack('>L', ipaddr), offset=0x10)
        self.set_port(self.port)
                        
    def print_status(self):
        rv = self.get_status()
        for key in rv.keys():
            print '%12s : %d'%(key,rv[key])

# class Eth(Block):
#     def __init__(self, host, name):
#         super(Eth, self).__init__(host, name)
#         self.tx = self.host.gbes
#         self.port = 10000
#         self.ipaddr = (10 << 24) + (0 << 16) + (10 << 8) + 112
#         self.macaddr = 0x1122334455

#     def set_arp_table(self, macs):
#         """
#         Set the ARP table with a list of MAC addresses.
#         The list, `macs`, is passed such that the zeroth
#         element is the MAC address of the device with
#         IP XXX.XXX.XXX.0, and element N is the MAC
#         address of the device with IP XXX.XXX.XXX.N
#         """
#         self.tx.set_arp_table(list(macs))
#         #macs = list(macs)
#         #macs_pack = struct.pack('>%dQ' % (len(macs)), *macs)
#         #self.write('sw', macs_pack, offset=0x3000)

#     def get_status(self):
#         stat = self.read_uint('sw_status')
#         self.tx.print_10gbe_core_details()
#         # rv = {}
#         # rv['rx_overrun'  ] =  (stat >> 0) & 1   
#         # rv['rx_bad_frame'] =  (stat >> 1) & 1
#         # rv['tx_of'       ] =  (stat >> 2) & 1   # Transmission FIFO overflow
#         # rv['tx_afull'    ] =  (stat >> 3) & 1   # Transmission FIFO almost full
#         # rv['tx_led'      ] =  (stat >> 4) & 1   # Transmission LED
#         # rv['rx_led'      ] =  (stat >> 5) & 1   # Receive LED
#         # rv['up'          ] =  (stat >> 6) & 1   # LED up
#         # rv['eof_cnt'     ] =  (stat >> 7) & (2**25-1)
#         # return rv

#     def status_reset(self):
#         self.change_reg_bits('ctrl', 0, 18)
#         self.change_reg_bits('ctrl', 1, 18)
#         self.change_reg_bits('ctrl', 0, 18)

#     def set_port(self, port):
#         self.change_reg_bits('ctrl', port, 2, 16)

#     def reset(self):
#         # disable core
#         self.change_reg_bits('ctrl', 0, 1)
#         # toggle reset
#         self.change_reg_bits('ctrl', 0, 0)
#         self.change_reg_bits('ctrl', 1, 0)
#         self.change_reg_bits('ctrl', 0, 0)

#     def enable_tx(self):
#         self.change_reg_bits('ctrl', 1, 1)

#     def initialize(self):
#         ## Set IP address of the SNAP
#         ## mac-location 0x00
#         ## ip-location 0x10
#         ## port-location 0x8
#         self.tx.setup(self.macaddr,self.ipaddr,self.port)
#         self.host.write(self.name, self.tx.mac.packed(), 0x00)
#         self.host.write(self.name,self.tx.ip_address.packed(),0x10)
#         value = (fpga.read_int(self.name, word_offset = 0x10)& 0xffff0000)
#         self.host.write_int(self.name,value,word_offset=0x10)
#         self.tx.fabric_enable()
#         #self.blindwrite('sw', struct.pack('>L', ipaddr), offset=0x10)
#         #self.set_port(self.port)
                        
#     # def print_status(self):
#     #     rv = self.get_status()
#     #     for key in rv.keys():
#     #         print '%12s : %d'%(key,rv[key])

class RoachInput(Block):
    def __init__(self, host, name, nstreams=32):
        super(RoachInput, self).__init__(host, name)
        self.nstreams  = nstreams
        self.nregs     = nstreams // 8
        self.nstreams_per_reg = 8
        self.USE_ADC   = 0
    # There are two separate noise streams we can switch in. TODO: figure out how (and why) to use these.
        self.USE_NOISE = 1
        self.USE_ZERO  = 3

    def use_noise(self, stream=None):
        if stream is None:
            for reg in range(self.nregs):
                v = 0
                for stream in range(self.nstreams_per_reg):
                    v += self.USE_NOISE << (4 * stream)
                self.write_int('sel%d' % reg, v)
        else:
            raise NotImplementedError('Different input selects not supported yet!')

    def use_adc(self, stream=None):
        if stream is None:
            for reg in range(self.nregs):
                v = 0
                for stream in range(self.nstreams_per_reg):
                    v += self.USE_ADC << (4 * stream)
                self.write_int('sel%d' % reg, v)
        else:
            raise NotImplementedError('Different input selects not supported yet!')

    def use_zero(self, stream=None):
        if stream is None:
            for reg in range(self.nregs):
                v = 0
                for stream in range(self.nstreams_per_reg):
                    v += self.USE_ZERO << (4 * stream)
                self.write_int('sel%d' % reg, v)
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
        self.change_reg_bits('%d' % delay_reg, delay, 8*reg_pos, 8)

    def initialize(self):
        for i in range(self.nregs):
            self.write_int('%d' % i, 0)

class RoachPfb(Block):
    def __init__(self, host, name):
        super(RoachPfb, self).__init__(host, name)
        self.host = host
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

class RoachEth(Block):
    def __init__(self, host, name, port=10000):
        super(RoachEth, self).__init__(host, name)
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


    def get_core_status(self, core=0):
        stat = self.read_uint('%d_sw_status' % core)
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
        self.change_reg_bits('ctrl', 0, 8)
        self.change_reg_bits('ctrl', 1, 8)
        self.change_reg_bits('ctrl', 0, 8)

    def set_port(self, port):
        self.change_reg_bits('ctrl', port, 2, 16)

    def reset(self):
        # disable core before resetting
        self.disable_tx()
        # toggle reset
        self.change_reg_bits('ctrl', 0, 4)
        self.change_reg_bits('ctrl', 1, 4)
        self.change_reg_bits('ctrl', 0, 4)

    def enable_tx(self):
        self.change_reg_bits('ctrl', 1, 0)

    def disable_tx(self):
        self.change_reg_bits('ctrl', 0, 0)

    def config_tge_core(self, core_num, mac, ip, port, arp_table):
        self.host.config_10gbe_core(self.name + '_%d_sw' % core_num, mac, ip, port, arp_table)
