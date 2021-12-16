from __future__ import print_function
import sys
import json
from numpy import histogram, mean, sqrt, arange
from hera_corr_f import HeraCorrelator


POL_NAME_FROM_CHAR = {"e": "east", "n": "north"}
BINS = arange(-128, 128)


class Lager:
    """
    This spoofs the logger if None is supplied.
    """
    def __init__(self, strip='Full error output:'):
        self.strip = strip

    def info(self, msg, exc_info=None):
        print(msg.strip().strip(self.strip))


def validate_redis_dict(in_dict, recursion_depth=1):
    if recursion_depth == sys.getrecursionlimit():
        raise RuntimeError("Max Recursion reached during dictionary validation.")

    for redis_key in in_dict:
        # make a few explicit type conversions to coerce non-redis
        # compatible variables into redis.
        if isinstance(in_dict[redis_key], bool):
            # bools are compared using lambda x: x == "True" later
            in_dict[redis_key] = str(in_dict[redis_key])
        elif isinstance(in_dict[redis_key], list):
            # values that are appearing as lists as loaded
            # with json.loads in corr_cm
            in_dict[redis_key] = json.dumps(in_dict[redis_key])
        elif in_dict[redis_key] is None:
            # newer redis-py does not accept Nonetype, wrap in json.dumps
            in_dict[redis_key] = json.dumps(in_dict[redis_key])
        elif isinstance(in_dict[redis_key], dict):
            # just in case! who doesn't like recursion
            validate_redis_dict(in_dict[redis_key], recursion_depth=recursion_depth + 1)

    return in_dict


