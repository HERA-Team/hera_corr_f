import logging
import numpy as np
import struct
import time
import casperfpga
import casperfpga.snapadc
from scipy.linalg import hadamard #for walsh (hadamard) matrices
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
        """
        Get the mean, RMS, and powers of
        all 12 ADC cores.
        returns: means, powers, rmss
        """
        self.write_int('rms_enable', 1)
        time.sleep(0.01)
        self.write_int('rms_enable', 0)
        x = np.array(struct.unpack('>%dl' % (2*self.nstreams), self.read('rms_levels', self.nstreams * 8)))
        self.write_int('rms_enable', 1)
        means    = x[0::2] / 2.**16
        powers   = x[1::2] / 2.**16
        rmss     = np.sqrt(powers)
        return means, powers, rmss

    def initialize(self):
        self.use_adc()
        self.write_int('rms_enable', 1)

    def print_status(self):
        mean, power, rms = self.get_stats()
        print 'mean:',
        for i in mean: print '%3f'%i,
        print ''
        print 'power:',
        for i in power: print '%3f'%i,
        print ''
        print 'rms:',
        for i in rms: print '%3f'%i,
        print ''

    def get_histogram(self, input, sum_cores=True):
        v = np.array(struct.unpack('>512H', self.read('bit_stats_histogram%d_output'%input, 512*2)))
        a = v[0::2]
        b = v[1::2]
        a = np.roll(a, 128) # roll so that array counts -128, -127, ..., 0, ..., 126, 127
        b = np.roll(b, 128) # roll so that array counts -128, -127, ..., 0, ..., 126, 127
        vals = np.arange(-128,128)
        if sum_cores:
            return vals, a+b
        else:
            return val, a, b

    def get_input_histogram(self, ant):
        vals, a = self.get_histogram(ant*2, sum_cores=True)
        vals, b = self.get_histogram(ant*2 + 1, sum_cores=True)
        return vals, a+b

    def get_all_histograms(self):
        out = np.zeros([self.nstreams, 256])
        for stream in range(self.nstreams/4):
            x, out[stream,:] = self.get_input_histogram(stream)
        return x, out

    def print_histograms(self):
        x, hist = self.get_all_histograms()
        hist /= 1024.*1024
        for vn, v in enumerate(x):
            print '%5d:'%v,
            for an, ant in enumerate(hist):
                print '%.3f'%ant[vn],
            print ''

    def plot_histogram(self, input, show=False):
        from matplotlib import pyplot as plt
        bins, d = self.get_input_histogram(input)
        #plt.hist(d, bins=bins)
        plt.bar(bins-0.5, d, width=1)
        if show:
            plt.show()

    def show_histogram_plot(self):
        from matplotlib import pyplot as plt
        plt.show()
        

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
        self.set_fft_shift(0b110110110110)
        self.rst_stats()

class PhaseSwitch(Block):
    def __init__(self, host, name, nstreams=6, depth=2**12, periodbase=2**13):
        super(PhaseSwitch, self).__init__(host, name)
        self.nstreams = nstreams
        self.depth = depth           # number of brams steps in a period
        self.periodbase = periodbase # number of clock cycles in one bram step

    def set_walsh(self, stream, N, n, stepperiod, demodulate=True):
        """
        N: order of walsh matrix
        stream: stream to set
        n: walsh index to give this stream
        stepperiod: period (2^?), in multiples of self.periodbase FPGA clocks,
                of shortest walsh step. I.e., 2**13 * 2**self.baseperiod * N
                = period of complete cycle in FPGA clocks.
        """
        N_round = int(2**(np.ceil(np.log2(N))))
        walsh_matrix = hadamard(N_round)
        # reformat so 1 means multiply by -1, and 0 means multiply by 1
        walsh_matrix[walsh_matrix == 1]  = 0
        walsh_matrix[walsh_matrix == -1] = 1
        walsh_func = walsh_matrix[n] # a vector of length N_round
        
        walsh_func_stretch = walsh_func.repeat(2**stepperiod) # a vector of length N_round * 2*step_period

        # The counter in the FPGA cycles through <depth> ram addresses, so repeat
        # the sequence. Since N_round and 2**stepperiod are always powers of 2,
        # this is always an integer number of cycles
        vec = np.array(walsh_func_stretch.tolist() * (self.depth/ 2**stepperiod / N_round), dtype=np.int)
        
        #Modify the appropriate bits of the bram
        # note reverse direction of gpio vs software bit assignments
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('gpio_switch_states', self.depth)))
        new_bram_vec  = curr_bram_vec & (0xff - (1 << stream)) # zero the stream we are writing
        new_bram_vec  = new_bram_vec + (vec << stream)
        self.write('gpio_switch_states', struct.pack('>%dB' % self.depth, *new_bram_vec))
        
        #Modify the appropriate bits of the demodulation bram
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('sw_switch_states', self.depth)))
        new_bram_vec  = curr_bram_vec & (0xff - (1<<((self.nstreams-1)-stream))) # zero the stream we are writing
        if demodulate:
            new_bram_vec = new_bram_vec + (vec << ((self.nstreams-1) - stream))
        self.write('sw_switch_states', struct.pack('>%dB' % self.depth, *new_bram_vec))

    def set_gpio_high(self, stream):
        #Modify the appropriate bits of the bram
        # note reverse direction of gpio vs software bit assignments
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('gpio_switch_states', self.depth)))
        new_bram_vec  = curr_bram_vec & (0xff - (1 << stream)) # zero the stream we are writing
        new_bram_vec += (np.ones(self.depth, dtype=np.int) << stream)
        self.write('gpio_switch_states', struct.pack('>%dB' % self.depth, *new_bram_vec))

    def set_gpio_low(self, stream):
        #Modify the appropriate bits of the bram
        # note reverse direction of gpio vs software bit assignments
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('gpio_switch_states', self.depth)))
        new_bram_vec  = curr_bram_vec & (0xff - (1 << stream)) # zero the stream we are writing
        self.write('gpio_switch_states', struct.pack('>%dB' % self.depth, *new_bram_vec))

    def get_mod_pattern(self, stream):
        #Modify the appropriate bits of the bram
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('gpio_switch_states', self.depth)))
        return (curr_bram_vec >> ((self.nstreams-1) - stream)) & 0b1

    def get_demod_pattern(self, stream):
        #Modify the appropriate bits of the bram
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('sw_switch_states', self.depth)))
        return (curr_bram_vec >> ((self.nstreams-1) - stream)) & 0b1

    def set_delay(self, delay):
        """
        set the delay (in FPGA clock cycles) between
        the modulation and demodulation patterns
        (to take into account cable latency)
        """
        self.write_int('gpio_switch_offset', delay)

    def initialize(self):
        """
        Initialize, turning off walshing
        """
        for stream in range(self.nstreams):
            self.set_walsh(stream, 1, 0, 1)
        self.set_delay(0)
        
