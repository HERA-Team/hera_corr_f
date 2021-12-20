import logging
from hera_corr_cm.handlers import add_default_log_handlers
import numpy as np
import time
import json
import datetime
import casperfpga
import socket
from blocks import *

# 'source_sel' register only on fpga only uses lowest 2 bits
# using the others to mark status bits
DEST_CONFIG_BIT = 13
ADC_ALIGNED_BIT = 14
INITIALIZED_BIT = 15
PAM_MAX = 15
PAM_MIN = 0


def _jsonify(val, cast=True):
    if not cast:
        return val
    # make a few explicit type conversions to coerce non-redis
    # compatible variables into redis.
    if isinstance(val, bool):
        # bools are compared using lambda x: x == "True" later
        val = str(val)
    elif isinstance(val, (list, tuple, dict)):
        val = json.dumps(val)
    elif isinstance(val, np.ndarray):
        val = json.dumps(val.tolist())
    elif val is None:
        # newer redis-py does not accept Nonetype, wrap in json.dumps
        val = json.dumps(val)
    return val


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
        self.adc = Adc(self.fpga)  # not a subclass of Block
        self.sync = Sync(self.fpga, 'sync')
        self.noise = NoiseGen(self.fpga, 'noise', nstreams=6)
        self.input = Input(self.fpga, 'input', nstreams=12)
        self.delay = Delay(self.fpga, 'delay', nstreams=6)
        self.pfb = Pfb(self.fpga, 'pfb')
        self.eq = Eq(self.fpga, 'eq_core', nstreams=6, ncoeffs=2**10)
        #self.eq_tvg = EqTvg(self.fpga, 'eqtvg', nstreams=6, nchans=2**13)
        self.reorder = ChanReorder(self.fpga, 'chan_reorder', nchans=2**10)
        #self.rotator = Rotator(self.fpga, 'rotator', n_chans=2**13,
        #                  n_streams=2**3, max_spec=2**19, block_size=2**10)
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
            # self.eq_tvg, # temporarily removed
            self.reorder,
            self.packetizer,
            self.eth,
            self.corr,
            self.phase_switch,
        ]

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
        """Check if programmed by reading "adc16_controller" register."""
        return 'adc16_controller' in self.fpga.listdev()

    def version(self):
        """Read the version of the FPGA bitstream."""
        val = self.fpga.read_uint('version_version')
        major = val >> 16
        minor = val & 0xffff
        return major, minor

    def program(self, progfile, force=False, verify=False, timeout=10):
        """Program the FPGA of this board."""
        if not force and self.is_programmed():
            return
        self.logger.info("Programming FPGA with: %s" % progfile)
        self.fpga.upload_to_ram_and_program(progfile)
        if verify:
            t = time.time()
            while not self.fpga.is_running() and time.time() - t < timeout:
                time.sleep(0.1)
            assert(self.fpga.is_running())

    def initialize_adc(self, sample_rate=500., verify=False):
        """Initialize Synth and Adc blocks, then reprogram FPGA."""
        self.synth.initialize(verify=verify)
        self.adc.init(sample_rate=sample_rate, verify=verify)
        # Mark ADC as uncalibrated
        self._set_adc_status(0)

    def align_adc(self, force=False, verify=True):
        """Align clock and data lanes of ADC."""
        if force:
            self._set_adc_status(0)
        if self.adc_is_configured():
            return
        fails = self.adc.alignLineClock()
        if len(fails) > 0:
            self.logger.warning("alignLineClock failed on: " + str(fails))
        fails = self.adc.alignFrameClock()
        if len(fails) > 0:
            self.logger.warning("alignFrameClock failed on: " + str(fails))
        fails = self.adc.rampTest()
        if len(fails) > 0:
            self.logger.warning("rampTest failed on: " + str(fails))
        else:
            self._set_adc_status(1)  # record status
        if verify:
            assert(self.adc_is_configured())  # errors if anything failed
        # Otherwise, finish up here.
        self.adc.selectADC()
        self.adc.adc.selectInput([1, 1, 3, 3])
        self.adc.set_gain(4)

    def _set_adc_status(self, val):
        self.input.set_reg_bits('source_sel', val, ADC_ALIGNED_BIT, 1)

    def adc_is_configured(self):
        """
        Read the source_sel register
        within the Input block is see if the ADC is configured.
        """
        return self.input.get_reg_bits('source_sel', ADC_ALIGNED_BIT, 1)

    def initialize(self, force=False, verify=False):

        if force:
            self._set_initialized(0)
            self.i2c_initialized = False
        # Init PAMs and FEMs
        if not self.i2c_initialized:
            self._add_i2c()
        if self.is_initialized():
            return

        if self.version()[0] < 7:
            # Version 6 had no noise generator
            self.blocks = [blk for blk in self.blocks
                           if blk not in [self.noise]]

        # Init all blocks other than Synth and ADC
        blocks_to_init = [blk for blk in self.blocks
                          if blk not in [self.synth, self.adc]]

        for block in blocks_to_init:
            self.logger.info("Initializing block: %s" % block.name)
            block.initialize(verify=verify)

        self._set_initialized(1)

    def _set_initialized(self, value):
        # Set the initialized flag -- arbit reg in the design.
        self.input.set_reg_bits('source_sel', value, INITIALIZED_BIT, 1)

    def is_initialized(self):
        """
        16th bit from LSB (0x8000) of the source_sel register
        within the Input block is set when the Fengine is
        initialized. Look for this bit and return.
        """
        return self.input.get_reg_bits('source_sel', INITIALIZED_BIT, 1)

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
        # 25 Feb 2021 MJK: according to jKocz this is no longer available
        # but I'm not comfortable just deleting things this far down in the correlator.
        # stat['pmb_alert'] = self.fpga.read_uint('pmbus_alert')
        return stat

    def assign_dest(self, slot_num, chans, dests, verify=False):
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
        self.packetizer.set_chan_header(chans[0], slot_offset=slot_num, verify=verify)

        # Set antenna header of slot (every slot represents 3 antennas
        self.packetizer.set_ant_header(ant=self.ant_indices[0],
                                       slot_offset=slot_num, verify=verify)

        # Set destination address of slot to be the specified IP address
        self.packetizer.set_dest_ip(dests, slot_offset=slot_num, verify=verify)

        # set the channel orders
        # channels supplied must emerge in first 384 channels of a block
        # of 512 (first 192 clks of 256clks for 2 pols)
        for cnt, chan in enumerate(chans[::8]):
            self.reorder.reindex_channel(chan//8, slot_num*64 + cnt, verify=verify)

    def _set_dest_configured(self, value):
        # Set the initialized flag -- arbit reg in the design.
        self.input.set_reg_bits('source_sel', value, DEST_CONFIG_BIT, 1)

    def dest_is_configured(self):
        """
        """
        return self.input.get_reg_bits('source_sel', DEST_CONFIG_BIT, 1)

    def set_input(self, source, seed=0, stream=None, verify=True):
        """
        Choose the input to the F-Engine.

        Inputs:
            source (str): Either 'adc' or 'noise'.
            seed (int): Initialization seed if source is 'noise'.
            stream (int): Which stream to switch. If None, switch all.
            verify (bool): Verify configuration. Default True.
        """
        if source == 'adc':
            self.input.use_adc(stream=stream, verify=verify)
        elif source == 'noise':
            # inputs share noisegens, so relevant seed may be below
            self.noise.set_seed(stream=stream, seed=seed, verify=verify)
            self.input.use_noise(stream=stream, verify=verify)
        else:
            raise ValueError('Unsupported source: %s' % (source))

    def get_input(self, stream=None):
        """
        Read input mode for F-Engine.

        Inputs:
            stream (int): Which stream to read input mode. If None, all.
        """
        if stream is None:
            streams = list(range(self.input.ninput_mux_streams))
        else:
            streams = [stream]
        inputs = []
        for stream in streams:
            code = self.input.get_reg_bits('source_sel',
                            2*(self.input.ninput_mux_streams-1-stream), 2)
            if code == self.input.USE_ADC:
                inputs.append('adc')
            elif code == self.input.USE_NOISE:
                # inputs share noisegens, so relevant seed may be below
                seed = self.noise.get_seed(2*(stream//2))
                inputs.append('noise-%d' % (seed))
            else:
                raise ValueError('Unrecognized input: %d' % (code))
        if len(streams) == 1:
            return inputs[0]
        else:
            return inputs

    def get_status(self, jsonify=False):
        '''Return dict of config status.'''
        jsonify = lambda val: _jsonify(val, cast=jsonify)
        status = {}
        # High-level configuration status
        status['is_programmed'] = jsonify(self.is_programmed())
        status['sample_rate'] = jsonify(self.adc.lmx.getFreq())
        status['version'] = jsonify('%d.%d' % self.version())
        status['adc_is_configured'] = jsonify(self.adc_is_configured())
        status['is_initialized'] = jsonify(self.is_initialized())
        status['dest_is_configured'] = jsonify(self.dest_is_configured())
        status['input'] = jsonify(','.join(self.get_input()))
        # Lower level stuff, deprecates get_fpga_stats
        status['temp'] = jsonify(self.fpga.transport.get_temp())
        status['timestamp'] = jsonify(datetime.datetime.now().isoformat())
        status['uptime'] = jsonify(self.sync.uptime())
        status['pps_count'] = jsonify(self.sync.count())
        status['serial'] = jsonify(self.serial)
        # populate pam status
        for i, pam in enumerate(self.pams):
            for key, val in pam.get_status().items():
                if key == 'atten':
                    status["pam%d_e_atten" % i] = jsonify(val[0])
                    status["pam%d_n_atten" % i] = jsonify(val[1])
                else:
                    status["pam%d_" % (i) + key] = jsonify(val)
        # populate fem status
        for i, fem in enumerate(self.fems):
            for key, val in fem.get_status().items():
                status["fem%d_" % (i) + key] = jsonify(val)
        # fft overflow status
        status['fft_overflow'] = jsonify(self.pfb.is_overflowing())
        self.pfb.rst_stats()  # clear pfb overflow flag for next time
        # add adc snapshot statistics
        for key, val in self.input.get_status().items():
            status[key] = jsonify(val)
        # add autocorrelation from on-board correlator
        for stream in range(self.input.ninput_mux_streams):
            status['stream%d_autocorr' % stream] = jsonify(self.corr.get_new_corr(stream, stream).real)
        for stream in range(self.eq.nstreams):
            for key, val in self.eq.get_status(stream):
                if key == 'clip_count':  # There is only one of these per snap.
                    status['eq_%s' % key] = jsonify(val)
                else:
                    status['stream%d_eq_%s' % (stream, key)] = jsonify(val)
        return status

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
