import logging
import numpy as np
import struct
import socket
import time
import casperfpga
import casperfpga.snapadc
from scipy.linalg import hadamard #for walsh (hadamard) matrices
logger = logging.getLogger(__name__)

# Block Classes
class Block(object):
    def __init__(self, host, name):
        self.host = host #casperfpga object
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
    def __init__(self, host, sample_rate=500, num_chans=2, resolution=8,ref=10):
        casperfpga.snapadc.SNAPADC.__init__(self,host,ref=ref)
        self.name            = 'SNAP_adc'
        self.num_chans       = num_chans
        self.interleave_mode = 4 >> num_chans
        self.clock_divide    = 1
        self.sample_rate     = sample_rate
        self.resolution      = resolution

    def set_gain(self, gain):
        """
        Set the coarse gain of the ADC. Allowed values
        are 1, 1.25, 2, 2.5, 4, 5, 8, 10, 12.5, 16, 20, 25, 32, 50.
        """
        gain_map = {
          1    : 0b0000,
          1.25 : 0b0001,
          2    : 0b0010,
          2.5  : 0b0011,
          4    : 0b0100,
          5    : 0b0101,
          8    : 0b0110,
          10   : 0b0111,
          12.5 : 0b1000,
          16   : 0b1001,
          20   : 0b1010,
          25   : 0b1011,
          32   : 0b1100,
          50   : 0b1101
        }

        if gain not in gain_map.keys():
            raise ValueError("Gain %f is not allowed! Only gains %s are allowed" % (gain, gain_map.keys()))
        
        self.adc.write((gain_map[gain]<<4) + gain_map[gain], 0x2b)
        

    def initialize(self):
        self.init(self.sample_rate, self.num_chans, self.resolution) # from the SNAPADC class
        #self.alignLineClock(mode='dual_pat')
        #self.alignFrameClock()
        ##If aligning complete, alignFrameClock should not output any warning
        self.selectADC()
        self.adc.selectInput([1,1,3,3])
        self.set_gain(4)

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
        regname = 'seed_%d' % (stream // 4)
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
        self.INT_TIME  = 2**20 / 250.0e6

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
        a = v[0:256]
        b = v[256:512]
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
        self.write('coeffs', coeffs_str, offset=struct.calcsize(self.format)*self.ncoeffs*stream)

    def get_coeffs(self, stream):
        coeffs_str = self.read('%d_coeffs' % stream, self.ncoeffs*struct.calcsize(self.format))
        coeffs = np.array(struct.unpack('>%d%s' % (self.ncoeffs, self.format), coeffs_str))
        return coeffs / (2.**self.bp)

    def initialize(self):
        for stream in range(self.nstreams):
            self.set_coeffs(stream, 100*np.ones(self.ncoeffs,dtype='>%s'%self.format))

class EqTvg(Block):
    def __init__(self, host, name, nstreams=8, nchans=2**13):
        super(EqTvg, self).__init__(host, name)
        self.nstreams = nstreams
        self.nchans = nchans
        self.format = 'B'

    def tvg_enable(self):
        self.write_int('tvg_en', 1)

    def tvg_disable(self):
        self.write_int('tvg_en', 0)

    def write_const_ants(self,equal_pols=False):
        """
            Write a constant to all the channels of a polarization unless 
            equal_pols is set, then a constant is written to all pols of 
            an antenna.
            if `equal_pols`:
               tv[ant][pol] = ant
            else
               tv[ant][pol] = 2*ant + pol
        """
        tv = np.zeros(self.nchans*self.nstreams, dtype='>%s'%self.format)
        if equal_pols:
            for stream in range(self.nstreams):
                tv[stream*self.nchans:(stream+1)*self.nchans] = stream//2
        else:
            for stream in range(self.nstreams):
                tv[stream*self.nchans:(stream+1)*self.nchans] = stream
        self.write('tv',tv.tostring())

    def write_freq_ramp(self,equal_pols=False):
        """ Write a frequency ramp to the test vector 
            that is repeated for all antennas. 
            equal_pols: Write the same ramp to both pols 
            of an antenna.
        """
        ramp = np.arange(self.nchans)
        ramp = np.array(ramp, dtype='>%s' %self.format) # tvg values are only 8 bits
        tv = np.zeros(self.nchans * self.nstreams, dtype='>%s' % self.format)
        if equal_pols:
            for stream in range(self.nstreams):
                tv[stream*self.nchans: (stream+1)*self.nchans] = ramp + stream//2
        else:
            for stream in range(self.nstreams):
                tv[stream*self.nchans: (stream+1)*self.nchans] = ramp + stream
        self.write('tv', tv.tostring())

    def read_tvg(self):
        """ Read the test vector written to the sw bram """
        tvg = struct.unpack('>%d%s'%(self.nchans*self.nstreams,self.format),self.read('tv',8192*8))
        return tvg

    def initialize(self):
        self.tvg_disable()
        self.write_freq_ramp()

class ChanReorder(Block):
    def __init__(self, host, name, nchans=2**10):
        super(ChanReorder, self).__init__(host, name)
        self.nchans = nchans
        self.format = 'L'

    def set_channel_order(self, order):
        """
        Re-order the channels to that they are
        sent with the order in the specified map
        """
        order = list(order)
        if len(order) != self.nchans:
            logger.Error("Tried to reorder channels, but map was the wrong length")
            return
        order_str = struct.pack('>%d%s' %(self.nchans,self.format), *order)
        self.write('reorder3_map1', order_str)

    def read_reorder(self, slot_num=None):
        reorder = self.read('reorder3_map1',1024*4)
        reorder = struct.unpack('>%d%s'%(self.nchans,self.format),reorder)
        if slot_num: 
            return reorder[slot_num*64:(slot_num*64)+(384//8)]
        else:
            return reorder 

    def reindex_channel(self, actual_index, output_index):
        self.write_int('reorder3_map1', actual_index, word_offset=output_index)

    def initialize(self):
        self.set_channel_order(np.arange(self.nchans))
        

class Packetizer(Block):
    def __init__(self, host, name, n_time_demux=2):
        super(Packetizer, self).__init__(host, name)
        self.n_time_demux = n_time_demux
        self.n_slots = 16

    def set_dest_ip(self, ip, slot_offset=0):
        for time_slot in range(self.n_time_demux):
            self.write_int('ips',ip[time_slot], word_offset=(time_slot * self.n_slots + slot_offset))

    def set_ant_header(self, ant, slot_offset=0): 
        for time_slot in range(self.n_time_demux):
            self.write_int('ants', ant, word_offset=(time_slot * self.n_slots + slot_offset))
        
    def set_chan_header(self, chan, slot_offset=0):
        for time_slot in range(self.n_time_demux):
            self.write_int('chans', chan, word_offset=(time_slot*self.n_slots + slot_offset))


    def initialize(self):
        for time_slot in range(self.n_slots):
            self.set_dest_ip([0,0], time_slot)
            self.set_ant_header(0, time_slot)
            self.set_chan_header(0, time_slot)

    def assign_slot(self, slot_num, chans, dests, reorder_block, ant):
        """
        The F-engine generates 8192 channels, but can only
        output 6144(=8192 * 3/4), in order to keep within the output data rate cap.
        Each output packet contains 384 frequency channels for a single antenna.
        There are thus effectively 16 output slots, each corresponding
        to a block of 384 frequency channels. Each block can be filled with
        arbitrary channels (they can repeat, if you want), and sent
        to a particular IP address.
        slot_num -- a value from 0 to 15 -- the slot you want to allocate
        chans    -- an array of 384 channels, which you want to put in this slot's packet
        dests     -- A list of IP addresses of the odd and even X-engines for this chan range.
        reorder_block -- a ChanReorder block object, which allows the
                         packetizer to manipulate the channel ordering of the design. Bit gross. Sorry.
        ants     -- The antenna index of the first antenna on this board. One packet contains 3 antennas

        """
        NCHANS_PER_SLOT = 384
        chans = np.array(chans, dtype='>L')
        if slot_num > self.n_slots:
            raise ValueError("Only %d output slots can be specified" % self.n_slots)
        if chans.shape[0] != NCHANS_PER_SLOT:
            raise ValueError("Each slot must contain %d frequency channels" % NCHANS_PER_SLOT)

        if (type(dests) != list) or (len(dests) != self.n_time_demux):
            raise ValueError("Packetizer requires a list of desitination IPs with %d entries" % self.n_time_demux)

        # Set the frequency header of this slot to be the first specified channel
        self.set_chan_header(chans[0], slot_offset=slot_num)

        # Set the antenna header of this slot (every slot represents 3 antennas
        self.set_ant_header(ant=ant, slot_offset=slot_num)

        # Set the destination address of this slot to be the specified IP address
        self.set_dest_ip(dests, slot_offset=slot_num)

        # set the channel orders
        # The channels supplied need to emerge in the first 384 channels of a block
        # of 512 (first 192 clks of 256clks for 2 pols)
        for cn, chan in enumerate(chans[::8]):
            reorder_block.reindex_channel(chan//8, slot_num*64 + cn)

        
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
        #rv['rx_overrun'  ] =  (stat >> 0) & 1   
        #rv['rx_bad_frame'] =  (stat >> 1) & 1
        #rv['tx_of'       ] =  (stat >> 2) & 1   # Transmission FIFO overflow
        #rv['tx_afull'    ] =  (stat >> 3) & 1   # Transmission FIFO almost full
        #rv['tx_led'      ] =  (stat >> 4) & 1   # Transmission LED
        #rv['rx_led'      ] =  (stat >> 5) & 1   # Receive LED
        #rv['up'          ] =  (stat >> 6) & 1   # LED up
        #rv['eof_cnt'     ] =  (stat >> 7) & (2**25-1)
        rv['tx_of'        ] =  self.read_uint('sw_txofctr')
        rv['tx_full'      ] =  self.read_uint('sw_txfullctr')
        rv['tx_err'       ] =  self.read_uint('sw_txerrctr')
        rv['tx_vld'       ] =  self.read_uint('sw_txvldctr')
        rv['tx_ctr'       ] =  self.read_uint('sw_txctr')
        return rv
        
    def status_reset(self):
        self.change_reg_bits('ctrl', 0, 18)
        self.change_reg_bits('ctrl', 1, 18)
        self.change_reg_bits('ctrl', 0, 18)

    def set_port(self, port):
        self.port = port
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
        ipaddr = socket.inet_aton(socket.gethostbyname(self.host.host))
        self.blindwrite('sw', ipaddr, offset=0x10)
        self.set_port(self.port)
                        
    def print_status(self):
        rv = self.get_status()
        for key in rv.keys():
            print '%12s : %d'%(key,rv[key])


class Corr(Block):
    def __init__(self, host, name, acc_len=61035):
        super(Corr, self).__init__(host,name)
        self.acc_len = acc_len
        
    def get_new_corr(self, antenna1, antenna2):
        self.write_int('input_sel',(antenna1 + (antenna2 << 8)))
        cnt = self.read_uint('acc_cnt')

        # Wait for 2 counts to make sure we have a clean
        # integration containing only the selected antennas
        while self.read_uint('acc_cnt') < (cnt + 2):
            time.sleep(0.1)
            
        spec = np.array(struct.unpack('>2048L',self.read('dout',8*1024)))
        
        return (spec[0::2]+1j*spec[1::2])/self.acc_len
    
    def plot_corr(self,antenna1,antenna2,show=True,test=False):
        import matplotlib.pyplot as plt
        spec = self.get_new_corr(antenna1,antenna2)
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

    def set_acc_len(self,acc_len):
        acc_len = 8192*acc_len #Convert to clks from spectra 
        self.write_int('acc_len',acc_len)

    def initialize(self):
        self.set_acc_len(self.acc_len)

            
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

