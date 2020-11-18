import logging
from hera_corr_cm.handlers import add_default_log_handlers
import numpy as np
import datetime
import casperfpga
from blocks import *

# 'source_sel' register only on fpga only uses lowest 2 bits
# using the others to mark status bits
ADC_LINE_ALIGNED_BIT = 11
ADC_FRAME_ALIGNED_BIT = 12
ADC_RAMP_TEST_BIT = 13
ADC_LANE_BONDED_BIT = 14
INITIALIZED_BIT = 15
PAM_MAX = 15
PAM_MIN = 0

class SnapFengine(object):
    def __init__(self, host, ant_indices=None, logger=None,
                 redishost='redishost'):
        self.host = host
        if logger is None:
            logger = add_default_log_handlers(
                        logging.getLogger(__name__ + "(%s)" % host))
        self.logger = logger
        if redishost is None:
            self.fpga = casperfpga.CasperFpga(host=host,
                                transport=casperfpga.TapcpTransport)
        else:
            self.fpga = casperfpga.CasperFpga(host=host,
                                redishost=redishost,
                                transport=casperfpga.RedisTapcpTransport)
        # Try and get the canonical name of the host
        # to use as a serial number
        try:
            self.serial = socket.gethostbyaddr(self.host)[0]
        except:
            self.serial = None

        # blocks
        self.synth = Synth(self.fpga, 'lmx_ctrl')
        self.adc = Adc(self.fpga) # not a subclass of Block
        self.sync = Sync(self.fpga, 'sync')
        self.noise = NoiseGen(self.fpga, 'noise', nstreams=3)
        self.input = Input(self.fpga, 'input', nstreams=12)
        self.delay = Delay(self.fpga, 'delay', nstreams=6)
        self.pfb = Pfb(self.fpga, 'pfb')
        self.eq = Eq(self.fpga, 'eq_core', nstreams=6, ncoeffs=2**10)
        self.eq_tvg = EqTvg(self.fpga, 'eqtvg', nstreams=6, nchans=2**13)
        self.reorder = ChanReorder(self.fpga, 'chan_reorder', nchans=2**10)
        self.rotator = Rotator(self.fpga, 'rotator', n_chans=2**13,
                          n_streams=2**3, max_spec=2**19, block_size=2**10)
        # Packetizer n_time_demux: Round robin time packets to two dests
        self.packetizer = Packetizer(self.fpga, 'packetizer',
                                     n_time_demux=2)
        self.eth = Eth(self.fpga, 'eth')
        self.corr = Corr(self.fpga,'corr_0')
        self.phase_switch = PhaseSwitch(self.fpga, 'phase_switch')

        # store antenna numbers used in packet headers
        self.ant_indices = ant_indices or range(3)

        # blocks initialized in this (significant) order
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
            self.phase_switch,
        ]

        if self.is_programmed():
            self.initialized = self.is_initialized()
        else:
            self.initialized = False

        self.i2c_initialized = False
        # The I2C devices mess with FPGA registers
        # when instantiated. This will fail if the board
        # isn't programmed yet, so don't bother trying if this
        # is not the case.
        if self.fpga.is_connected() and self.is_programmed():
            try:
                self._add_i2c()
            except:
                self.logger.warning("Failed to register I2C")

    def _add_i2c(self):
        self.pams = [Pam(self.fpga, 'i2c_ant%d' % i) for i in range(3)]
        self.fems = [Fem(self.fpga, 'i2c_ant%d' % i) for i in range(3)]
        # initialize the FEMs/PAMs to get access to their methods.
        for pam in self.pams:
            pam.initialize()
        for fem in self.fems:
            fem.initialize()
        self.blocks += self.pams
        self.blocks += self.fems
        self.i2c_initialized = True

    def is_programmed(self):
        """
        Check if board is programmed by lazily reading 
        "adc16_controller" register.
        Returns:
            True if programmed, False otherwise
        """
        return 'adc16_controller' in self.fpga.listdev()

    def initialize_adc(self):
        """
        Initialize the Synth and Adc blocks, then reprogram FPGA.
        """        
        self.synth.initialize()
        self.adc.init()
        # Mark ADC as uncalibrated
        self._set_adc_status(0, 0, 0, 0)

    def align_adc(self, force=False, verify=True):
        if force:
            self._set_adc_status(0, 0, 0, 0)
        status = self.get_adc_status()
        if all(status.values()):
            return
        if not status['line']:
            fails = self.adc.alignLineClock()
            status['line'] = bool(len(fails) == 0)
            if not status['line']:
                self.logger.warning("alignLineClock failed on: " + str(fails))
        if status['line'] and not status['frame']:
            fails = self.adc.alignFrameClock()
            status['frame'] = bool(len(fails) == 0)
            if not status['frame']:
                self.logger.warning("alignFrameClock failed on: " + str(fails))
        self.adc.setDemux(numChannel=1)
        if status['line'] and status['frame'] and not status['ramp']:
            status['ramp'] = self.adc.rampTest()
        if status['line'] and status['frame'] and not status['bonded']:
            status['bonded'] = self.adc.isLaneBonded()
        self.adc.setDemux(numChannel=self.adc.num_chans)
        self._set_adc_status(**status) # record status
        if verify:
            assert(all(status.values())) # errors if anything failed
        # Otherwise, finish up here.
        self.adc.selectADC()
        self.adc.adc.selectInput([1,1,3,3])
        self.adc.set_gain(4)
        

    def _set_adc_status(self, line=None, frame=None, ramp=None,
                        bonded=None):
        def setbit(reg, bit, val):
            reg &= 0xFFFFFFFF - 2**bit
            reg |= int(val) * 2**bit
            return reg
        reg = self.input.read_uint('source_sel')
        if line is not None:
            reg = setbit(reg, ADC_LINE_ALIGNED_BIT, int(line))
        if frame is not None:
            reg = setbit(reg, ADC_FRAME_ALIGNED_BIT, int(frame))
        if ramp is not None:
            reg = setbit(reg, ADC_RAMP_TEST_BIT, int(ramp))
        if bonded is not None:
            reg = setbit(reg, ADC_LANE_BONDED_BIT, int(bonded))
        self.input.write_uint('source_sel', reg)

    def get_adc_status(self):
        val = self.input.read_uint('source_sel')
        status = {}
        status['line']  = bool(val & 2**ADC_LINE_ALIGNED_BIT)
        status['frame'] = bool(val & 2**ADC_FRAME_ALIGNED_BIT)
        status['ramp']  = bool(val & 2**ADC_RAMP_TEST_BIT)
        status['bonded']  = bool(val & 2**ADC_LANE_BONDED_BIT)
        return status

    def adc_is_configured(self):
        """
        Read the source_sel register 
        within the Input block is see if the ADC is configured. 
        """
        return all(self.get_adc_status().values())

    def initialize(self, verify=False):

        # Init PAMs and FEMs
        if not self.i2c_initialized:
            self._add_i2c()
        
        # Init all blocks other than Synth and ADC 
        blocks_to_init = [blk for blk in self.blocks
                          if blk not in [self.synth, self.adc]]

        for block in blocks_to_init:
            self.logger.info("Initializing block: %s" % block.name)
            block.initialize(verify=verify)
        
        self._set_initialized(1)

    def _set_initialized(self, value):
        # Set the initialized flag -- arbit reg in the design.
        self.input.change_reg_bits('source_sel', value, INITIALIZED_BIT, 1)

    def declare_uninit(self):
        self._set_initialized(0)

    def is_initialized(self):
        """
        16th bit from LSB (0x8000) of the source_sel register 
        within the Input block is set when the Fengine is 
        initialized. Look for this bit and return.
        """
        return self.input.read_uint('source_sel') & 2**INITIALIZED_BIT

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

    def assign_slot(self, slot_num, chans, dests):
        """
        Choose which 6144 channels (of 8192) to output via 10GbE.
        Each output packet contains 384 freq channels for a single antenna,
        There are 16 output slots, each corresponding to a block of
        384 frequency channels. Each block can be filled with
        arbitrary channels (they can repeat, if you want), and sent
        to a particular IP address.

        Arguments:
            slot_num: integer value (0 to 15); the slot to configure
            chans: array of 384 channels to put in slot's packet
            dests: list of IP addr of odd/even X-engines for chan range
        """
        NCHANS_PER_SLOT = 384
        chans = np.array(chans, dtype='>L')
        assert(slot_num <= self.packetizer.n_slots)
        assert(chans.shape[0] == NCHANS_PER_SLOT)
        assert(len(dests) == self.packetizer.n_time_demux)

        # Set frequency header of slot to the first specified channel
        self.packetizer.set_chan_header(chans[0], slot_offset=slot_num)

        # Set antenna header of slot (every slot represents 3 antennas
        self.packetizer.set_ant_header(ant=self.ant_indices[0],
                                       slot_offset=slot_num)

        # Set destination address of slot to be the specified IP address
        self.packetizer.set_dest_ip(dests, slot_offset=slot_num)

        # set the channel orders
        # channels supplied must emerge in first 384 channels of a block
        # of 512 (first 192 clks of 256clks for 2 pols)
        for cnt, chan in enumerate(chans[::8]):
            self.reorder.reindex_channel(chan//8, slot_num*64 + cnt)

#    def get_pam_atten_by_target(self, chan, target_pow=None,
#                                target_rms=None):
#        """
#        Set the PAM attenuation values of Antenna `ant`, polarization `pol`
#        so as to target either a PAM power level `target_pow` dBm, or an
#        ADC RMS of `target_rms` units.
#        Inputs:
#           chan (int): Which ADC channel 0-5
#           target_pow (float): dBm target
#           target_rms (float): ADC RMS target
#        Returns:
#           bool of whether PAM attenuation reached target
#        """
#        assert (target_pow is None) or (target_rms is None), \
#                "You may only target _either_ an ADC RMS _or_ a PAM power"
#        assert (target_pow is not None) or (target_rms is not None), \
#                "You must target _either_ an ADC RMS _or_ a PAM power"
#        pam = self.pams[chan//2]
#        current_pam_atten_e, current_pam_atten_n = pam.get_attenuation()
#        if chan % 2:
#            current_pam_atten = current_pam_atten_n
#            pam_pol = "east"
#        else:
#            current_pam_atten = current_pam_atten_e
#            pam_pol = "north"
#
#        if current_pam_atten is None:
#            self.logger.error("Failed to read PAM attenuator settings")
#            return False
#        if target_pow is not None:
#            current_pow = pam.power(pam_pol)
#            if current_pow is None:
#                self.logger.error("Failed to read power")
#                return False
#            req_atten = current_pam_atten + int(current_pow - target_pow)
#        elif target_rms is not None:
#            _, _, current_rms = self.input.get_stats(sum_cores=True)
#            current_rms = current_rms[chan]
#            req_atten = current_pam_atten + \
#                        int(20*np.log10(current_rms/target_rms))
#
#        # saturate to allowed PAM attenuation levels
#        req_atten = max(req_atten, PAM_MIN)
#        req_atten = min(req_atten, PAM_MAX)
#        return req_atten