class Eq(Block):
    def __init__(self, host, name, nstreams=6, ncoeffs=2**11):
        super(Eq, self).__init__(host, name)
        self.nstreams = nstreams
        self.ncoeffs = ncoeffs
        self.width = 16
        self.bp = 6
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
            self.set_coeffs(stream, 100*np.ones(self.ncoeffs,dtype='>%s'%self.format))

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

    def set_dest_ips(self, ips, slot_offset=0, nants=3):
        ips = np.repeat(np.array(ips), nants)
        self.write('ips', struct.pack('>%dL' % ips.shape[0], *ips), offset=4*slot_offset*nants)

    def set_ant_headers(self, ants):
        self.write('ants', struct.pack('>%dL' % len(ants), *ants))
        
    def set_chan_headers(self, chans, slot_offset=0, nants=3):
        chans = np.repeat(np.array(chans), nants)
        self.write('chans', struct.pack('>%dL' % chans.shape[0], *chans), offset=4*slot_offset*nants)

    def initialize(self):
        self.set_dest_ips(np.zeros(128))
        self.set_ant_headers(np.zeros(512))
        self.set_chan_headers(np.zeros(128))
        self.use_fpga_packing()

    def assign_slot(self, slot_num, chans, dest, reorder_block, nants=3):
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
        self.set_chan_headers(chans[0:1], slot_offset=slot128, nants=nants)
        # Set the destination address of this slot to be the specified IP address
        self.set_dest_ips([dest], slot_offset=slot128, nants=nants)
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


class Corr(Block):
    def __init__(self, host, name, acc_len=2048*1e5):
        super(Corr, self).__init__(host,name)
        self.acc_len = acc_len
        
    def get_corr(self,antenna1,antenna2):
        self.write_int('input_sel',(antenna1 + (antenna2 << 8)))
        cnt = self.read_uint('acc_cnt')

        while self.read_uint('acc_cnt') <= (cnt+1):
            time.sleep(0.1)
            
        spec = np.array(struct.unpack('>4096L',self.read('dout',8*2048)))
        
        return (spec[0::2]+1j*spec[1::2])/self.acc_len
    
    def initialize(self):
        self.write_int('acc_len',self.acc_len)

    def plot_corr(self,antenna1,antenna2,show=True):
        import matplotlib.pyplot as plt
        spec = self.get_corr(antenna1,antenna2)
        f,ax = plt.subplots(2,2)
        ax[0][0].plot(spec.real)
        ax[0][0].set_title('Real')
        ax[0][1].plot(spec.imag)
        ax[0][1].set_title('Imag')
        ax[1][0].plot(np.angle(spec))
        ax[1][0].set_title('Phase')
        ax[1][1].plot(10*np.log10(np.abs(spec)))
        ax[1][1].set_title('Power [dB]')

        if show:
            plt.show()
            
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

class Pam(Block):
    def __init__(self, host, name):
        super(Pam, self).__init__(host, name)
        import i2c
        import i2c_gpio
        self.i2c = i2c.I2C(host, name)
        self.gpio = i2c_gpio.PCF8574(self.i2c, addr=0x21)

    def initialize(self):
        self.i2c.clockSpeed(10) # set i2c bus to 10 kHz

