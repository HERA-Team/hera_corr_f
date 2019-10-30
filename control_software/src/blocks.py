import logging
import numpy as np
import struct
import socket
import time
import casperfpga
import casperfpga.snapadc
import helpers
from casperfpga import i2c
from casperfpga import i2c_gpio
from casperfpga import i2c_volt
from casperfpga import i2c_eeprom
from casperfpga import i2c_sn
from casperfpga import i2c_bar
from casperfpga import i2c_motion
from casperfpga import i2c_temp
from scipy.linalg import hadamard #for walsh (hadamard) matrices

# There are so many I2C warnings that a new level is defined
# to filter them out
I2CWARNING = logging.INFO - 5
logging.addLevelName('I2CWARNING', I2CWARNING)

# Block Classes
class Block(object):
    def __init__(self, host, name, logger=None):
        self.host = host #casperfpga object
        # One logger per host. Multiple blocks share the same logger.
        # Multiple hosts should *not* share the same logger, since we can multithread over hosts.
        self.logger = logger or helpers.add_default_log_handlers(logging.getLogger(__name__ + ":%s" % (host.host)))
        self.name = name
        if (name is None) or (name == ''):
            self.prefix = ''
        else:
            self.prefix = name + '_'

    def _prefix_log(self, msg):
        """
        Take a log message, and prefix it with "<block> - ".
        Eg, take "Argh, I'm broken" and replace it with
        "eq_tvg - Argh I'm broken"
        """
        prefix = "%s - " % self.name
        return prefix + msg

    def _debug(self, msg, *args, **kwargs):
        self.logger.debug(self._prefix_log(msg), *args, **kwargs)

    def _info(self, msg, *args, **kwargs):
        self.logger.info(self._prefix_log(msg), *args, **kwargs)

    def _warning(self, msg, *args, **kwargs):
        self.logger.warning(self._prefix_log(msg), *args, **kwargs)

    def _error(self, msg, *args, **kwargs):
        self.logger.error(self._prefix_log(msg), *args, **kwargs)

    def _critical(self, msg, *args, **kwargs):
        self.logger.critical(self._prefix_log(msg), *args, **kwargs)

    def _exception(self, msg, *args, **kwargs):
        self.logger.exception(self._prefix_log(msg), *args, **kwargs)

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
    def __init__(self, host, name, logger=None):
        self.logger = logger or helpers.add_default_log_handlers(logging.getLogger(__name__ + "%s" % (host.host)))
        super(Synth, self).__init__(host, name)
        self.host = host 

    def initialize(self):
        """
        Seem to have to do this if reference
        was not present when board was powered up(?)
        """
        #Ed. This seems to break things?
        #self.powerOff()
        #self.powerOn()
        pass

class Adc(casperfpga.snapadc.SNAPADC):
    def __init__(self, host, sample_rate=500, num_chans=2, resolution=8, ref=10, logger=None, **kwargs):
        """
        Instantiate an ADC block.
        
        Inputs:
           host (casperfpga.Casperfpga): Host FPGA
           sample_rate (float): Sample rate in MS/s
           num_chans (int): Number of channels per ADC chip. Valid values are 1, 2, or 4.
           resolution (int): Bit resolution of the ADC. Valid values are 8, 12.
           ref (float): Reference frequency (in MHz) from which ADC clock is derived. If None, an external sampling clock must be used.
        """
        self.logger = logger or helpers.add_default_log_handlers(logging.getLogger(__name__ + ":%s" % (host.host)))
        casperfpga.snapadc.SNAPADC.__init__(self, host, ref=ref, logger=self.logger)
        self.name            = 'SNAP_adc'
        self.num_chans       = num_chans
        self.interleave_mode = 4 >> num_chans
        self.clock_divide    = 1
        self.sample_rate     = sample_rate
        self.resolution      = resolution
        self.host = host # the SNAPADC class doesn't directly expose this
        self._retry = kwargs.get('retry',5)
        self._retry_wait = kwargs.get('retry_wait',1)

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
        """
        Initialize the configuration of the ADC chip.
        Returns True if initialization was successful. False otherwise.
        """
        status = True
        for i in range(self._retry):
            if self.init(self.sample_rate, self.num_chans):
                if i == 0:
                    self.logger.info("ADC configured OK")
                if i > 0:
                    self.logger.warning("ADC took %d attempts to configure" % (i+1))
                break
            if i == self._retry - 1:
                self.logger.error("ADC failed to configure after %d attempts" % (i+1))
                status = False

        self.selectADC()
        self.adc.selectInput([1,1,3,3])
        self.set_gain(4)
        return status

class Sync(Block):
    def __init__(self, host, name, logger=None):
        super(Sync, self).__init__(host, name, logger)
        self.OFFSET_ARM_SYNC  = 0
        self.OFFSET_ARM_NOISE = 1
        self.OFFSET_SW_SYNC   = 4
    
    def uptime(self):
        """
        Returns uptime in seconds, assumes 250 MHz FPGA clock
        """
        return self.read_uint('uptime')

    def set_delay(self, delay):
        """
        Set the delay, in FPGA clock ticks, between the arrival of an external
        sync pulse and the issuing of an internal trigger.
        inputs:
            delay (integer) : Number of FPGA clocks delay
        """
        self.write_int('sync_delay', delay)

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
        self._info("Changed sync period to %.2f"%period)

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
        """
        Initialize this block. Set sync period to 0.
        """
        self.write_int('arm', 0)
        #self.change_period(2**16 * 9*7*6*5*3)
        self.change_period(0)

