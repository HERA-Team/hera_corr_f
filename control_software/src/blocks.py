from __future__ import print_function
import logging
import numpy as np
import struct
import socket
import time
import random
import casperfpga
import casperfpga.snapadc
from hera_corr_cm.handlers import add_default_log_handlers
from casperfpga import i2c
from casperfpga import i2c_gpio
from casperfpga import i2c_volt
from casperfpga import i2c_eeprom
from casperfpga import i2c_sn
from casperfpga import i2c_bar
from casperfpga import i2c_motion
from casperfpga import i2c_temp
from scipy.linalg import hadamard  # for walsh (hadamard) matrices

# There are so many I2C warnings that a new level is defined
# to filter them out
I2CWARNING = logging.INFO - 5
logging.addLevelName('I2CWARNING', I2CWARNING)

HIST_BINS = np.arange(-128, 128) # for histogram of ADC inputs
ERROR_VALUE = -1 # default value for status reports if comms are broken
ERROR_STRING = 'UNKNOWN' # default string for status reports if comms are broken

# Block Classes
class Block(object):
    def __init__(self, host, name, logger=None):
        self.host = host  # casperfpga object
        # One logger per host. Multiple blocks share the same logger.
        # Multiple hosts should *not* share the same logger, since we can multithread over hosts.
        self.logger = logger or add_default_log_handlers(logging.getLogger(__name__ + ":%s" % (host.host)))
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

    def initialize(self, verify=False):
        """
        Individual blocks should override this
        method to configure themselves appropriately
        """
        pass

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

    def set_reg_bits(self, reg, val, start, width=1):
        orig_val = self.read_uint(reg)
        masked = orig_val & (0xffffffff - ((2**width - 1) << start))
        new_val = masked + (val << start)
        self.write_uint(reg, new_val)

    def get_reg_bits(self, reg, start, width=1):
        val = self.read_uint(reg)
        val = val >> start
        val &= (2**width - 1)
        return val


class Synth(casperfpga.synth.LMX2581):
    def __init__(self, host, name, fosc=10, logger=None):
        self.logger = logger or add_default_log_handlers(logging.getLogger(__name__ + "%s" % (host.host)))
        super(Synth, self).__init__(host, name, fosc=fosc)
        self.host = host

    def initialize(self, verify=False):
        """
        Seem to have to do this if reference
        was not present when board was powered up(?)
        """
        #Ed. This seems to break things?
        #self.powerOff()
        #self.powerOn()
        pass

    def getFreq(self):
        """
        Infer the output sample clock from the configuration of
        the LMX registers.
        """
        VCO_DIV = self.getWord('VCO_DIV')
        VCO_DIV = 2 * (VCO_DIV + 1)
        PLL_NUM_H = self.getWord('PLL_NUM_H')
        PLL_NUM_L = self.getWord('PLL_NUM_L')
        PLL_N = self.getWord('PLL_N')
        PLL_DEN = self.getWord('PLL_DEN')
        PLL_NUM = (PLL_NUM_H & 0b1111111111) << 12
        PLL_NUM += PLL_NUM_L & 0b111111111111
        return self.FOSC * (PLL_N + PLL_NUM / PLL_DEN) / VCO_DIV