class SnapReporter(HeraCorrelator):
    def __init__(self, redishost='redishost',
                 redis_transport=True,
                 block_monitoring=False,
                 logger=None):
        super(SnapReporter, self).__init__(redishost=redishost,
                                           redis_transport=redis_transport,
                                           block_monitoring=block_monitoring)
        if logger is None:
            self.logger = Lager()
        else:
            self.logger = logger

    def print_ant_log_messages(self):
        for ant, antval in self.ant_to_snap.iteritems():
            for pol, polval in antval.iteritems():
                # Skip if the antenna is associated with a board we can't reach
                if polval['host'] is not None:
                    host = polval['host']
                    chan = polval['channel']
                    try:
                        _ = self.fengs[host]
                        self.logger.debug("Expecting data from Ant {}, Pol {} from host {} input {}"
                                          .format(ant, pol, host, chan))
                    except KeyError:
                        # If the entry is set to a bogus hostname I suppose.
                        self.logger.warning("Failed to find F-Eng {} associated with ant/pol {}/{}"
                                            .format(polval['host'], ant, pol))
                else:
                    self.logger.warning("Failed to find F-Eng {} associated with ant/pol {}/{}"
                                        .format(polval['host'], ant, pol))

    def get_fft_of(self, host, stream):
        """
        Get fft_off given hostname and stream.

        Parameters
        ----------
        host : str
            hostname of the snap
        stream : int
            lane number (stream) where the antenna is plugged into the ADC

        Returns
        -------
        Dictionary of fft_of.
        """
        try:
            fft_of = self.fengs[host].pfb.is_overflowing()
        except:  # noqa
            self.logger.info(
                "Error getting fft overflow on snap {} ant {}; "
                "Setting to None."
                "Full error output: ".format(host, stream // 2),
                exc_info=True,
            )
            fft_of = None
        finally:
            self.reset_fft_overflow(host)
        return fft_of

    def reset_fft_overflow(self, host):
        try:
            # this call resets the fft overflow boolean.
            self.fengs[host].pfb.rst_stats()
        except:  # noqa
            self.logger.info(
                "Error resetting fft overflow on snap {}. "
                "Full error output:".format(host),
                exc_info=True,
            )

    def get_eq_coeff(self, host, stream):
        """
        Get eq_coeff for the given hostname and stream.

        Parameters
        ----------
        host : str
            hostname of the snap
        stream : int
            lane number (stream) where the antenna is plugged into the ADC

        Returns
        -------
        Dictionary of eq_coeff.
        """
        try:
            eq_coeffs = self.fengs[host].eq.get_coeffs(stream)
            eq_coeffs = json.dumps(eq_coeffs.tolist())
        except:  # noqa
            self.logger.info(
                "Error getting equalization coefficients on snap {} ant {}; "
                "Setting to None. "
                "Full error output: ".format(host, stream // 2),
                exc_info=True,
            )
            eq_coeffs = None
        return eq_coeffs

    def get_auto(self, host, stream):
        """
        Get autocorrelation for the given hostname and stream.

        Parameters
        ----------
        host : str
            hostname of the snap
        stream : int
            lane number (stream) where the antenna is plugged into the ADC

        Returns
        -------
        Dictionary of autocorrelation.
        """
        try:
            autocorrelation = self.fengs[host].get_new_corr(stream, stream)
            autocorrelation = json.dumps(autocorrelation.real.tolist())
        except:  # noqa
            self.logger.info(
                "Error getting autocorrelation on snap {} ant {}; "
                "Setting to None. "
                "Full error output: ".format(host, stream // 2),
                exc_info=True,
            )
            autocorrelation = None
        return autocorrelation

    def get_adc_stats(self, host, stream):
        """
        Get PAM stats for the given hostname and stream.

        Parameters
        ----------
        host : str
            hostname of the snap
        stream : int
            lane number (stream) where the antenna is plugged into the ADC

        Returns
        -------
        Dictionary of PAM statistics.
        """
        rv = {'x': {}, 'y': {}}
        bin_centers = (BINS[1:] + BINS[:1]) / 2

        try:
            rv['x']['adc'], rv['y']['adc'] = self.fengs[host].input.get_adc_snapshot(stream // 2)
        except:  # noqa
            self.logger.info(
                "Connection issue on snap {} ant {}; "
                "Skipping adc data acquistion. "
                "Full error output:".format(host, stream // 2),
                exc_info=True,
            )
            rv['x']['adc'] = None
            rv['y']['adc'] = None

        for pol in ['x', 'y']:
            if rv[pol]['adc'] is not None:
                hist, _ = histogram(rv[pol]['adc'], bins=BINS)
                rv[pol]['histogram'] = [bin_centers.tolist(), hist.tolist()]
                rv[pol]['mean'] = rv[pol]['adc'].mean()
                rv[pol]['power'] = mean(rv[pol]['adc'] ** 2)
                rv[pol]['rms'] = sqrt(rv[pol]['power'])
            else:
                rv[pol]['histogram'] = [[None], [None]]
                rv[pol]['mean'] = None
                rv[pol]['power'] = None
                rv[pol]['rms'] = None
        return rv

    def get_pam_stats(self, host, stream, pol):
        """
        Get PAM stats for the given hostname and stream.

        Parameters
        ----------
        host : str
            hostname of the snap
        stream : int
            lane number (stream) where the antenna is plugged into the ADC
        pol : str
            polarization

        Returns
        -------
        Dictionary of PAM statistics.
        """
        rv = {}
        feng = self.fengs[host]
        pam = feng.pams[stream // 2]

        try:
            rv["pam_atten"] = pam.get_attenuation()[stream % 2]
        except:  # noqa
            self.logger.info(
                "Error getting PAM attenutation on snap {} ant {}; "
                "Setting to None. "
                "Full error output: ".format(host, stream // 2),
                exc_info=True,
            )
            rv["pam_atten"] = None

        try:
            rv["pam_power"] = pam.power(name=POL_NAME_FROM_CHAR[pol])
        except:  # noqa
            self.logger.info(
                "Error getting PAM Power on snap {} ant {}; "
                "Setting to None. "
                "Full error output: ".format(host, stream // 2),
                exc_info=True,
            )
            rv["pam_power"] = None

        try:
            rv["pam_voltage"] = pam.shunt("u")
        except:  # noqa
            self.logger.info(
                "Error getting PAM Voltage on snap {} ant {}; "
                "Setting to None. "
                "Full error output: ".format(host, stream // 2),
                exc_info=True,
            )
            rv["pam_voltage"] = None

        try:
            rv["pam_current"] = pam.shunt("i")
        except:  # noqa
            self.logger.info(
                "Error getting PAM Current on snap {} ant {}; "
                "Setting to None. "
                "Full error output: ".format(host, stream // 2),
                exc_info=True,
            )
            rv["pam_current"] = None

        try:
            rv["pam_id"] = pam.id()
        except:  # noqa
            self.logger.info(
                "Error getting PAM ID on snap {} ant {}; "
                "Setting to None. "
                "Full error output:".format(host, stream // 2),
                exc_info=True,
            )
            rv["pam_id"] = None
        return rv

    def get_fem_stats(self, host, stream):
        """
        Get FEM stats for the given hostname and stream.

        Parameters
        ----------
        host : str
            hostname of the snap
        stream : int
            lane number (stream) where the antenna is plugged into the ADC

        Returns
        -------
        Dictionary of FEM statistics.
        """
        rv = {}
        feng = self.fengs[host]
        fem = feng.fems[stream // 2]

        try:
            switch, east, north = fem.switch()
            rv["fem_switch"] = switch
            rv["fem_e_lna_power"] = east
            rv["fem_n_lna_power"] = north
        except:  # noqa
            self.logger.info(
                "Error getting FEM switch status on snap {} ant {}; "
                "Setting to None. "
                "Full error output:".format(host, stream // 2),
                exc_info=True,
            )
            rv["fem_switch"] = None
            rv["fem_e_lna_power"] = None
            rv["fem_n_lna_power"] = None

        try:
            rv["fem_temp"] = fem.temperature()
        except:  # noqa
            self.logger.info(
                "Error getting FEM temperature on snap {} ant {}; "
                "Setting to None. "
                "Full error output:".format(host, stream // 2),
                exc_info=True,
            )
            rv["fem_temp"] = None

        try:
            rv["fem_voltage"] = fem.shunt("u")
        except:  # noqa
            self.logger.info(
                "Error getting FEM voltage on snap {} ant {}; "
                "Setting to None. "
                "Full error output:".format(host, stream // 2),
                exc_info=True,
            )
            rv["fem_voltage"] = None

        try:
            rv["fem_current"] = fem.shunt("i")
        except:  # noqa
            self.logger.info(
                "Error getting FEM current on snap {} ant {}; "
                "Setting to None. "
                "Full error output:".format(host, stream // 2),
                exc_info=True,
            )
            rv["fem_current"] = None

        try:
            rv["fem_id"] = fem.id()
        except:  # noqa
            self.logger.info(
                "Error getting FEM ID on snap {} ant {}; "
                "Setting to None. "
                "Full error output:".format(host, stream // 2),
                exc_info=True,
            )
            rv["fem_id"] = None

        try:
            theta, phi = fem.imu()
            rv["fem_imu_theta"] = theta
            rv["fem_imu_phi"] = phi
        except:  # noqa
            self.logger.info(
                "Error getting FEM IMU information on snap {} ant {}; "
                "Setting to None. "
                "Full error output:".format(host, stream // 2),
                exc_info=True,
            )
            rv["fem_imu_theta"] = None
            rv["fem_imu_phi"] = None
        return rv