class NoiseGen(Block):
    def __init__(self, host, name, nstreams=6, logger=None):
        super(NoiseGen, self).__init__(host, name, logger)
        self.nstreams = nstreams

    def set_seed(self, stream, seed):
        """
        Set the seed of the noise generator for a given stream.
        """
        if stream > self.nstreams:
            self._error('Tried to set noise generator seed for stream %d > nstreams (%d)' % (stream, self.nstreams))
            return
        if seed > 255:
            self._error('Seed value is an 8-bit integer. It cannot be %d' % seed)
            return
        stream = 2*stream # latest block counts in antennas
        regname = 'seed_%d' % (stream // 4)
        self.change_reg_bits(regname, seed, 8 * (stream % 4), 8)

    def get_seed(self, stream):
        """
        Get the seed of the noise generator for a given stream.
        """
        if stream > self.nstreams:
            self._error('Tried to get noise generator seed for stream %d > nstreams (%d)' % (stream, self.nstreams))
            return
        stream = 2*stream # latest block counts in antennas
        regname = 'seed_%d' % (stream // 4)
        return (self.read_uint(regname) >> (8 * stream % 4)) & 0xff


    def initialize(self):
        for stream in range(self.nstreams):
            self.set_seed(0, stream)

    def print_status(self):
        for stream in range(self.nstreams):
            print 'NoiseGen block: %s: stream %d seed: %d' % (self.name, stream, self.get_seed(stream))
       

class Input(Block):
    def __init__(self, host, name, nstreams=6, logger=None):
        """
        Instantiate an input contol block.
        
        Inputs:
            host (casperfpga.CasperFpga): Host FPGA object
            name (string): Name (in simulink) of this block
            nstreams (int): Number of streams this block handles
        """
        super(Input, self).__init__(host, name, logger)
        self.nstreams = nstreams
        self.ninput_mux_streams = nstreams // 2
        self.USE_NOISE = 0
        self.USE_ADC   = 1
        self.USE_ZERO  = 2
        self.INT_TIME  = 2**20 / 250.0e6
        self._SNAPSHOT_SAMPLES_PER_POL = 2048

    def get_adc_snapshot(self, antenna):
        """
        Get a block of samples from both pols of `antenna`
        returns samples_x, samples_y
        """
        if "snap_sel" in self.listdev():
            return self._get_adc_snapshot_single_ant(antenna)
        else:
            return self._get_adc_snapshot_all_ants(antenna)

    def _get_adc_snapshot_single_ant(self, antenna):
        """
        Get a block of samples from both pols of `antenna`
        returns samples_x, samples_y
        """
        self.write_int('snap_sel', antenna)
        self.write_int('snapshot_ctrl', 0)
        self.write_int('snapshot_ctrl', 1)
        self.write_int('snapshot_ctrl', 3)
        d = struct.unpack('>%db' % (2*self._SNAPSHOT_SAMPLES_PER_POL), self.read('snapshot_bram', 2*self._SNAPSHOT_SAMPLES_PER_POL))
        x = []
        y = []
        for i in range(self._SNAPSHOT_SAMPLES_PER_POL // 2):
            x += [d[4*i]]
            x += [d[4*i + 1]]
            y += [d[4*i + 2]]
            y += [d[4*i + 3]]
        return np.array(x), np.array(y)

    def _get_adc_snapshot_all_ants(self, antenna):
        """
        Get a block of samples from both pols of `antenna`
        returns samples_x, samples_y
        """
        self.write_int('snapshot_ctrl', 0)
        self.write_int('snapshot_ctrl', 1)
        self.write_int('snapshot_ctrl', 3)
        d = struct.unpack('>%db' % (16 * self._SNAPSHOT_SAMPLES_PER_POL // 2), self.read('snapshot_bram', 16 * self._SNAPSHOT_SAMPLES_PER_POL // 2))
        x = []
        y = []
        for i in range(self._SNAPSHOT_SAMPLES_PER_POL // 2):
            # Add 1 to antenna since there is a dummy ant 0 which is all zeros
            x += [d[16*i + 4*(antenna+1)]]
            x += [d[16*i + 4*(antenna+1) + 1]]
            y += [d[16*i + 4*(antenna+1) + 2]]
            y += [d[16*i + 4*(antenna+1) + 3]]
        return np.array(x), np.array(y)

    def get_power_spectra(self, antenna, acc_len=1):
        """
        Perform a software FFT of samples from `antenna`.
        Accumulate power from `acc_len` snapshots.
        returns power_spectra_X, power_spectra_Y
        """
        X = np.zeros(self._SNAPSHOT_SAMPLES_PER_POL // 2 + 1)
        Y = np.zeros(self._SNAPSHOT_SAMPLES_PER_POL // 2 + 1)
        for i in range(acc_len):
            x, y = self.get_adc_snapshot(antenna)
            X += np.abs(np.fft.rfft(x))**2
            Y += np.abs(np.fft.rfft(y))**2
        return X, Y

    def use_noise(self, stream=None):
        """
        Switch input to internal noise source.
        Inputs:
            stream (int): Which stream to switch. If None, switch all.
        """
        if stream is None:
            v = 0
            for stream in range(self.ninput_mux_streams):
                v += self.USE_NOISE << (2 * stream)
            self.write_int('source_sel', v)
        else:
            self.change_reg_bits('source_sel', self.USE_NOISE, 2*(self.ninput_mux_streams-1-stream), 2)

    def use_adc(self, stream=None):
        """
        Switch input to ADC.
        Inputs:
            stream (int): Which stream to switch. If None, switch all.
        """
        if stream is None:
            v = 0
            for stream in range(self.ninput_mux_streams):
                v += self.USE_ADC << (2 * stream)
            self.write_int('source_sel', v)
        else:
            self.change_reg_bits('source_sel', self.USE_ADC, 2*(self.ninput_mux_streams-1-stream), 2)

    def use_zero(self, stream=None):
        """
        Switch input to zeros.
        Inputs:
            stream (int): Which stream to switch. If None, switch all.
        """
        if stream is None:
            v = 0
            for stream in range(self.ninput_mux_streams):
                v += self.USE_ZERO << (2 * stream)
            self.write_int('source_sel', v)
        else:
            self.change_reg_bits('source_sel', self.USE_ZERO, 2*(self.ninput_mux_streams-1-stream), 2)

    def get_stats(self, sum_cores=False):
        """
        Get the mean, RMS, and powers of
        all 12 ADC cores.
        Inputs:
            sum_cores (Boolean): If True, combine interleaved samples. If False, return stats for each of 12 ADC cores.
        Returns:
            means, powers, rmss. Each is a numpy array with one entry per input. (Or 12 entries if sum_cores=False)
        """
        self.write_int('rms_enable', 1)
        time.sleep(0.01)
        self.write_int('rms_enable', 0)
        x = np.array(struct.unpack('>%dl' % (2*self.nstreams), self.read('rms_levels', self.nstreams * 8)))
        self.write_int('rms_enable', 1)
        means    = x[0::2] / 2.**16
        powers   = x[1::2] / 2.**16
        rmss     = np.sqrt(powers)
        if sum_cores:
            means = [(means[2*i] + means[2*i+1]) / 2. for i in range(self.nstreams/2)]
            powers = [(powers[2*i] + powers[2*i+1]) / 2. for i in range(self.nstreams/2)]
            rmss = np.sqrt(powers)
        return means, powers, rmss

    def initialize(self):
        """
        Switch to ADCs. Begin computing stats.
         """
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

    def set_input(self, i):
        """
        Set input of histogram block.
        Inputs:
            i (int): Stream number to select.
        """
        self.write_int('bit_stats_input_sel', i)

    def get_histogram(self, input, sum_cores=True):
        """
        Get a histogram for an ADC input.
        Inputs:
            input (int): ADC input from which to get data.
            sum_cores (Boolean): If True, compute one histogram from both A & B ADC cores. If False, compute separate histograms.

        Returns:
            If sum_cores is True:
                vals, hist
                    vals (numpy array): histogram bin centers
                    hist (numpy array): histogram data
            If sum_cores is False:
                vals, hist_a, hist_b
                    vals (numpy array): histogram bin centers
                    hist_a (numpy array): histogram data for "A" cores
                    hist_b (numpy array): histogram data for "B" cores
        """
        self.set_input(input)
        time.sleep(0.1)
        v = np.array(struct.unpack('>512H', self.read('bit_stats_histogram_output', 512*2)))
        a = v[0:256]
        b = v[256:512]
        a = np.roll(a, 128) # roll so that array counts -128, -127, ..., 0, ..., 126, 127
        b = np.roll(b, 128) # roll so that array counts -128, -127, ..., 0, ..., 126, 127
        vals = np.arange(-128,128)
        if sum_cores:
            return vals, a+b
        else:
            return vals, a, b

    def get_input_histogram(self, antpol):
        """
        Get a histgram for a given antpol, summing over all interleaving
        Input:
            ant (int): Antpol number (zero-indexed)
        Returns:
            vals, hist
                vals (numpy array): histogram bin centers
                hist (numpy array): histogram data
        """
        
        vals, a = self.get_histogram(antpol*2, sum_cores=True)
        vals, b = self.get_histogram(antpol*2 + 1, sum_cores=True)
        return vals, a+b

    def get_all_histograms(self):
        """
        Get histograms for all antpols, summing over all interleaving
        Input:
            antpol (int): Antpol number (zero-indexed)
        Returns:
            vals, hist
                vals (numpy array): histogram bin centers
                hist (numpy array): histogram data
        """
        out = np.zeros([self.nstreams, 256])
        for stream in range(self.nstreams/2):
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
    def __init__(self, host, name, nstreams=6, logger=None):
        """
        Instantiate a delay contol block.
        
        Inputs:
            host (casperfpga.CasperFpga): Host FPGA object
            name (string): Name (in simulink) of this block
            nstreams (int): Number of streams this block handles
        """
        super(Delay, self).__init__(host, name, logger)
        self.nstreams = nstreams

    def set_delay(self, stream, delay):
        """
        Insert a delay to a given input stream.

        Inputs:
            stream (int): Which antpol to delay.
            delay (int): Number of FPGA clock cycles of delay to insert.
        """
        if stream > self.nstreams:
            self._error('Tried to set delay for stream %d > nstreams (%d)' % (stream, self.nstreams))
        # MSBs of 232-bit register are for stream 0, etc...
        self.change_reg_bits('delays', delay, 32-4-(4*stream), 4)

    def initialize(self):
        """
        Initialize all delays to 0.
        """
        self.write_int('delays', 0)

class Pfb(Block):
    def __init__(self, host, name, logger=None):
        super(Pfb, self).__init__(host, name, logger)
        self.SHIFT_OFFSET = 0
        self.SHIFT_WIDTH  = 16
        self.PRESHIFT_OFFSET = 16
        self.PRESHIFT_WIDTH  = 2
        self.STAT_RST_BIT = 18

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
        self.set_fft_shift(0b110101010101)
        self.rst_stats()

class PhaseSwitch(Block):
    def __init__(self, host, name, nstreams=6, depth=2**12, periodbase=2**18, logger=None):
        super(PhaseSwitch, self).__init__(host, name, logger)
        self.nstreams = nstreams
        self.depth = depth           # number of brams steps in a period
        self.periodbase = periodbase # number of clock cycles in one bram step

    def set_walsh(self, stream, N, n, stepperiod):
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
        self.write('sw_switch_states', struct.pack('>%dB' % self.depth, *new_bram_vec))

    def set_all_walsh(self, N, n, stepperiod):
        """
        Set multiple walsh patterns simultaneously.
        N: order of walsh matrix
        n: list of walsh indices with length self.nstreams, containing walsh indices to give each stream.
        stepperiod: period (2^?), in multiples of self.periodbase FPGA clocks,
                of shortest walsh step. I.e., 2**13 * 2**self.baseperiod * N
                = period of complete cycle in FPGA clocks.
        """
        N_round = int(2**(np.ceil(np.log2(N))))
        walsh_matrix = hadamard(N_round)
        # reformat so 1 means multiply by -1, and 0 means multiply by 1
        walsh_matrix[walsh_matrix == 1]  = 0
        walsh_matrix[walsh_matrix == -1] = 1
        bram_array = np.zeros(self.depth, dtype=np.int)
        for stream in range(self.nstreams):
            walsh_func = walsh_matrix[n[stream]] # a vector of length N_round
            walsh_func_stretch = walsh_func.repeat(2**stepperiod) # a vector of length N_round * 2*step_period

            # The counter in the FPGA cycles through <depth> ram addresses, so repeat
            # the sequence. Since N_round and 2**stepperiod are always powers of 2,
            # this is always an integer number of cycles
            vec = np.array(walsh_func_stretch.tolist() * (self.depth/ 2**stepperiod / N_round), dtype=np.int)
            bram_array += (vec << stream)
        #Modify the appropriate bits of the bram
        self.write('gpio_switch_states', struct.pack('>%dB' % self.depth, *bram_array))
        self.write('sw_switch_states', struct.pack('>%dB' % self.depth, *bram_array))
        
    def set_gpio_high(self, stream):
        #Modify the appropriate bits of the bram
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('gpio_switch_states', self.depth)))
        new_bram_vec  = curr_bram_vec & (0xff - (1 << stream)) # zero the stream we are writing
        new_bram_vec += (np.ones(self.depth, dtype=np.int) << stream)
        self.write('gpio_switch_states', struct.pack('>%dB' % self.depth, *new_bram_vec))

    def set_gpio_low(self, stream):
        #Modify the appropriate bits of the bram
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('gpio_switch_states', self.depth)))
        new_bram_vec  = curr_bram_vec & (0xff - (1 << stream)) # zero the stream we are writing
        self.write('gpio_switch_states', struct.pack('>%dB' % self.depth, *new_bram_vec))

    def get_mod_pattern(self, stream):
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('gpio_switch_states', self.depth)))
        return (curr_bram_vec & (1 << stream)) >> stream

    def get_demod_pattern(self, stream):
        curr_bram_vec = np.array(struct.unpack('>%dB' % self.depth, self.read('sw_switch_states', self.depth)))
        return (curr_bram_vec & (1 << stream)) >> stream

    def set_delay(self, delay):
        """
        set the delay (in FPGA clock cycles) between
        the modulation and demodulation patterns
        (to take into account cable latency)
        """
        self.write_int('gpio_switch_offset', delay)

    def enable_mod(self):
        """
        Turn on the modulation patterns
        """
        self.write_int('enable_mod', 1)

    def disable_mod(self):
        """
        Turn off the modulation patterns
        """
        self.write_int('enable_mod', 0)

    def enable_demod(self):
        """
        Turn on the demodulation patterns
        """
        self.write_int('enable_demod', 1)

    def disable_demod(self):
        """
        Turn off the demodulation patterns
        """
        self.write_int('enable_demod', 0)

    def initialize(self):
        """
        Initialize, turning off walshing
        """
        for stream in range(self.nstreams):
            self.set_walsh(stream, 1, 0, 1)
        self.disable_mod()
        self.disable_demod()
        self.set_delay(0)
        
class Eq(Block):
    def __init__(self, host, name, nstreams=8, ncoeffs=2**10, logger=None):
        """
        Instantiate an EQ block
        
        Inputs:
            host (casperfpga.CasperFpga): Host FPGA object
            name (string): Name (in simulink) of this block
            nstreams (int): Number of streams this block handles
            ncoeffs (int): Number of coefficients per input stream
        """
        super(Eq, self).__init__(host, name, logger)
        self.nstreams = nstreams
        self.ncoeffs = ncoeffs
        self.width = 16
        self.bp = 5
        self.format = 'H'#'L'
        self.streamsize = struct.calcsize(self.format)*self.ncoeffs

    def set_coeffs(self, stream, coeffs):
        """
        Set the coefficients for a data stream. Clipping and saturation will be applied before
        loading.
        
        Inputs
           stream (int): Which stream to manipulate
           coeffs (list or numpy array): Coefficients to load.
        """
        coeffs *= 2**self.bp
        if np.any(coeffs > (2**self.width - 1)):
            self._warning("Some coefficients out of range")
        # Make integer
        coeffs = np.array(coeffs, dtype=np.int64)
        # saturate coefficients
        coeffs[coeffs>(2**self.width - 1)] = 2**self.width - 1
        coeffs = list(coeffs)
        assert len(coeffs) == self.ncoeffs, "Length of provided coefficient vector should be %d" % self.ncoeffs
        coeffs_str = struct.pack('>%d%s' % (len(coeffs), self.format), *coeffs)
        self.write('coeffs', coeffs_str, offset= self.streamsize * stream)

    def get_coeffs(self, stream):
        """
        Get the coefficients currently loaded. Reads the actual coefficients from the board.
        Inputs:
            stream (int): Stream index to query
        Returns
            numpy array of `self.ncoeffs` coefficients currently being applied to this stream.
        """
        coeffs_str = self.read('coeffs', self.streamsize, offset= self.streamsize * stream)
        coeffs = np.array(struct.unpack('>%d%s' % (self.ncoeffs, self.format), coeffs_str))
        return coeffs / (2.**self.bp)

    def clip_count(self):
        """
        Get the total number of times any samples have clipped, since last sync.
        """
        return self.read_uint('clip_cnt')

    def print_status(self):
        print 'Number of times input got clipped: %d'%self.clip_count()

    def initialize(self):
        """
        Initialize block, setting coefficients to some nominally sane value.
        Currently, this is 100.0
        """
        for stream in range(self.nstreams):
            self.set_coeffs(stream, 100*np.ones(self.ncoeffs,dtype='>%s'%self.format))

class EqTvg(Block):
    def __init__(self, host, name, nstreams=8, nchans=2**13, logger=None):
        super(EqTvg, self).__init__(host, name, logger)
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
        for i in range(self.nstreams // 2):
            self.write('tv%d' % i,tv.tostring()[i*self.nchans*2:(i+1)*self.nchans*2])

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
        for i in range(self.nstreams // 2):
            self.write('tv%d' % i,tv.tostring()[i*self.nchans*2:(i+1)*self.nchans*2])

    def read_tvg(self):
        """ Read the test vector written to the sw bram """
        s = ""
        for i in range(self.nstreams // 2):
            s += self.read('tv%d' % i, self.nchans * 2)
        tvg = struct.unpack('>%d%s'%(self.nchans*self.nstreams, self.format), s)
        return tvg

    def initialize(self):
        self.tvg_disable()
        self.write_freq_ramp()

class ChanReorder(Block):
    def __init__(self, host, name, nchans=2**10, logger=None):
        super(ChanReorder, self).__init__(host, name, logger)
        self.nchans = nchans
        self.format = 'L'

    def set_channel_order(self, order):
        """
        Re-order the channels to that they are
        sent with the order in the specified map
        """
        order = list(order)
        if len(order) != self.nchans:
            self._error("Tried to reorder channels, but map was the wrong length")
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
    def __init__(self, host, name, n_time_demux=2, logger=None):
        super(Packetizer, self).__init__(host, name, logger)
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

class Rotator(Block):
    coeff_bits = 32
    coeff_bp = 31
    def __init__(self, host, name, n_chans=2**13, n_streams=2**3, max_spec=2**19, block_size=2**10, logger=None):
        """
        Construct a Phase Rotator block.
        Arguments:
            host (CasperFpga): FPGA interface
            name (string): Name of this block in simulink
            n_chans (int): Number of channels in a spectra
            max_spectra (int): Number of spectra before cycling coefficients
            n_stream (int): Number of serial polarizations this block processes
            block_size (int): Number of spectra sharing a coefficient
        """
        super(Rotator, self).__init__(host, name, logger)
        self.n_chans = n_chans
        self.n_streams = n_streams
        self.max_spec = max_spec
        self.block_size = block_size
        self.n_slots = self.max_spec / self.block_size

    def _get_ant_offset_bytes(self, ant):
        """
        Get the offset in bytes where coefficients for antenna index `ant` are stored.
        """
        return (self.coeff_bits // 8) * self.n_slots * ant

    def set_ant_phases(self, ant, phases):
        """
        Set the coefficients for `ant` to `phases`.
        The latter should be a numpy array of phases. It
        will be repeated as necessary to fill the bram.
        """
        try:
            phases = np.array(phases)
        except:
            self._error("Couldn't convert phase coefficients to numpy array")
            return
        n_coeffs = phases.shape[0]
        if self.n_slots % n_coeffs != 0:
            self._error("Number of slots is not an integer multiple of number of phase coefficients")
            return
        phases = np.tile(phases, self.n_slots // n_coeffs)
        # sanity check
        assert phases.shape[0] == self.n_slots
        # scale for firmware binary point and check for overflow
        phases_scaled = phases * 2**self.coeff_bp
        assert np.max(np.abs(phases_scaled)) < (2**self.coeff_bp - 1)

        # write to appropriate memory segment for this antenna
        assert ant < self.n_streams//2

        phases_str = struct.pack('>%dl' % (phases_scaled.shape[0]), *phases_scaled)

        self.write("phases", phases_str, offset=self._get_ant_offset_bytes(ant))

    def get_ant_phases(self, ant):
        """
        Get a numpy array of the phases stored for antenna `ant`
        """
        phases_str = self.read('phases', self.n_slots * (self.coeff_bits // 8), offset=self._get_ant_offset_bytes(ant))
        return np.array(struct.unpack('>%dl' % (len(phases_str)//4), phases_str), dtype=np.float64) / 2**self.coeff_bp


    def enable(self):
        self.write_int('en', 1)

    def disable(self):
        self.write_int('en', 0)

    def is_enabled(self):
        return self.read_int('en') == 1

    def initialize(self):
        self.disable()
        for ant in range(self.n_streams // 2):
            self.set_ant_phases(ant, [0])

    def print_status(self):
        print "Is enabled?", self.is_enabled

        
class Eth(Block):
    def __init__(self, host, name, port=10000, logger=None):
        super(Eth, self).__init__(host, name, logger)
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

    def set_source_port(self, port):
        # see config_10gbe_core in katcp_wrapper
        self.blindwrite('sw', struct.pack('>BBH', 0, 1, port), offset=0x20)
                        
    def print_status(self):
        rv = self.get_status()
        for key in rv.keys():
            print '%12s : %d'%(key,rv[key])


class Corr(Block):
    def __init__(self, host, name, acc_len=3815, logger=None):
        """
        Instantiate an correlation block, which allows correlation
        of pairs of inputs to be computed.
        
        Inputs:
            host (casperfpga.CasperFpga): Host FPGA object
            name (string): Name (in simulink) of this block
            acc_len (int): Number of spectra to accumulate
        """
        super(Corr, self).__init__(host, name, logger)
        self.nchans = 1024
        self.acc_len = acc_len
        self.spec_per_acc = 8
        self.format='l'
   
    def set_input(self, pol1, pol2):
        """
        Set correlation inputs to `pol1`, `pol2`
        """
        self.write_int('input_sel',(pol1 + (pol2<<8)))
 
    def wait_for_acc(self):
        """
        Wait for a new accumulation to complete.
        """
        cnt = self.read_uint('acc_cnt')
        while self.read_uint('acc_cnt') < (cnt+1):
            time.sleep(0.1)
        return 1

    def read_bram(self, flush_vacc=True):
        """ 
        Waits for the next accumulation to complete and then
        outputs the contents of the results BRAM. If you want a 
        fresh accumulation use get_new_corr(pol1, pol2) instead.
        Returns:
            complex numpy array containing cross-correlation spectra
        """
        if flush_vacc:
            self.wait_for_acc()
        spec = np.array(struct.unpack('>2048l',self.read('dout',8*1024)))
        spec = (spec[0::2]+1j*spec[1::2])
        return spec
    
    def get_new_corr(self, pol1, pol2, flush_vacc=True):
        """
        Get a new correlation with the given inputs.
        Flushes a correlation after setting inputs, to prevent any contaminated results.
        Input Pol Mapping: [1a, 1b, 2a, 2b, 3a, 3b] : [0, 1, 2, 3, 4, 5, 6, 7]
        Returns: complex nump array of shape(1024,), containing cross-correlation spectra
                 with accumulation length divided out.

        """
        self.set_input(pol1,pol2)
        if flush_vacc:
            self.wait_for_acc()      # Wait two acc_len for new spectra to load
        spec = self.read_bram()/float(self.acc_len*self.spec_per_acc)
        if pol1==pol2:
            return spec.real + 1j*np.zeros(len(spec))
        else:
            return spec

    def get_max_hold(self, pol):
        """
        Mode works only for auto correlations.
        Mapping: [1a, 1b, 2a, 2b, 3a, 3b] : [0, 1, 2, 3, 4, 5, 6, 7]
        """
        self.set_input(pol,pol)
        self.wait_for_acc()
        spec = self.read_bram()
        return spec.imag 

    def plot_corr(self, pol1, pol2, show=False):
        from matplotlib import pyplot as plt
        spec = self.get_new_corr(pol1, pol2)
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

    def show_corr_plot(self):
        from matplotlib import pyplot as plt
        plt.show()

    def get_acc_len(self):
        """
        Get the currently loaded accumulation length. In FPGA clocks
        """
        #Convert to spectra from clocks. See Firmware for reasoning behind 1024
        self.acc_len = self.read_int('acc_len') // 1024
        return self.acc_len

    def set_acc_len(self,acc_len):
        """
        Set the number of spectra to accumulate to `acc_len`
        """
        assert isinstance(acc_len, int), "Cannot set accumulation length to type %r" % type(acc_len)
        self.acc_len = acc_len
        acc_len = 1024*acc_len  #Convert to clks from spectra. See Firmware for reasoning behind 1024
        self.write_int('acc_len',acc_len)

    def initialize(self):
        self.set_acc_len(self.acc_len)

            
class RoachInput(Block):
    def __init__(self, host, name, nstreams=32, logger=None):
        super(RoachInput, self).__init__(host, name, logger)
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
    def __init__(self, host, name, nstreams=6, logger=None):
        super(RoachDelay, self).__init__(host, name, logger)
        self.nstreams = nstreams
        self.nregs = nstreams // 4

    def set_delay(self, stream, delay):
        if stream > self.nstreams:
            self._error('Tried to set delay for stream %d > nstreams (%d)' % (stream, self.nstreams))
        delay_reg = stream // 4
        reg_pos   = stream % 4
        self.change_reg_bits('%d' % delay_reg, delay, 8*reg_pos, 8)

    def initialize(self):
        for i in range(self.nregs):
            self.write_int('%d' % i, 0)

class RoachPfb(Block):
    def __init__(self, host, name, logger=None):
        super(RoachPfb, self).__init__(host, name, logger)
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
    def __init__(self, host, name, port=10000, logger=None):
        super(RoachEth, self).__init__(host, name, logger)
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

    ADDR_VOLT = 0x36
    ADDR_ROM  = 0x52
    ADDR_SN   = 0x50
    ADDR_INA  = 0x44
    ADDR_GPIO = 0x21

    CLK_I2C_BUS = 10  # 10 kHz
    CLK_I2C_REF = 100 # reference clk at 100 MHz

    I2C_RETRY = 3

    SHUNT_RESISTOR = 0.1

    RMS2DC_SLOPE = 27.31294863
    RMS2DC_INTERCEPT = -55.15991678

    def __init__(self, host, name, logger=None):
        """ Post Amplifier Module (PAM) digital control class

            Features:
            attenuation Digital controlled Attenuation for East and North Pol
            shunt       Voltage and current of the power supply
            rom         Memo
            id          Device ID
            power       Power level of East and North Pol

        host    CasperFpga instance
        name    Select one of the three PAMs(/Antennas) under the control of
                a SNAP board. Recommended values are: 'i2c_ant1', 'i2c_ant2'
                or 'i2c_ant3'. Please refer to the f-engine model for correct
                value.
        """
        super(Pam, self).__init__(host, name, logger)

        self.i2c = i2c.I2C(host, name, retry=self.I2C_RETRY)

    def _warning(self, msg, *args, **kwargs):
        self.logger.log(I2CWARNING, self._prefix_log(msg), *args, **kwargs)

    def initialize(self):

        self.i2c.enable_core()
        # set i2c bus to 10 kHz
        self.i2c.setClock(self.CLK_I2C_BUS, self.CLK_I2C_REF)


    def get_attenuation(self):
        """ Get East and North attenuation
            returns: (east attenuation (dB, int), north attenuation (dB, int)
        """
        if not hasattr(self, "_atten"):
            try:
                # Attenuator
                self._atten = i2c_gpio.PCF8574(self.i2c, self.ADDR_GPIO)
            except:
                self._warning("Failed to initialize I2C attenuator")
                return None, None

        try:
            val=self._atten.read()
            ve,vn=self._gpio2db(val)
            return ve,vn
        except Exception:
            self._warning('Failed to read I2C attenuator')
            return None,None

    def set_attenuation(self, east=None, north=None):
        """ Set East and North attenuation in dB
            attenuation value must be integer in range(16)

            Example:
            attenuation(east=0,north=15)
            attenuation(east=12)
            
            If only one pol is specified, a read is issued to
            figure out what the other value should be.
        """
        if not hasattr(self, "_atten"):
            try:
                # Attenuator
                self._atten = i2c_gpio.PCF8574(self.i2c, self.ADDR_GPIO)
            except:
                self._warning("Failed to initialize I2C attenuator")

        try:
            if (east is None) or (north is None):
                # Get current attenuation
                ve,vn=self.get_attenuation()
                if (ve is None) or (vn is None):
                    raise Exception('Failed to read I2C attenuator')
                ve = east or ve
                vn = north or vn
                self.set_attenuation(east=ve, north=vn)
            elif isinstance(east,int) and east in range(16) and \
                isinstance(north,int) and north in range(16):
                # Set attenuation
                self._atten.write(self._db2gpio(east,north))
            else:
                raise ValueError('Invalid parameter.')
        except Exception:
            self._warning('Failed to write I2C attenuator')

    def shunt(self, name='i'):
        """ Get current/voltage of the power supply

            Example:
            shunt(name='i')     # returns current in Amps
            shunt(name='u')     # returns voltage in Volt
        """
        if not hasattr(self, "_cur"):
            try:
                # Current sensor
                self._cur=i2c_volt.INA219(self.i2c,self.ADDR_INA)
                self._cur.init()
            except:
                self._warning("Failed to initialize I2C current sensor")
                return None

        try:
            if name == 'i':
                vshunt = self._cur.readVolt('shunt')
                ishunt = vshunt * 1.0 / self.SHUNT_RESISTOR
                return ishunt if ishunt < 6 else None
            elif name == 'u':
                vbus = self._cur.readVolt('bus')
                return vbus if vbus < 32 else None
            else:
                raise ValueError('Invalid parameter.')
        except Exception:
            self._warning('Failed to read I2C PAM current sensor')
            del self._cur
            return None

    def id(self):
        """ Get the unique eight-byte serial number of the module
        """
        if not hasattr(self, "_id"):
            try:
                # ID chip
                self._sn=i2c_sn.DS28CM00(self.i2c, self.ADDR_SN)
            except:
                self._warning("Failed to initialize I2C ID chip")
                return None

        try:
            return self._sn.readSN()
        except Exception:
            self._warning('Failed to read I2C ID chip')
            return None

    def power(self, name='east'):
        """ Get power level of the East or North RF path

            Example:
            power(name='east')  # returns power level of east in dBm
            power(name='north') # returns power level of north in dBm
        """
        if not hasattr(self, "_pow"):
            try:
                # Power detector
                self._pow = i2c_volt.MAX11644(self.i2c, self.ADDR_VOLT)
                self._pow.init()
            except:
                self._warning("Failed to initialize I2C power sensor")
                return None
        LOSS = 9.8
        if name not in ['east','north']:
            raise ValueError('Invalid parameter.')

        try:
            if name == 'east':
                vp=self._pow.readVolt('AIN0')
            elif name == 'north':
                vp=self._pow.readVolt('AIN1')

            assert vp>=0 and vp<=3.3

            return self._dc2dbm(vp, self.RMS2DC_SLOPE, self.RMS2DC_INTERCEPT) + LOSS
        except Exception:
            self._warning('Failed to read I2C power sensor')
            del self._pow
            return None

    def rom(self, string=None):
        """ Read string from ROM or write String to ROM

            Example:
            rom()               # returns a string ended with a '\0'
            rom('hello')        # write 'hello\0' into ROM
        """
        if not hasattr(self, "_rom"):
            try:
                # ROM
                self._rom=i2c_eeprom.EEP24XX64(self.i2c, self.ADDR_ROM)
            except:
                self._warning("Failed to initialize I2C ROM")
                return None

        try:
            if string == None:
                return self._rom.readString()
            else:
                self._rom.writeString(string)
        except Exception:
            self._warning('Failed to operate I2C ROM')
            return None

    def _db2gpio(self, ae, an):
        assert ae in range(0,16)
        assert an in range(0,16)
        ae = 15 - ae
        an = 15 - an
        val_str = '{0:08b}'.format((ae << 4) + an)
        val = int(val_str,2)
        return val

    def _gpio2db(self, val):
        assert val in range(0,256)
        val_str = '{0:08b}'.format(val)
        ae = int(val_str[0:4],2)
        an = int(val_str[4:8],2)
        return 15-ae, 15-an

    def _dc2dbm(self, val, slope, intercept):
        assert val>=0 and val<=3.3, "Input value {} out range of 0-3.3V".format(val)
        res = val * slope + intercept
        return res

class Fem(Block):

    ADDR_ACCEL = 0X69
    ADDR_MAG = 0x0c
    ADDR_BAR = 0x77
    ADDR_VOLT = 0x4e
    ADDR_ROM = 0x52
    ADDR_TEMP = 0x40
    ADDR_INA = 0x45
    ADDR_GPIO = 0x20

    CLK_I2C_BUS = 10  # 10 kHz
    CLK_I2C_REF = 100 # reference clk at 100 MHz

    I2C_RETRY = 3

    SHUNT_RESISTOR = 0.1

    RMS2DC_SLOPE = 27.31294863
    RMS2DC_INTERCEPT = -55.15991678

    IMU_ORIENT = [[0,0,1],[0,1,0],[1,0,0]]
    SWMODE = {'load':0b001,'antenna':0b111,'noise':0b000}
    SWMODE_REV = {0b001:'load', 0b111:'antenna', 0b000:'noise',}

    def __init__(self, host, name, logger=None):
        """ Front End Module (FEM) digital control class

            Features:
            switch      Switch input source between antenna, noise and load
                        mode
            shunt       Voltage and current of the power supply
            rom         Memo
            id          Device ID
            imu         Attitude of FEM
            pressure    Air pressure inside FEM
            temperature Temperature inside FEM

        host    CasperFpga instance
        name    Select one of the three FEMs(/Antennas) under the control of
                a SNAP board. Recommended values are: 'i2c_ant1', 'i2c_ant2'
                or 'i2c_ant3'. Please refer to the f-engine model for correct
                value.
        """
        super(Fem, self).__init__(host, name, logger)
        self.i2c = i2c.I2C(host, name, retry=self.I2C_RETRY)

    def _warning(self, msg, *args, **kwargs):
        self.logger.log(I2CWARNING, self._prefix_log(msg), *args, **kwargs)

    def initialize(self):
        self.i2c.enable_core()
        # set i2c bus to 10 kHz
        self.i2c.setClock(self.CLK_I2C_BUS, self.CLK_I2C_REF)


    def pressure(self):
        """ Get air pressure

            Example:
            pressure()      # return pressure in kPa
        """
        if not hasattr(self, "_bar"):
            try:
                # Barometer
                self._bar = i2c_bar.MS5611_01B(self.i2c, self.ADDR_BAR)
                self._bar.init()
            except:
                self._warning("Failed to initialize I2C barometer")
                return None

        try:
            rawt,dt = self._bar.readTemp(raw=True)
            press = self._bar.readPress(rawt,dt)
            return press
        except Exception:
            self._warning('Failed to read I2C barometer')
            del self._bar
            return None

    def shunt(self, name='i'):
        """ Get current/voltage of the power supply

            Example:
            shunt(name='i')     # returns current in Amps
            shunt(name='u')     # returns voltage in Volt
        """
        if not hasattr(self, "_cur"):
            try:
                # Current sensor
                self._cur=i2c_volt.INA219(self.i2c,self.ADDR_INA)
                self._cur.init()
            except:
                self._warning("Failed to initialize I2C FEM current sensor")
                return None

        try:
            if name == 'i':
                vshunt = self._cur.readVolt('shunt')
                ishunt = vshunt * 1.0 / self.SHUNT_RESISTOR
                return ishunt
            elif name == 'u':
                vbus = self._cur.readVolt('bus')
                return vbus
            else:
                raise ValueError('Invalid parameter.')
        except Exception:
            self._warning('Failed to read I2C FEM current sensor')
            del self._cur
            return None

    def id(self):
        """ Get the unique eight-byte serial number of the module
        """
        if not hasattr(self, "_temp"):
            try:
                # Temperature
                self._temp = i2c_temp.Si7051(self.i2c, self.ADDR_TEMP)
            except:
                self._warning("Failed to initialize I2C temperature sensor")
                return None

        try:
            return self._temp.sn()
        except Exception:
            self._warning('Failed to read ID from I2C temperature sensor')

    def imu(self):
        """ Get pose of the FEM in the form of theta and phi
            of spherical coordinate system in degrees
        """
        if not hasattr(self, "_imu"):
            try:
                # IMU
                self._imu = i2c_motion.IMUSimple(self.i2c,self.ADDR_ACCEL,
                                                orient=self.IMU_ORIENT)
                self._imu.init()
            except:
                self._warning("Failed to initialize I2C IMU")
                return None, None

        try:
            theta, phi = self._imu.pose
            return theta, phi
        except Exception:
            self._warning('Failed to read I2C IMU')
            del self._imu
            return None,None

    def rom(self, string=None):
        """ Read string from ROM or write String to ROM

            Example:
            rom()               # returns a string ended with a '\0'
            rom('hello')        # write 'hello\0' into ROM
        """
        if not hasattr(self, "_rom"):
            try:
                # ROM
                self._rom=i2c_eeprom.EEP24XX64(self.i2c,self.ADDR_ROM)
            except:
                self._warning("Failed to initialize FEM I2C ROM")
                return None

        try:
            if string == None:
                return self.rom.readString()
            else:
                self.rom.writeString(string)
        except Exception:
            self._warning("Failed to operate FEM I2C ROM")
            return None


    def switch(self,name=None, **kwargs):
        """ Switch between antenna, noise and load mode

            Example:
            switch()                # Get mode&status in (mode, east, north)
                                    # eg, ('antenna', True, True)
                                    # if the switch is set to antenna and both LNAs are on.
            switch(mode='antenna')  # Switch into antenna mode
            switch(mode='noise')    # Switch into noise mode
            switch(mode='load')     # Switch into load mode
            switch(east=True)       # Switch on east pole
            switch(north=False)     # Switch off north pole
        """
        if not hasattr(self, "_sw"):
            try:
                # Switch
                self._sw = i2c_gpio.PCF8574(self.i2c,self.ADDR_GPIO)
            except:
                self._warning("Failed to initialize I2C RF switch")
                return None

        try:
            val = self._sw.read()
        except:
            self._warning("I2C RF switch read failure")
            return None

        if name == None and 'east' not in kwargs and 'north' not in kwargs:
            east  = bool(val & 0b00010000)
            north = bool(val & 0b00001000)
            mode  = self.SWMODE_REV.get(val & 0b00000111, 'Unknown mode')
            return mode, east, north
            
        if name in self.SWMODE:
            self._sw.write((val & 0b11111000) | self.SWMODE[name])
        elif name != None:
            raise ValueError('Invalid parameter.')

        if 'east' in kwargs:
            if kwargs['east'] == True:
                self._sw.write(val | 0b00010000)
            elif kwargs['east'] == False:
                self._sw.write(val & 0b11101111)
            else:
                raise ValueError('Invalid parameter.')

        if 'north' in kwargs:
            if kwargs['north'] == True:
                self._sw.write(val | 0b00001000)
            elif kwargs['north'] == False:
                self._sw.write(val & 0b11110111)
            else:
                raise ValueError('Invalid parameter.')

    def humidity(self):
        """ Get relative humidity in percentage
        """
        if not hasattr(self, "_rh"):
            try:
                # Relative Humidity
                self._rh = i2c_temp.Si7021(self.i2c, self.ADDR_TEMP)
            except:
                self._info("Failed to initialize I2C humidity sensor")
                return None

        if self._rh.model() != 'Si7021':
            self._info("There is no humidity sensor in this FEM")

        return self._rh.readTempRH()[1]

    def temperature(self):
        """ Get temperature in Celcius
        """
        if not hasattr(self, "_temp"):
            try:
                # Temperature
                self._temp = i2c_temp.Si7051(self.i2c, self.ADDR_TEMP)
            except:
                self._info("Failed to initialize I2C temperature sensor")
                return None
        try:
            return self._temp.readTemp()
        except Exception:
            self._warning("Failed to read I2C temperature sensor")
            return None