class Adc(casperfpga.snapadc.SNAPADC):
    def __init__(self, host, num_chans=2, resolution=8, ref=10,
                 logger=None, **kwargs):
        """
        Instantiate an ADC block.

        Inputs:
           host (casperfpga.Casperfpga): Host FPGA
           num_chans (int): Number of channels per ADC chip. Valid values are 1, 2, or 4.
           resolution (int): Bit resolution of the ADC. Valid values are 8, 12.
           ref (float): Reference frequency (in MHz) from which ADC clock is derived. If None, an external sampling clock must be used.
        """
        self.logger = logger or add_default_log_handlers(
                      logging.getLogger(__name__ + ":%s" % (host.host)))
        # Purposely setting ref=None below to prevent LMX object
        # from being attached so we can do it ourselves
        casperfpga.snapadc.SNAPADC.__init__(self, host, ref=None,
                                            logger=self.logger)
        # Attach our own wrapping of LMX
        self.lmx = Synth(host, 'lmx_ctrl', fosc=ref)
        self.name            = 'SNAP_adc'
        self.num_chans       = num_chans
        self.interleave_mode = 4 >> num_chans
        self.clock_divide    = 1
        self.resolution      = resolution
        self.host = host # the SNAPADC class doesn't directly expose this
        self.working_taps = {}
        self._retry_cnt = 0
        #self._retry = kwargs.get('retry',7)
        self._retry = kwargs.get('retry',20)
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

    # OVERWRITING casperfpga.snapadc.SNAPADC.init
    def init(self, sample_rate=500., verify=False):
        """
        Get SNAP ADCs into working condition

        Supported frequency range: 60MHz ~ 1000MHz. Set resolution to
        None to let init() automatically decide the best resolution.

        1. configuring frequency synthesizer LMX2581
        2. configuring clock source switch HMC922
        3. configuring ADCs HMCAD1511 (support HMCAD1520 in future)
        4. configuring IDELAYE2 and ISERDESE2 inside of FPGA

        Inputs:
           sample_rate (float): Sample rate in MS/s. Default: 500.
        """

        # XXX verify currently not implemented
        numChannel = self.num_chans
        if self.lmx is not None:
            self.logger.debug("Reseting frequency synthesizer")
            self.lmx.init()
            self.logger.debug("Disabling Synth output A")
            self.lmx.setWord(1, "OUTA_PD")
            self.logger.debug("Configuring frequency synthesizer")
            assert(self.lmx.setFreq(sample_rate)) # Error if failed

        self.logger.debug("Configuring clock source switch")
        if self.lmx is not None:
            self.clksw.setSwitch('a')
        else:
            self.clksw.setSwitch('b')

        self.logger.debug("Reseting adc_unit")
        self.reset()
        self.selectADC()
        self.logger.debug("Initialising ADCs")
        self.adc.init() # resets: don't set ADC registers before here

        # SNAP only uses one of the 3 ADC chips to provide clocks,
        # set others to lowest drive strength possible and terminate them
        self.selectADC([1,2]) # Talk to the 2nd and 3rd ADCs
        # Please refer to HMCAD1511 datasheet for more details
        # LCLK Termination
        rid, mask = self.adc._getMask('en_lvds_term')
        val = self.adc._set(0x0, 0b1, mask)          # Enable termination.
        rid, mask = self.adc._getMask('term_lclk')
        val = self.adc._set(val, 0b011, mask)        # 94 ohm
        # Frame CLK termination
        rid, mask = self.adc._getMask('term_frame')
        val = self.adc._set(val, 0b011, mask)        # 94 ohm
        self.adc.write(val, rid)
        # LCLK Drive Strength
        rid, mask = self.adc._getMask('ilvds_lclk')
        val = self.adc._set(0x0, 0b011, mask) # 0.5 mA (default)
        # Frame CLK Drive Strength
        rid, mask = self.adc._getMask('ilvds_frame')
        val = self.adc._set(val, 0b011, mask)        # 0.5 mA
        self.adc.write(val, rid)
        # Select all ADCs and continue initialization
        self.selectADC()

        if numChannel==1 and sample_rate<240:
            lowClkFreq = True
        elif numChannel==2 and sample_rate<120:
            lowClkFreq = True
        elif numChannel==4 and sample_rate<60:
            lowClkFreq = True
        # XXX this case already covered above
        #elif numChannel==4 and self.RESOLUTION==14 and sample_rate<30:
        #    lowClkFreq = True
        else:
            lowClkFreq = False

        self.logger.debug("Configuring ADC operating mode")
        if type(self.adc) is casperfpga.snapadc.HMCAD1511:
            self.adc.setOperatingMode(numChannel, 1, lowClkFreq)
        elif type(self.adc) is casperfpga.snapadc.HMCAD1520:
            self.adc.setOperatingMode(numChannel, 1, lowClkFreq,
                                      self.RESOLUTION)

        # ADC init/lmx select messes with FPGA clock, so reprogram
        self.logger.debug('Reprogramming the FPGA for ADCs')
        self.interface.transport.prog_user_image()
        self.selectADC()
        self.logger.debug('Reprogrammed')

        # Select the clock source switch again. The reprogramming
        # seems to lose this information
        self.logger.debug('Configuring clock source switch')
        if self.lmx is not None:
            self.clksw.setSwitch('a')
        else:
            self.clksw.setSwitch('b')

        # Snipped off ADC calibration here; it's now in
        # snap_fengine.
        self._retry_cnt = 0
        self.working_taps = {} # initializing invalidates cached values
        return

    def bitslip(self, chipSel=None, laneSel=None, verify=False):
        if chipSel == None:
            chipSel = self.adcList
        elif chipSel in self.adcList:
            chipSel = [chipSel]

        if not isinstance(chipSel,list):
            raise ValueError("Invalid parameter")
        elif isinstance(chipSel,list) and any(cs not in self.adcList for cs in chipSel):
            raise ValueError("Invalid parameter")
        if laneSel == None:
            laneSel = self.laneList
        elif laneSel in self.laneList:
            laneSel = [laneSel]

        if not isinstance(laneSel,list):
            raise ValueError("Invalid parameter")
        elif isinstance(laneSel,list) and any(cs not in self.laneList for cs in laneSel):
            raise ValueError("Invalid parameter")

        self.logger.debug('Bitslip lane {0} of chip {1}'.format(str(laneSel),str(chipSel)))

        for cs in chipSel:
            for ls in laneSel:
                val = self._set(0x0, 0b1 << cs, self.M_WB_W_ISERDES_BITSLIP_CHIP_SEL)
                val = self._set(val, ls, self.M_WB_W_ISERDES_BITSLIP_LANE_SEL)

                # The registers related to reset, request, bitslip, and other
                # commands after being set will not be automatically cleared.
                # Therefore we have to clear them by ourselves.
                self.adc._write(0x0, self.A_WB_W_CTRL)
                if verify:
                    assert(self.adc._read(self.A_WB_W_CTRL) & self.M_WB_W_DELAY_TAP == 0x00)
                self.adc._write(val, self.A_WB_W_CTRL)
                if verify:
                    rv = self.adc._read(self.A_WB_W_CTRL)
                    assert(rv & self.M_WB_W_ISERDES_BITSLIP_CHIP_SEL == val & self.M_WB_W_ISERDES_BITSLIP_CHIP_SEL)
                    assert(rv & self.M_WB_W_ISERDES_BITSLIP_LANE_SEL == val & self.M_WB_W_ISERDES_BITSLIP_LANE_SEL)
                self.adc._write(0x0, self.A_WB_W_CTRL)
                if verify:
                    assert(self.adc._read(self.A_WB_W_CTRL) & self.M_WB_W_DELAY_TAP == 0x00)


    # The ADC16 controller word (the offset in write_int method) 2 and 3 are for delaying
    # taps of A and B lanes, respectively.
    #
    # Refer to the memory map word 2 and word 3 for clarification.  The memory map was made
    # for a ROACH design so it has chips A-H.  SNAP 1 design has three chips.
    def delay(self, tap, chipSel=None, laneSel=None, verify=False):
        if chipSel==None:
            chipSel = self.adcList
        elif chipSel in self.adcList:
            chipSel = [chipSel]
        elif isinstance(chipSel, list) and any(s not in self.adcList for s in chipSel):
            raise ValueError("Invalid parameter")

        if laneSel==None:
            laneSel = self.laneList
        elif laneSel in self.laneList:
            laneSel = [laneSel]
        elif isinstance(laneSel,list) and any(s not in self.laneList for s in laneSel):
            raise ValueError("Invalid parameter")
        elif laneSel not in self.laneList:
            raise ValueError("Invalid parameter")

        if not isinstance(tap, int):
            raise ValueError("Invalid parameter")

        strl = ','.join([str(c) for c in laneSel])
        strc = ','.join([str(c) for c in chipSel])
        self.logger.debug('Set DelayTap of lane {0} of chip {1} to {2}'
                .format(str(laneSel),str(chipSel),tap))

        matc = np.array([(cs*4) for cs in chipSel])

        matla = np.array([int(l/2) for l in laneSel if l%2==0])
        if matla.size:
            mata =  np.repeat(matc.reshape(-1,1),matla.size,1) + \
                np.repeat(matla.reshape(1,-1),matc.size,0)
            vala = np.bitwise_or.reduce([0b1 << s for s in mata.flat])
        else:
            vala = 0

        matlb = np.array([int(l/2) for l in laneSel if l%2==1])
        if matlb.size:
            matb =  np.repeat(matc.reshape(-1,1),matlb.size,1) + \
                np.repeat(matlb.reshape(1,-1),matc.size,0)
            valb = np.bitwise_or.reduce([0b1 << s for s in matb.flat])
        else:
            valb = 0

        valt = self._set(0x0, tap, self.M_WB_W_DELAY_TAP)

        # Don't be misled by the naming - "DELAY_STROBE" in casper repo.  It doesn't
        # generate strobe at all.  You have to manually clear the bits that you set.
        self.adc._write(0x00, self.A_WB_W_CTRL)
        self.adc._write(0x00, self.A_WB_W_DELAY_STROBE_L)
        self.adc._write(0x00, self.A_WB_W_DELAY_STROBE_H)
        if verify:
            assert(self.adc._read(self.A_WB_W_CTRL) & self.M_WB_W_DELAY_TAP == 0x00)
            assert(self.adc._read(self.A_WB_W_DELAY_STROBE_L) == 0x00)
            assert(self.adc._read(self.A_WB_W_DELAY_STROBE_H) == 0x00)
        self.adc._write(valt, self.A_WB_W_CTRL)
        self.adc._write(vala, self.A_WB_W_DELAY_STROBE_L)
        self.adc._write(valb, self.A_WB_W_DELAY_STROBE_H)
        if verify:
            assert(self.adc._read(self.A_WB_W_CTRL) & self.M_WB_W_DELAY_TAP == valt)
            assert(self.adc._read(self.A_WB_W_DELAY_STROBE_L) == vala)
            assert(self.adc._read(self.A_WB_W_DELAY_STROBE_H) == valb)
        self.adc._write(0x00, self.A_WB_W_CTRL)
        self.adc._write(0x00, self.A_WB_W_DELAY_STROBE_L)
        self.adc._write(0x00, self.A_WB_W_DELAY_STROBE_H)
        if verify:
            assert(self.adc._read(self.A_WB_W_CTRL) & self.M_WB_W_DELAY_TAP == 0x00)
            assert(self.adc._read(self.A_WB_W_DELAY_STROBE_L) == 0x00)
            assert(self.adc._read(self.A_WB_W_DELAY_STROBE_H) == 0x00)

        for cs in chipSel:
            for ls in laneSel:
                self.curDelay[cs,ls] = tap

    def _find_working_taps(self, ker_size=5, maxtries=5):
        '''Generate a dictionary of working tap values per chip/lane.
        ker: size of convolutional kernel used as a stand-off from
             marginal tap values. Default 7.'''
        nchips, nlanes, ntaps = len(self.adcList), len(self.laneList), 32
        # Make sure we have enough taps to work with, otherwise reinit ADC
        for cnt in range(maxtries):
            try:
                for chip in self.adcList:
                    assert(self.working_taps[chip].size > 0)
                return
            except(KeyError, AssertionError):
                self.logger.info('Not enough working taps. Reinitializing.')
                if len(self.working_taps) > 0:
                    self.init()
                self.working_taps = {}
                h = np.zeros((nchips, ntaps), dtype=int)
                self.setDemux(numChannel=1)
                self.selectADC() # select all chips
                self.adc.test('pat_deskew')
                for t in range(ntaps):
                    for L in self.laneList:
                        for chip in self.adcList:
                            self.delay(t, chip, L)
                    self.snapshot()
                    for chip,d in self.readRAM(signed=False).items():
                        h[chip,t] = (np.sum(d == d[:1], axis=(0,1)) == d.shape[0] * d.shape[1])
                self.selectADC() # select all chips
                self.adc.test('off')
                self.setDemux(numChannel=self.num_chans)
                ker = np.ones(ker_size)
                for chip in self.adcList:
                    # identify taps that work for all lanes of chip
                    taps = np.where(np.convolve(h[chip], ker, 'same') == ker_size)[0]
                    self.working_taps[chip] = taps
        raise RuntimeError('Failed to find working taps.')

    def alignLineClock(self, chips_lanes=None, ker_size=5):
        """Find a tap for the line clock that produces reliable bit
        capture from ADC."""
        if chips_lanes is None:
            chips_lanes = {chip:self.laneList for chip in self.adcList}
        self.logger.info('Aligning line clock on ADCs/lanes: %s' % \
                          str(chips_lanes))
        try:
            self._find_working_taps(ker_size=ker_size)
        except(RuntimeError):
            self.logger.info('Failed to find working taps.')
            return chips_lanes # total failure
        self.setDemux(numChannel=1)
        for chip, lanes in chips_lanes.items():
            self.selectADC(chip)
            taps = self.working_taps[chip]
            tap = random.choice(taps)
            for L in self.laneList: # redo all lanes to be the same
                self.delay(tap, chip, L)
            # Remove from future consideration if tap doesn't work out
            self.working_taps[chip] = taps[np.abs(taps - tap) >= ker_size//2]
            self.logger.info('Setting ADC=%d tap=%s' % (chip, tap))
        self.setDemux(numChannel=self.num_chans)
        return {} # success

    def alignFrameClock(self, chips_lanes=None, retry=True):
        """Align frame clock with data frame."""
        if chips_lanes is None:
            chips_lanes = {chip:self.laneList for chip in self.adcList}
        self.logger.debug('Aligning frame clock on ADCs/lanes: %s' % \
                          str(chips_lanes))
        failed_chips = {}
        self.setDemux(numChannel=1)
        for chip, lanes in chips_lanes.items():
            self.selectADC(chip)
            self.adc.test('dual_custom_pat', self.p1, self.p2)
            ans1 = self._signed(self.p1, self.RESOLUTION)
            ans2 = self._signed(self.p2, self.RESOLUTION)
            failed_lanes = []
            for cnt in range(2 * self.RESOLUTION):
                slipped = False
                self.snapshot() # make bitslip "take" (?!) XXX
                d = self.readRAM(chip).reshape(-1, self.RESOLUTION)
                # sanity check: these failures mean line clock errors
                failed_lanes += [L for L in lanes
                        if np.any(d[0::2,L] != d[0,L]) or \
                           np.any(d[1::2,L] != d[1,L])]
                lanes = [L for L in lanes if L not in failed_lanes]
                for lane in lanes:
                    if not d[0,lane] in [ans1, ans2]:
                        self.bitslip(chip, lane)
                        slipped = True
                if not slipped:
                    break
            self.adc.test('off')
            if len(failed_lanes) > 0:
                failed_chips[chip] = failed_lanes
        self.setDemux(numChannel=self.num_chans)
        if len(failed_chips) > 0 and retry:
            if self._retry_cnt < self._retry:
                self._retry_cnt += 1
                self.logger.info('retry=%d/%d redo Line on ADCs/lanes: %s' % \
                            (self._retry_cnt, self._retry, failed_chips))
                self.alignLineClock(failed_chips)
                return self.alignFrameClock(failed_chips)
        return failed_chips

    def rampTest(self, nchecks=300, retry=False):
        chips = self.adcList
        self.logger.debug('Ramp test on ADCs: %s' % str(chips))
        failed_chips = {}
        self.setDemux(numChannel=1)
        predicted = np.arange(128).reshape(-1,1)
        self.selectADC() # select all chips
        self.adc.test("en_ramp")
        for cnt in range(nchecks):
            self.snapshot()
            for chip,d in self.readRAM(signed=False).items():
            	ans = (predicted + d[0,0]) % 256
                failed_lanes = np.sum(d != ans, axis=0)
                if np.any(failed_lanes) > 0:
                    failed_chips[chip] = np.where(failed_lanes)[0]
            if (retry is False) and len(failed_chips) > 0:
                # can bail out if we aren't retrying b/c we don't need list of failures.
                break
        self.selectADC() # select all chips
        self.adc.test('off')
        self.setDemux(numChannel=self.num_chans)
        if len(failed_chips) > 0 and retry:
            if self._retry_cnt < self._retry:
                self._retry_cnt += 1
                self.logger.info('retry=%d/%d redo Line/Frame on ADCs/lanes: %s' % \
                            (self._retry_cnt, self._retry, failed_chips))
                self.alignLineClock(failed_chips)
                self.alignFrameClock(failed_chips)
                return self.rampTest(nchecks=nchecks, retry=retry)
        return failed_chips


class Sync(Block):
    def __init__(self, host, name, logger=None):
        super(Sync, self).__init__(host, name, logger)
        self.OFFSET_ARM_SYNC = 0
        self.OFFSET_ARM_NOISE = 1
        self.OFFSET_SW_SYNC = 4

    def uptime(self):
        """
        Returns uptime in seconds, assumes 250 MHz FPGA clock
        """
        try:
            return self.read_uint('uptime')
        except RuntimeError:
            return ERROR_VALUE

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

    def change_period(self, period):
        """
        Change the period of the sync pulse
        """
        #self.host.write_int('timebase_sync_period', period)
        self._info("Changed sync period to %.2f" % period)

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
        # XXX will be changed soon; sync with JK
        self.set_reg_bits('arm', 0, self.OFFSET_ARM_SYNC)
        self.set_reg_bits('arm', 1, self.OFFSET_ARM_SYNC)
        self.set_reg_bits('arm', 0, self.OFFSET_ARM_SYNC)

    def arm_noise(self):
        """
        Arm noise generator resets
        """
        # XXX will be changed soon; sync with JK
        self.set_reg_bits('arm', 0, self.OFFSET_ARM_NOISE)
        self.set_reg_bits('arm', 1, self.OFFSET_ARM_NOISE)
        self.set_reg_bits('arm', 0, self.OFFSET_ARM_NOISE)

    def sw_sync(self):
        """
        Issue a software sync pulse
        """
        # XXX will be changed soon; sync with JK
        self.set_reg_bits('arm', 0, self.OFFSET_SW_SYNC)
        self.set_reg_bits('arm', 1, self.OFFSET_SW_SYNC)
        self.set_reg_bits('arm', 0, self.OFFSET_SW_SYNC)

    def initialize(self, verify=False):
        """
        Initialize this block. Set sync period to 0.
        """
        self.write_int('arm', 0)
        #self.change_period(2**16 * 9*7*6*5*3)
        self.change_period(0)
        if verify:
            assert(self.read_int('arm') == 0)

class NoiseGen(Block):
    def __init__(self, host, name, nstreams=6, logger=None):
        super(NoiseGen, self).__init__(host, name, logger)
        self.nstreams = nstreams

    def set_seed(self, stream=None, seed=0, verify=True):
        """
        Set the seed of the noise generator for a given stream. Six 8-b
        seeds are stored in two 32-b registers from LSB to MSB. Of these,
        only seeds 0, 2, and 4 are used, going to the 3 LFSRs that serve
        inputs 0-1, 2-3, and 4-5 respectively.

        Inputs:
            stream (int): Which stream to switch. If None, switch all.
            seed (int): int 0-255 for seeding digital noise generator.
        """
        if stream is None:
            for stm in range(self.nstreams):
                self.set_seed(stream=stm, seed=seed, verify=verify)
        else:
            assert stream < self.nstreams
            assert seed < 256
            regname = 'seed_%d' % (stream // 4)
            self.set_reg_bits(regname, seed, 8 * (stream % 4), 8)
            if verify:
                assert seed == self.get_seed(stream)

    def get_seed(self, stream=None):
        """
        Get the seed of the noise generator for a given stream.

        Inputs:
            stream (int): Which stream to switch. If None, switch all.
        """
        if stream is None:
            return [self.get_seed(stm) for stm in range(self.nstreams)]
        assert stream <= self.nstreams
        regname = 'seed_%d' % (stream // 4)
        return (self.read_uint(regname) >> (8 * (stream % 4))) & 0xff

    def initialize(self, verify=False):
        self.set_seed(verify=verify)


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

    def get_status(self):
        '''Return dict of current status.'''
        rv = {}
        snapshots = {}
        for stream in range(self.ninput_mux_streams//2): # bram holds stream and stream+1
            snapshots[2*stream], snapshots[2*stream+1] = self.get_adc_snapshot(stream)
        for stream,snapshot in snapshots.items():
            rv['stream%d_hist' % stream] = np.histogram(snapshot, bins=HIST_BINS)[0]
            rv['stream%d_mean' % stream] = np.mean(snapshot)
            pwr = np.mean(np.abs(snapshot)**2)
            rv['stream%d_power' % stream] = pwr
            rv['stream%d_rms' % stream] = np.sqrt(pwr)
        return rv

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

    def _select_input(self, input_code, stream=None, verify=False):
        if stream is None:
            streams = list(range(self.ninput_mux_streams))
        else:
            streams = [stream]
        for stream in streams:
            self.set_reg_bits('source_sel', input_code, 2*(self.ninput_mux_streams-1-stream), 2)
            if verify:
                assert(self.get_reg_bits('source_sel', 2*(self.ninput_mux_streams-1-stream), 2) == input_code)

    def use_noise(self, stream=None, verify=False):
        """
        Switch input to internal noise source.
        Inputs:
            stream (int): Which stream to switch. If None, switch all.
        """
        self._select_input(self.USE_NOISE, stream=stream, verify=verify)

    def use_adc(self, stream=None, verify=False):
        """
        Switch input to ADC.
        Inputs:
            stream (int): Which stream to switch. If None, switch all.
        """
        self._select_input(self.USE_ADC, stream=stream, verify=verify)

    def use_zero(self, stream=None, verify=False):
        """
        Switch input to zeros.
        Inputs:
            stream (int): Which stream to switch. If None, switch all.
        """
        self._select_input(self.USE_ZERO, stream=stream, verify=verify)

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

    def initialize(self, verify=False):
        """
        Switch to ADCs. Begin computing stats.
         """
        self.use_adc(verify=verify)

        #rms code removed from current version of fpga software
        #self.write_int('rms_enable', 1)

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

    def set_delay(self, stream, delay, verify=False):
        """
        Insert a delay to a given input stream.

        Inputs:
            stream (int): Which antpol to delay.
            delay (int): Number of FPGA clock cycles of delay to insert.
        """
        if stream > self.nstreams:
            self._error('Tried to set delay for stream %d > nstreams (%d)' % (stream, self.nstreams))
        # MSBs of 232-bit register are for stream 0, etc...
        self.set_reg_bits('delays', delay, 32-4-(4*stream), 4)
        if verify:
            assert(self.get_reg_bits('delays', 32-4-(4*stream), 4) == delay)

    def initialize(self, verify=False):
        """
        Initialize all delays to 0.
        """
        for stream in range(self.nstreams):
            self.set_delay(stream, 0, verify=verify)

class Pfb(Block):
    def __init__(self, host, name, logger=None):
        super(Pfb, self).__init__(host, name, logger)
        self.SHIFT_OFFSET = 0
        self.SHIFT_WIDTH  = 16
        self.PRESHIFT_OFFSET = 16
        self.PRESHIFT_WIDTH  = 2
        self.STAT_RST_BIT = 18

    def get_fft_shift(self):
        """
        Return the current FFT shift schedule (LSB = stage 1, MSB = stage N).
        """
        return self.get_reg_bits('ctrl', self.SHIFT_OFFSET, self.SHIFT_WIDTH)

    def set_fft_shift(self, shift, verify=False):
        """
        Set the FFT shift schedule to the specified unsigned integer
        (LSB = stage 1, MSB = stage N).
        """
        self.set_reg_bits('ctrl', shift, self.SHIFT_OFFSET, self.SHIFT_WIDTH)
        if verify:
            assert(shift == self.get_fft_shift())

    def get_fft_preshift(self):
        """
        Return the current FFT preshift value.
        """
        return self.get_reg_bits('ctrl', self.PRESHIFT_OFFSET, self.PRESHIFT_WIDTH)

    def set_fft_preshift(self, shift, verify=False):
        self.set_reg_bits('ctrl', shift, self.PRESHIFT_OFFSET, self.PRESHIFT_WIDTH)
        if verify:
            assert(shift == self.get_fft_preshift())

    def rst_stats(self):
        self.set_reg_bits('ctrl', 1, self.STAT_RST_BIT)
        self.set_reg_bits('ctrl', 0, self.STAT_RST_BIT)

    def is_overflowing(self):
        return self.read_uint('status') != 0

    def initialize(self, fft_shift=0b110101010101, verify=False):
        self.write_int('ctrl', 0)
        self.set_fft_shift(fft_shift, verify=verify)
        self.rst_stats()

class PhaseSwitch(Block):
    def __init__(self, host, name, nstreams=6, depth=2**12, periodbase=2**18, logger=None):
        super(PhaseSwitch, self).__init__(host, name, logger)
        self.nstreams = nstreams
        self.depth = depth           # number of brams steps in a period
        self.periodbase = periodbase # number of clock cycles in one bram step

    def set_walsh(self, stream, N, n, stepperiod, verify=False):
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
        new_bram_vec = struct.pack('>%dB' % self.depth, *new_bram_vec)
        self.write('gpio_switch_states', new_bram_vec)
        self.write('sw_switch_states', new_bram_vec)
        if verify:
            assert(self.read('gpio_switch_states', len(new_bram_vec)) == new_bram_vec)
            assert(self.read('sw_switch_states', len(new_bram_vec)) == new_bram_vec)

    def set_all_walsh(self, N, n, stepperiod, verify=False):
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
        gpio_str = struct.pack('>%dB' % self.depth, *bram_array)
        self.write('gpio_switch_states', gpio_str)
        self.write('sw_switch_states', gpio_str)
        if verify:
            assert(gpio_str == self.read('gpio_switch_states',
                                         len(gpio_str)))
            assert(gpio_str == self.read('sw_switch_states',
                                         len(gpio_str)))

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

    def set_delay(self, delay, verify=False):
        """
        set the delay (in FPGA clock cycles) between
        the modulation and demodulation patterns
        (to take into account cable latency)
        """
        self.write_int('gpio_switch_offset', delay)
        if verify:
            assert(delay == self.read_int('gpio_switch_offset'))

    def enable_mod(self, verify=False):
        """
        Turn on the modulation patterns
        """
        self.write_int('enable_mod', 1)
        if verify:
            assert(1 == self.read_int('enable_mod'))

    def disable_mod(self, verify=False):
        """
        Turn off the modulation patterns
        """
        self.write_int('enable_mod', 0)
        if verify:
            assert(0 == self.read_int('enable_mod'))

    def enable_demod(self, verify=False):
        """
        Turn on the demodulation patterns
        """
        self.write_int('enable_demod', 1)
        if verify:
            assert(1 == self.read_int('enable_demod'))

    def disable_demod(self, verify=False):
        """
        Turn off the demodulation patterns
        """
        self.write_int('enable_demod', 0)
        if verify:
            assert(0 == self.read_int('enable_demod'))

    def initialize(self, verify=False):
        """
        Initialize, turning off walshing
        """
        for stream in range(self.nstreams):
            self.set_walsh(stream, 1, 0, 1, verify=verify)
        self.disable_mod(verify=verify)
        self.disable_demod(verify=verify)
        self.set_delay(0, verify=verify)


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
        self.bin_point = 5
        self.format = 'H'  # 'L'
        self.streamsize = struct.calcsize(self.format)*self.ncoeffs

    def set_coeffs(self, stream, coeffs, verify=False):
        """
        Set coefficients for a data stream.

        Inputs
           stream (int): stream to manipulate
           coeffs (float/int iterable): coefficients to load
        """
        # convert to fixed-point integer
        coeffs = np.around(coeffs * 2**self.bin_point).astype(np.int64)
        # ensure all coefficients in range
        assert(np.all(coeffs <= 2**self.width - 1))
        assert(np.all(coeffs >= 0))
        assert(coeffs.size == self.ncoeffs)
        coeffs_str = struct.pack('>%d%s' % (self.ncoeffs, self.format),
                                 *coeffs)
        self._raw_write(stream, coeffs_str, verify=verify)

    def _raw_write(self, stream, data, verify=False):
        self.write('coeffs', data, offset=(self.streamsize * stream))
        if verify:
            assert(data == self._raw_read(stream))

    def _raw_read(self, stream):
        data = self.read('coeffs', self.streamsize,
                         offset=(self.streamsize * stream))
        return data

    def get_status(self, stream, include_coeffs=False):
        """
        Return the Eq status:  coeffs (per stream) and clip_count (for all)
        """
        if include_coeffs:
            return {'coeffs': self.get_coeffs(stream), 'clip_count': self.clip_count()}
        else:
            return {'clip_count': self.clip_count()}

    def get_coeffs(self, stream):
        """
        Read the coefficients being used from the board.
        Inputs:
            stream (int): Stream index to query
        Returns
            numpy array (float, length self.ncoeffs)
        """
        coeffs_str = self._raw_read(stream)
        coeffs = struct.unpack('>%d%s' % (self.ncoeffs, self.format),
                               coeffs_str)
        return np.array(coeffs, dtype=np.float) / (2.**self.bin_point)

    def clip_count(self):
        """
        Get the total number of times any samples have clipped, since last sync.
        """
        return self.read_uint('clip_cnt')

    def initialize(self, coeffs=100, verify=False):
        """
        Initialize block, setting coefficients to some nominally sane value.
        Currently, this is 100.0
        """
        for stream in range(self.nstreams):
            self.set_coeffs(stream,
                            coeffs * np.ones(self.ncoeffs, dtype='>%s' % self.format),
                            verify=verify)


class EqTvg(Block):
    def __init__(self, host, name, nstreams=8, nchans=2**13, logger=None):
        super(EqTvg, self).__init__(host, name, logger)
        self.nstreams = nstreams
        self.nchans = nchans
        self.format = 'B'

    def tvg_enable(self, verify=False):
        self.write_int('tvg_en', 1)
        if verify:
            assert(self.read_int('tvg_en') == 1)

    def tvg_disable(self, verify=False):
        self.write_int('tvg_en', 0)
        if verify:
            assert(self.read_int('tvg_en') == 0)

    def write_const_ants(self, equal_pols=False, verify=False):
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
            val = tv.tostring()[i*self.nchans*2:(i+1)*self.nchans*2]
            self.write('tv%d' % i, val)
            if verify:
                assert(self.read('tv%d' % i, len(val)) == val)

    def write_freq_ramp(self, equal_pols=False, verify=False):
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
            val = tv.tostring()[i*self.nchans*2:(i+1)*self.nchans*2]
            self.write('tv%d' % i, val)
            if verify:
                assert(self.read('tv%d' % i, len(val)) == val)

    def read_tvg(self):
        """ Read the test vector written to the sw bram """
        s = ""
        for i in range(self.nstreams // 2):
            s += self.read('tv%d' % i, self.nchans * 2)
        tvg = struct.unpack('>%d%s'%(self.nchans*self.nstreams, self.format), s)
        return tvg

    def initialize(self, verify=False):
        self.tvg_disable(verify=verify)
        self.write_freq_ramp(verify=verify)

class ChanReorder(Block):
    def __init__(self, host, name, nchans=2**10, logger=None):
        super(ChanReorder, self).__init__(host, name, logger)
        self.nchans = nchans
        self.format = 'L'

    def set_channel_order(self, order, verify=False):
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
        if verify:
            assert(self.read('reorder3_map1', len(order_str)) == order_str)

    def read_reorder(self, slot_num=None):
        reorder = self.read('reorder3_map1',1024*4)
        reorder = struct.unpack('>%d%s'%(self.nchans,self.format),reorder)
        if slot_num:
            return reorder[slot_num*64:(slot_num*64)+(384//8)]
        else:
            return reorder

    def reindex_channel(self, actual_index, output_index, verify=False):
        self.write_int('reorder3_map1', actual_index, word_offset=output_index)
        if verify:
            assert(actual_index == self.read_int('reorder3_map1',
                                                 word_offset=output_index))

    def initialize(self, verify=False):
        self.set_channel_order(np.arange(self.nchans), verify=verify)


class Packetizer(Block):
    def __init__(self, host, name, n_time_demux=2, logger=None):
        super(Packetizer, self).__init__(host, name, logger)
        self.n_time_demux = n_time_demux
        self.n_slots = 16

    def set_dest_ip(self, ip, slot_offset=0, verify=False):
        for time_slot in range(self.n_time_demux):
            off = time_slot * self.n_slots + slot_offset
            self.write_int('ips',ip[time_slot], word_offset=off)
            if verify:
                assert(ip[time_slot] == self.read_int('ips', word_offset=off))

    def set_ant_header(self, ant, slot_offset=0, verify=False):
        for time_slot in range(self.n_time_demux):
            off = time_slot * self.n_slots + slot_offset
            self.write_int('ants', ant, word_offset=off)
            if verify:
                assert(ant == self.read_int('ants', word_offset=off))

    def set_chan_header(self, chan, slot_offset=0, verify=False):
        for time_slot in range(self.n_time_demux):
            off = time_slot*self.n_slots + slot_offset
            self.write_int('chans', chan, word_offset=off)
            if verify:
                assert(chan == self.read_int('chans', word_offset=off))

    def initialize(self, verify=False):
        for time_slot in range(self.n_slots):
            self.set_dest_ip([0,0], time_slot, verify=verify)
            self.set_ant_header(0, time_slot, verify=verify)
            self.set_chan_header(0, time_slot, verify=verify)

    #def assign_slot(self, slot_num, chans, dests, reorder_block, ant,
    #                verify=False):
    #    """
    #    The F-engine generates 8192 channels, but can only
    #    output 6144(=8192 * 3/4), in order to keep within the output data rate cap.
    #    Each output packet contains 384 frequency channels for a single antenna.
    #    There are thus effectively 16 output slots, each corresponding
    #    to a block of 384 frequency channels. Each block can be filled with
    #    arbitrary channels (they can repeat, if you want), and sent
    #    to a particular IP address.
    #    slot_num -- a value from 0 to 15 -- the slot you want to allocate
    #    chans    -- an array of 384 channels, which you want to put in this slot's packet
    #    dests     -- A list of IP addresses of the odd and even X-engines for this chan range.
    #    reorder_block -- a ChanReorder block object, which allows the
    #                     packetizer to manipulate the channel ordering of the design. Bit gross. Sorry.
    #    ants     -- The antenna index of the first antenna on this board. One packet contains 3 antennas

    #    """
    #    NCHANS_PER_SLOT = 384
    #    chans = np.array(chans, dtype='>L')
    #    if slot_num > self.n_slots:
    #        raise ValueError("Only %d output slots can be specified" % self.n_slots)
    #    if chans.shape[0] != NCHANS_PER_SLOT:
    #        raise ValueError("Each slot must contain %d frequency channels" % NCHANS_PER_SLOT)

    #    if (type(dests) != list) or (len(dests) != self.n_time_demux):
    #        raise ValueError("Packetizer requires a list of desitination IPs with %d entries" % self.n_time_demux)

    #    # Set the frequency header of this slot to be the first specified channel
    #    self.set_chan_header(chans[0], slot_offset=slot_num, verify=verify)

    #    # Set the antenna header of this slot (every slot represents 3 antennas
    #    self.set_ant_header(ant=ant, slot_offset=slot_num, verify=verify)

    #    # Set the destination address of this slot to be the specified IP address
    #    self.set_dest_ip(dests, slot_offset=slot_num, verify=verify)

    #    # set the channel orders
    #    # The channels supplied need to emerge in the first 384 channels of a block
    #    # of 512 (first 192 clks of 256clks for 2 pols)
    #    for cn, chan in enumerate(chans[::8]):
    #        reorder_block.reindex_channel(chan//8, slot_num*64 + cn, verify=verify)

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

    def set_ant_phases(self, ant, phases, verify=False):
        """
        Set the coefficients for `ant` to `phases`.
        The latter should be a numpy array of phases. It
        will be repeated as necessary to fill the bram.
        """
        try:
            phases = np.array(phases)
        except Exception as e:
            self._error("Couldn't convert phase coefficients to numpy array: " + str(e))
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
        if verify:
            assert(self.read('phases', offset=self._get_ant_offset_bytes(ant)) == phases_str)

    def get_ant_phases(self, ant):
        """
        Get a numpy array of the phases stored for antenna `ant`
        """
        phases_str = self.read('phases', self.n_slots * (self.coeff_bits // 8), offset=self._get_ant_offset_bytes(ant))
        return np.array(struct.unpack('>%dl' % (len(phases_str)//4), phases_str), dtype=np.float64) / 2**self.coeff_bp


    def enable(self, verify=False):
        self.write_int('en', 1)
        if verify:
            assert(self.read_int('en') == 1)

    def disable(self, verify=False):
        self.write_int('en', 0)
        if verify:
            assert(self.read_int('en') == 0)

    def is_enabled(self):
        return self.read_int('en') == 1

    def initialize(self, verify=False):
        self.disable(verify=verify)
        for ant in range(self.n_streams // 2):
            self.set_ant_phases(ant, [0], verify=verify)


class Eth(Block):
    def __init__(self, host, name, port=10000, logger=None):
        super(Eth, self).__init__(host, name, logger)
        self.port = port
        if True: # 2019 "modern" 10gbe
            self.BASE_ARP_OFFSET = 0x1000
            self.IP_OFFSET = 0x14
            self.SOURCE_PORT_OFFSET = 0x30 # or is it 0x2C as declared in mmap?
        else: # 2016 "legacy" 10gbe
            self.BASE_ARP_OFFSET = 0x3000
            self.IP_OFFSET = 0x10
            self.SOURCE_PORT_OFFSET = 0x20 # or is it 0x22 as declared in mmap?
        # These are bit offsets within ctrl register
        self.STATUS_OFFSET = 18
        self.PORT_OFFSET = 2
        self.PORT_WIDTH = 16
        self.RESET_OFFSET = 0
        self.ENABLE_OFFSET = 1
        self.PORT_FORMAT = '>BBH'

    def set_arp_table(self, macs, verify=False):
        """
        Set the ARP table with a list of MAC addresses.
        The list, `macs`, is passed such that the zeroth
        element is the MAC address of the device with
        IP XXX.XXX.XXX.0, and element N is the MAC
        address of the device with IP XXX.XXX.XXX.N
        """
        macs = list(macs)
        macs_pack = struct.pack('>%dQ' % (len(macs)), *macs)
        self.write('sw', macs_pack, offset=self.BASE_ARP_OFFSET)
        if verify:
            for mac1, mac2 in zip(macs, self.get_arp_table()):
                assert(mac1 == mac2)

    def get_arp_table(self):
        MAX_MACS = 256 # XXX is 256 the maximum number of macs?
        macs_str = self.read('sw', MAX_MACS * struct.calcsize('Q'),
                             offset=self.BASE_ARP_OFFSET)
        macs = struct.unpack('>%dQ' % (MAX_MACS), macs_str)
        return macs

    def add_arp_entry(self, ip, mac, verify=False):
        """
        Set a single arp entry.
        """
        mac_pack = struct.pack('>Q', mac)
        ip_offset = ip % 256
        self.write('sw', mac_pack,
                   offset=self.BASE_ARP_OFFSET + ip_offset*8)
        if verify:
            assert(mac_pack == self.read('sw', len(mac_pack),
                        offset=self.BASE_ARP_OFFSET + 8*ip_offset))

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
        self.set_reg_bits('ctrl', 0, self.STATUS_OFFSET)
        self.set_reg_bits('ctrl', 1, self.STATUS_OFFSET)
        self.set_reg_bits('ctrl', 0, self.STATUS_OFFSET)

    def get_port(self):
        port = self.read_uint('ctrl')
        port /= 2**self.PORT_OFFSET
        port &= 2**self.PORT_WIDTH - 1
        return port

    def set_port(self, port, verify=False):
        self.port = port
        self.set_reg_bits('ctrl', port,
                             self.PORT_OFFSET, self.PORT_WIDTH)
        if verify:
            assert(port == self.get_port())

    def reset(self):
        # stop traffic before reset
        self.disable_tx()
        # toggle reset
        self.set_reg_bits('ctrl', 0, self.RESET_OFFSET)
        self.set_reg_bits('ctrl', 1, self.RESET_OFFSET)
        self.set_reg_bits('ctrl', 0, self.RESET_OFFSET)

    def enable_tx(self, verify=False):
        self.set_reg_bits('ctrl', 1, self.ENABLE_OFFSET)
        if verify:
            assert(self.check_enabled())

    def disable_tx(self, verify=False):
        self.set_reg_bits('ctrl', 0, self.ENABLE_OFFSET)
        if verify:
            assert(not self.check_enabled())

    def check_enabled(self):
        val = self.read_uint('ctrl') >> self.ENABLE_OFFSET
        val &= 0x1 # mask to one bit
        return val

    def get_ipaddr(self):
        # read a 32b word containing the IP address
        ipaddr = self.read('sw', 4, offset=self.IP_OFFSET)
        return ipaddr

    def set_ipaddr(self, ipaddr, verify=False):
        self.blindwrite('sw', ipaddr, offset=self.IP_OFFSET)
        if verify:
            assert(ipaddr == self.get_ipaddr())

    def initialize(self, verify=False):
        #Set ip address of the SNAP
        ipaddr = socket.inet_aton(socket.gethostbyname(self.host.host))
        self.set_ipaddr(ipaddr, verify=verify)
        self.set_port(self.port, verify=verify)

    def get_source_port(self):
        # see config_10gbe_core in katcp_wrapper
        portstr = self.read('sw', struct.calcsize(self.PORT_FORMAT),
                            offset=self.SOURCE_PORT_OFFSET)
        port = struct.unpack(self.PORT_FORMAT, portstr)
        # Skipping first two bytes, which are 0, 1
        return port[-1]

    def set_source_port(self, port, verify=False):
        # see config_10gbe_core in katcp_wrapper
        self.blindwrite('sw', struct.pack(self.PORT_FORMAT, 0, 1, port),
                        offset=self.SOURCE_PORT_OFFSET)
        if verify:
            assert(port == self.get_source_port())


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

    def set_acc_len(self, acc_len, verify=False):
        """
        Set the number of spectra to accumulate to `acc_len`
        """
        self.acc_len = acc_len
        # Convert to clks from spectra. FFT output length = 8192
        # with 8 samples in parallel = 8192/8 clocks per spectrum
        self.write_int('acc_len', 1024 * self.acc_len)
        if verify:
            assert(self.get_acc_len() == self.acc_len)

    def initialize(self, verify=False):
        self.set_acc_len(self.acc_len, verify=verify)


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
        Features
        attenuation Attenuation for East and North Pol
        shunt       Voltage and current of the power supply
        rom         Memo
        id          Device ID
        power       Power level of East and North Pol

        host: CasperFpga instance
        name: Select one of the three PAMs(/Antennas) under the control of
                a SNAP board: 'i2c_ant1', 'i2c_ant2' or 'i2c_ant3'.
        """
        super(Pam, self).__init__(host, name, logger)

        self.i2c = i2c.I2C(host, name, retry=self.I2C_RETRY)
        self._cached_atten = None  # for checking I2C stability

    def _warning(self, msg, *args, **kwargs):
        self.logger.log(I2CWARNING, self._prefix_log(msg), *args, **kwargs)

    def initialize(self, verify=False):

        self.i2c.enable_core()
        # set i2c bus to 10 kHz
        self.i2c.setClock(self.CLK_I2C_BUS, self.CLK_I2C_REF)

    def get_status(self):
        """Return a dict of config status."""
        rv = {}
        try:
            rv["atten_e"], rv["atten_n"] = self.get_attenuation()
            rv["power_e"] = self.power('east')
            rv["power_n"] = self.power('north')
            rv["voltage"] = self.shunt("u")
            rv["current"] = self.shunt("i")
            rv["id"] = self.id()
        except(RuntimeError, IOError):
            rv["atten_e"] = ERROR_VALUE
            rv["atten_n"] = ERROR_VALUE
            rv["power_e"] = ERROR_VALUE
            rv["power_n"] = ERROR_VALUE
            rv["voltage"] = ERROR_VALUE
            rv["current"] = ERROR_VALUE
            rv["id"] = ERROR_STRING
        return rv

    def get_attenuation(self):
        """Get East and North attenuation
            returns: (east attenuation (dB int), north (dB int)
        """
        if not hasattr(self, "_atten"):
            self._atten = i2c_gpio.PCF8574(self.i2c, self.ADDR_GPIO)
        val = self._atten.read()
        east, north = self._gpio2db(val)
        if self._cached_atten is not None and \
                self._cached_atten != (east, north):
            self._warning('Read value %s != written value %s'
                          % ((east, north), self._cached_atten))
        return east, north

    def set_attenuation(self, east, north, verify=False):
        """ Set East and North attenuation in dB
            attenuation values must be integers in range(16)

            Example:
            attenuation(east=0,north=15)
        """
        if not hasattr(self, "_atten"):
            self._atten = i2c_gpio.PCF8574(self.i2c, self.ADDR_GPIO)

        self._atten.write(self._db2gpio(east, north))
        self._cached_atten = (east, north)  # cache for stability check
        if verify:
            assert((east, north) == self.get_attenuation())

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
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._warning("Failed to initialize I2C current sensor: " + str(e))
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
                self._sn = i2c_sn.DS28CM00(self.i2c, self.ADDR_SN)
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._warning("Failed to initialize I2C ID chip:  " + str(e))
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
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._warning("Failed to initialize I2C power sensor: " + str(e))
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
                self._rom = i2c_eeprom.EEP24XX64(self.i2c, self.ADDR_ROM)
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._warning("Failed to initialize I2C ROM: " + str(e))
                return None

        try:
            if string is None:
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
        assert val>=0 and val<=3.3, \
            "Input value {} out range of 0-3.3V".format(val)
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
    SWMODE = {'load':0b000,'antenna':0b110,'noise':0b001}
    SWMODE_REV = {0b000:'load', 0b110:'antenna', 0b001:'noise',}

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

    def initialize(self, verify=False):
        self.i2c.enable_core()
        # set i2c bus to 10 kHz
        self.i2c.setClock(self.CLK_I2C_BUS, self.CLK_I2C_REF)

    def get_status(self):
        '''Return dict of config status.'''
        rv = {}
        try:
            switch, east, north = self.switch()
            rv["switch"] = switch
            rv["lna_power_e"] = east
            rv["lna_power_n"] = north
            rv["temp"] = self.temperature()
            rv["voltage"] = self.shunt("u")
            rv["current"] = self.shunt("i")
            rv["id"] = self.id()
            theta, phi = self.imu()
            rv["imu_theta"] = theta
            rv["imu_phi"] = phi
            rv["pressure"] = self.pressure()
            rv["humidity"] = self.humidity()
        except(RuntimeError, IOError):
            rv["switch"] = ERROR_STRING
            rv["lna_power_e"] = ERROR_VALUE
            rv["lna_power_n"] = ERROR_VALUE
            rv["temp"] = ERROR_VALUE
            rv["voltage"] = ERROR_VALUE
            rv["current"] = ERROR_VALUE
            rv["id"] = ERROR_STRING
            rv["imu_theta"] = ERROR_VALUE
            rv["imu_phi"] = ERROR_VALUE
            rv["pressure"] = ERROR_VALUE
            rv["humidity"] = ERROR_VALUE
        return rv

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
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._warning("Failed to initialize I2C barometer: " + str(e))
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
                self._cur = i2c_volt.INA219(self.i2c, self.ADDR_INA)
                self._cur.init()
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._warning("Failed to initialize I2C FEM current sensor: " + str(e))
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
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._warning("Failed to initialize I2C temperature sensor: " + str(e))
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
                self._imu = i2c_motion.IMUSimple(self.i2c, self.ADDR_ACCEL,
                                                 orient=self.IMU_ORIENT)
                self._imu.init()
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._warning("Failed to initialize I2C IMU: " + str(e))
                return None, None

        try:
            theta, phi = self._imu.pose
            return theta, phi
        except Exception:
            self._warning('Failed to read I2C IMU')
            del self._imu
            return None, None

    def rom(self, string=None):
        """ Read string from ROM or write String to ROM

            Example:
            rom()               # returns a string ended with a '\0'
            rom('hello')        # write 'hello\0' into ROM
        """
        if not hasattr(self, "_rom"):
            try:
                # ROM
                self._rom = i2c_eeprom.EEP24XX64(self.i2c, self.ADDR_ROM)
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._warning("Failed to initialize FEM I2C ROM: " + str(e))
                return None

        try:
            if string is None:
                return self.rom.readString()
            else:
                self.rom.writeString(string)
        except Exception:
            self._warning("Failed to operate FEM I2C ROM")
            return None

    def switch(self, mode=None, east=None, north=None, verify=False):
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
                # instantiate switch
                self._sw = i2c_gpio.PCF8574(self.i2c, self.ADDR_GPIO)
            except AttributeError:
                raise AttributeError
            except Exception as e:
                raise RuntimeError('Failed to initialize I2C RF switch: ' + str(e))
        try:
            val = self._sw.read()
        except Exception:
            raise RuntimeError("I2C RF switch read failure")
        cur_e = bool(val & 0b00001000)
        cur_n = bool(val & 0b00010000)
        cur_mode = self.SWMODE_REV.get(val & 0b00000111, 'Unknown')
        if mode is None and east is None and north is None:
            return cur_mode, cur_e, cur_n
        if east is None:
            east = east or cur_e
        if north is None:
            north = cur_n
        if mode is None:
            mode = cur_mode
        new_val = 0b00000000
        if east:
            new_val |= 0b00001000
        if north:
            new_val |= 0b00010000
        new_val |= self.SWMODE.get(mode, val & 0b00000111)
        self._sw.write(new_val)
        if verify:
            assert(new_val == self._sw.read())

    def humidity(self):
        """ Get relative humidity in percentage
        """
        if not hasattr(self, "_rh"):
            try:
                # Relative Humidity
                self._rh = i2c_temp.Si7021(self.i2c, self.ADDR_TEMP)
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._info("Failed to initialize I2C humidity sensor: " + str(e))
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
            except AttributeError:
                raise AttributeError
            except Exception as e:
                self._info("Failed to initialize I2C temperature sensor: " + str(e))
                return None
        try:
            return self._temp.readTemp()
        except Exception:
            self._warning("Failed to read I2C temperature sensor")
            return None
