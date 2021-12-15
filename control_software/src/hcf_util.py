from __future__ import print_function
import sys
import json
from numpy import histogram, mean, sqrt, arange


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


def get_fft_of(corr, host, stream, logger=None):
    """
    Get fft_off given hostname and stream.

    Parameters
    ----------
    corr : class
        correlator class
    host : str
        hostname of the snap
    stream : int
        lane number (stream) where the antenna is plugged into the ADC
    logger : class or None
        logger to use if error

    Returns
    -------
    Dictionary of fft_of.
    """
    if logger is None:
        logger = Lager()
    try:
        fft_of = corr.fengs[host].pfb.is_overflowing()
    except:  # noqa
        logger.info(
            "Error getting fft overflow on snap {} ant {}; "
            "Setting to None."
            "Full error output: ".format(host, stream // 2),
            exc_info=True,
        )
        fft_of = None
    finally:
        reset_fft_overflow(corr, host, logger)
    return fft_of


def reset_fft_overflow(corr, host, logger=None):
    if logger is None:
        logger = Lager()
    try:
        # this call resets the fft overflow boolean.
        corr.fengs[host].pfb.rst_stats()
    except:  # noqa
        logger.info(
            "Error resetting fft overflow on snap {}. "
            "Full error output:".format(host),
            exc_info=True,
        )


def get_eq_coeff(corr, host, stream, logger=None):
    """
    Get eq_coeff for the given hostname and stream.

    Parameters
    ----------
    corr : class
        correlator class
    host : str
        hostname of the snap
    stream : int
        lane number (stream) where the antenna is plugged into the ADC
    logger : class or None
        logger to use if error

    Returns
    -------
    Dictionary of eq_coeff.
    """
    if logger is None:
        logger = Lager()
    try:
        eq_coeffs = corr.fengs[host].eq.get_coeffs(stream)
        eq_coeffs = json.dumps(eq_coeffs.tolist())
    except:  # noqa
        logger.info(
            "Error getting equalization coefficients on snap {} ant {}; "
            "Setting to None. "
            "Full error output: ".format(host, stream // 2),
            exc_info=True,
        )
        eq_coeffs = None
    return eq_coeffs


def get_auto(corr, host, stream, logger=None):
    """
    Get autocorrelation for the given hostname and stream.

    Parameters
    ----------
    corr : class
        correlator class
    host : str
        hostname of the snap
    stream : int
        lane number (stream) where the antenna is plugged into the ADC
    logger : class or None
        logger to use if error

    Returns
    -------
    Dictionary of autocorrelation.
    """
    if logger is None:
        logger = Lager()
    try:
        autocorrelation = corr.fengs[host].corr.get_new_corr(stream, stream)
        autocorrelation = json.dumps(autocorrelation.real.tolist())
    except:  # noqa
        logger.info(
            "Error getting autocorrelation on snap {} ant {}; "
            "Setting to None. "
            "Full error output: ".format(host, stream // 2),
            exc_info=True,
        )
        autocorrelation = None
    return autocorrelation


def get_adc_stats(corr, host, stream, logger=None):
    """
    Get PAM stats for the given hostname and stream.

    Parameters
    ----------
    corr : class
        correlator class
    host : str
        hostname of the snap
    stream : int
        lane number (stream) where the antenna is plugged into the ADC
    logger : class or None
        logger to use if error

    Returns
    -------
    Dictionary of PAM statistics.
    """
    rv = {'x': {}, 'y': {}}
    if logger is None:
        logger = Lager()
    bin_centers = (BINS[1:] + BINS[:1]) / 2

    try:
        rv['x']['adc'], rv['y']['adc'] = corr.fengs[host].input.get_adc_snapshot(stream // 2)
    except:  # noqa
        logger.info(
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


def get_pam_stats(corr, host, stream, pol, logger=None):
    """
    Get PAM stats for the given hostname and stream.

    Parameters
    ----------
    corr : class
        correlator class
    host : str
        hostname of the snap
    stream : int
        lane number (stream) where the antenna is plugged into the ADC
    pol : str
        polarization
    logger : class or None
        logger to use if error

    Returns
    -------
    Dictionary of PAM statistics.
    """
    rv = {}
    feng = corr.fengs[host]
    pam = feng.pams[stream // 2]
    if logger is None:
        logger = Lager()

    try:
        rv["pam_atten"] = pam.get_attenuation()[stream % 2]
    except:  # noqa
        logger.info(
            "Error getting PAM attenutation on snap {} ant {}; "
            "Setting to None. "
            "Full error output: ".format(host, stream // 2),
            exc_info=True,
        )
        rv["pam_atten"] = None

    try:
        rv["pam_power"] = pam.power(name=POL_NAME_FROM_CHAR[pol])
    except:  # noqa
        logger.info(
            "Error getting PAM Power on snap {} ant {}; "
            "Setting to None. "
            "Full error output: ".format(host, stream // 2),
            exc_info=True,
        )
        rv["pam_power"] = None

    try:
        rv["pam_voltage"] = pam.shunt("u")
    except:  # noqa
        logger.info(
            "Error getting PAM Voltage on snap {} ant {}; "
            "Setting to None. "
            "Full error output: ".format(host, stream // 2),
            exc_info=True,
        )
        rv["pam_voltage"] = None

    try:
        rv["pam_current"] = pam.shunt("i")
    except:  # noqa
        logger.info(
            "Error getting PAM Current on snap {} ant {}; "
            "Setting to None. "
            "Full error output: ".format(host, stream // 2),
            exc_info=True,
        )
        rv["pam_current"] = None

    try:
        rv["pam_id"] = pam.id()
    except:  # noqa
        logger.info(
            "Error getting PAM ID on snap {} ant {}; "
            "Setting to None. "
            "Full error output:".format(host, stream // 2),
            exc_info=True,
        )
        rv["pam_id"] = None
    return rv


def get_fem_stats(corr, host, stream, logger=None):
    """
    Get FEM stats for the given hostname and stream.

    Parameters
    ----------
    corr : class
        correlator class
    host : str
        hostname of the snap
    stream : int
        lane number (stream) where the antenna is plugged into the ADC
    logger : class or None
        logger to use if error

    Returns
    -------
    Dictionary of FEM statistics.
    """
    rv = {}
    feng = corr.fengs[host]
    fem = feng.fems[stream // 2]
    if logger is None:
        logger = Lager()

    try:
        switch, east, north = fem.switch()
        rv["fem_switch"] = switch
        rv["fem_e_lna_power"] = east
        rv["fem_n_lna_power"] = north
    except:  # noqa
        logger.info(
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
        logger.info(
            "Error getting FEM temperature on snap {} ant {}; "
            "Setting to None. "
            "Full error output:".format(host, stream // 2),
            exc_info=True,
        )
        rv["fem_temp"] = None

    try:
        rv["fem_voltage"] = fem.shunt("u")
    except:  # noqa
        logger.info(
            "Error getting FEM voltage on snap {} ant {}; "
            "Setting to None. "
            "Full error output:".format(host, stream // 2),
            exc_info=True,
        )
        rv["fem_voltage"] = None

    try:
        rv["fem_current"] = fem.shunt("i")
    except:  # noqa
        logger.info(
            "Error getting FEM current on snap {} ant {}; "
            "Setting to None. "
            "Full error output:".format(host, stream // 2),
            exc_info=True,
        )
        rv["fem_current"] = None

    try:
        rv["fem_id"] = fem.id()
    except:  # noqa
        logger.info(
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
        logger.info(
            "Error getting FEM IMU information on snap {} ant {}; "
            "Setting to None. "
            "Full error output:".format(host, stream // 2),
            exc_info=True,
        )
        rv["fem_imu_theta"] = None
        rv["fem_imu_phi"] = None
    return rv


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
