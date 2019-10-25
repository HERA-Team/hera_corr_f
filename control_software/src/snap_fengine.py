import logging
import helpers
import numpy as np
import struct
import time
import datetime
import casperfpga
from blocks import *

class SnapFengine(object):
    def __init__(self, host, ant_indices=None, logger=None, redishost='redishost'):
        self.host = host
        self.logger = logger or helpers.add_default_log_handlers(logging.getLogger(__name__ + "(%s)" % host))
        if redishost is None:
            self.fpga = casperfpga.CasperFpga(host=host, transport=casperfpga.TapcpTransport)
        else:
            self.fpga = casperfpga.CasperFpga(host=host, redishost=redishost, transport=casperfpga.RedisTapcpTransport)
        # Try and get the canonical name of the host
        # to use as a serial number
        try:
            self.serial = socket.gethostbyaddr(self.host)[0]
        except:
            self.serial = None

        # blocks
        self.synth       = Synth(self.fpga, 'lmx_ctrl')
        self.adc         = Adc(self.fpga) # not a subclass of Block
        self.sync        = Sync(self.fpga, 'sync')
        self.noise       = NoiseGen(self.fpga, 'noise', nstreams=3)
        self.input       = Input(self.fpga, 'input', nstreams=12)
        self.delay       = Delay(self.fpga, 'delay', nstreams=6)
        self.pfb         = Pfb(self.fpga, 'pfb')
        self.eq          = Eq(self.fpga, 'eq_core', nstreams=6, ncoeffs=2**10)
        self.eq_tvg      = EqTvg(self.fpga, 'eqtvg', nstreams=6, nchans=2**13)
        self.reorder     = ChanReorder(self.fpga, 'chan_reorder', nchans=2**10)
        self.rotator     = Rotator(self.fpga, 'rotator', n_chans=2**13, n_streams=2**3, max_spec=2**19, block_size=2**10)
        self.packetizer  = Packetizer(self.fpga, 'packetizer', n_time_demux=2) # Round robin time packets to two destinations
        self.eth         = Eth(self.fpga, 'eth')
        self.corr        = Corr(self.fpga,'corr_0')
        self.phaseswitch = PhaseSwitch(self.fpga, 'phase_switch')

        self.ants = [None] * 6 # An attribute to store the antenna names of this board's inputs
        self.ant_indices = ant_indices or range(3) # An attribute to store the antenna numbers used in packet headers
        
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
        ]

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
        self.pams        = [Pam(self.fpga, 'i2c_ant%d' % i) for i in range(3)]
        self.fems        = [Fem(self.fpga, 'i2c_ant%d' % i) for i in range(3)]
        # Need to initialize the FEMs/PAMs to get access to their methods.
        for pam in self.pams:
            pam.initialize()
        for fem in self.fems:
            fem.initialize()
        self.blocks += self.pams
        self.blocks += self.fems
        self.i2c_initialized = True

    def is_programmed(self):
        """
        Lazy check to see if a board is programmed.
        Check for the "adc16_controller" register. If it exists, the board is deemed programmed.
        Returns:
            True if programmed, False otherwise
        """
        return 'adc16_controller' in self.fpga.listdev()

    def initialize(self):
        if not self.i2c_initialized:
            self._add_i2c()
        for block in self.blocks:
            self.logger.info("Initializing block: %s" % block.name)
            block.initialize()
        self.initialized = True

    def is_initialized(self):
        return self.initialized

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

        """
        NCHANS_PER_SLOT = 384
        chans = np.array(chans, dtype='>L')
        if slot_num > self.packetizer.n_slots:
            raise ValueError("Only %d output slots can be specified" % self.packetizer.n_slots)
        if chans.shape[0] != NCHANS_PER_SLOT:
            raise ValueError("Each slot must contain %d frequency channels" % NCHANS_PER_SLOT)

        if (type(dests) != list) or (len(dests) != self.packetizer.n_time_demux):
            raise ValueError("Packetizer requires a list of desitination IPs with %d entries" % self.packetizer.n_time_demux)

        # Set the frequency header of this slot to be the first specified channel
        self.packetizer.set_chan_header(chans[0], slot_offset=slot_num)

        # Set the antenna header of this slot (every slot represents 3 antennas
        self.packetizer.set_ant_header(ant=self.ant_indices[0], slot_offset=slot_num)

        # Set the destination address of this slot to be the specified IP address
        self.packetizer.set_dest_ip(dests, slot_offset=slot_num)

        # set the channel orders
        # The channels supplied need to emerge in the first 384 channels of a block
        # of 512 (first 192 clks of 256clks for 2 pols)
        for cn, chan in enumerate(chans[::8]):
            self.reorder.reindex_channel(chan//8, slot_num*64 + cn)

    def get_pam_atten_by_target(self, chan, target_pow=None, target_rms=None):
        """
        Set the PAM attenuation values of Antenna `ant`, polarization `pol`
        so as to target either a PAM power level `target_pow` dBm, or an
        ADC RMS of `target_rms` units.
        Inputs:
           chan (int): Which ADC channel 0-5
           target_pow (float): dBm target
           target_rms (float): ADC RMS target
        Returns:
           The required PAM attenuation to reach the target. Or False if failure
        """
        assert (target_pow is None) or (target_rms is None), "You may only target _either_ an ADC RMS _or_ a PAM power"
        assert (target_pow is not None) or (target_rms is not None), "You must target _either_ an ADC RMS _or_ a PAM power"
        pam = self.pams[chan//2]
        current_pam_atten_e, current_pam_atten_n = pam.get_attenuation()
        if chan % 2:
            current_pam_atten = current_pam_atten_n
            pam_pol = "east"
        else:
            current_pam_atten = current_pam_atten_e
            pam_pol = "north"

        if current_pam_atten is None:
            self.logger.error("Failed to read current PAM attenuator settings")
            return False
        if target_pow is not None:
            current_pow = pam.power(pam_pol)
            if current_pow is None:
                self.logger.error("Failed to read power")
                return False
            req_atten = current_pam_atten + int(current_pow - target_pow)
        elif target_rms is not None:
            _, _, current_rms = self.input.get_stats(sum_cores=True)
            current_rms = current_rms[chan]
            req_atten = current_pam_atten + int(20*np.log10(current_rms/target_rms))

        # saturate to allowed PAM attenuation levels
        if req_atten > 15:
            req_atten = 15
        if req_atten < 0:
            req_atten = 0
        return req_atten

