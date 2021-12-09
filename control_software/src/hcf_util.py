from __future__ import print_function
from hera_corr_f import HeraCorrelator
import csv
import numpy as np
from astropy.time import Time
import sys
import json


FQ0, FQ1 = 46.9, 234.3  # MHz - limits of auto spectra
NCHAN = 6144
POL_NAME_FROM_CHAR = {"e": "east", "n": "north"}


class LittleLogger:
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
        logger = LittleLogger()
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
    finally:  # I DON'T UNDERSTAND THIS -- THE EXCEPT ABOVE CATCHES EVERYTHING!
        try:
            # this call resets the fft overflow boolean.
            corr.fengs[host].pfb.rst_stats()
        except:  # noqa
            logger.info(
                "Error resetting fft overflow on snap {} ant {}. "
                "Full error output:".format(host, stream // 2),
                exc_info=True,
            )
    return fft_of


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
        logger = LittleLogger()
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


def get_autocorrelation(corr, host, stream, logger=None):
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
        logger = LittleLogger()
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


def get_adc_stats(corr, host, stream, bins, logger=None):
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
    bins : list
        bins to use
    logger : class or None
        logger to use if error

    Returns
    -------
    Dictionary of PAM statistics.
    """
    rv = {'x': {}, 'y': {}}
    if logger is None:
        logger = LittleLogger()
    bin_centers = (bins[1:] + bins[:1]) / 2

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
            hist, _ = np.histogram(rv[pol]['adc'], bins=bins)
            rv[pol]['histogram'] = [bin_centers.tolist(), hist.tolist()]
            rv[pol]['mean'] = rv[pol]['adc'].mean()
            rv[pol]['power'] = np.mean(rv[pol]['adc'] ** 2)
            rv[pol]['rms'] = np.sqrt(rv[pol]['power'])
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
        logger = LittleLogger()

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
        logger = LittleLogger()

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


def equalize_pams(cf=168.0, bw=8.0, retries=2, set_atten=True, target_pwr=75.0,
                  verbose=False):
    dchan = (FQ1 - FQ0) / NCHAN
    outfile = 'pam_settings_v004.csv'

    hc = HeraCorrelator()
    antpols = {}
    for ant, val in hc.ant_to_snap.items():
        for pol, hookup in val.items():
            if hookup['host'] in hc.fengs:
                antpols[ant, pol] = (hookup['host'], hookup['channel'])

    ch0 = np.around((cf-bw/2) / dchan).astype(int)
    ch1 = np.around((cf+bw/2) / dchan).astype(int)

    if verbose:
        print('Selecting CHs:', ch0, ch1)

    loaded_jd = np.frombuffer(hc.r_bytes.get('auto:timestamp'), np.float64)[0]
    cur_jd = Time.now().jd
    if verbose:
        print('Using autos loaded {} s ago'.format((cur_jd - loaded_jd) * 24 * 60 * 60))

    pam_settings = {}
    with open(outfile, 'w') as fp:
        csv_out = csv.writer(fp, delimiter=',')
        csv_out.writerow(['ANT', 'POL', 'SNAP', 'CH', 'OLD_ATTEN', 'NEW_ATTEN'])
        for (ant, pol), (snap, ch) in antpols.items():
            # pam_num = ch // 2
            try:
                cur_atten = hc.get_pam_attenuation(ant, pol)
            except IOError:
                cur_atten = -1
                new_atten = -1
            key = 'auto:%s%s' % (ant.encode('utf8'), pol.encode('utf8'))
            auto = hc.r_bytes.get(key)
            auto = np.frombuffer(auto, np.float32)
            pwr = np.median(auto[ch0:ch1])
            gain_dB = np.around(10*np.log10(target_pwr / pwr)).astype(int)
            if cur_atten != -1:
                new_atten = np.array(cur_atten - gain_dB).clip(0, 15)
            pam_settings[ant, pol] = (cur_atten, new_atten)
            csv_out.writerow([str(val) for val in (ant, pol, snap, ch, cur_atten, new_atten)])
            if verbose:
                print(ant, pol, cur_atten, new_atten, pwr)
            if set_atten and new_atten != cur_atten:
                for i in range(retries):
                    try:
                        hc.set_pam_attenuation(ant, pol, new_atten)
                    except (RuntimeError, IOError, AssertionError):
                        print('Failed, trying again', i, retries)
                        continue
                    break

    no_comms = [antpol for antpol, (cur, new) in pam_settings.items() if cur == -1]
    big = [antpol for antpol, (cur, new) in pam_settings.items() if np.abs(cur - new) >= 3]
    if verbose:
        print('No Communication')
        for ant, pol in no_comms:
            hookup = hc.ant_to_snap[ant][pol]
            print('   ', ant, pol, hookup['host'], hookup['channel'])
        print('Trouble Setting Attenuation?')
        for ant, pol in big:
            hookup = hc.ant_to_snap[ant][pol]
            print('   ', ant, pol, hookup['host'], hookup['channel'])
        print('Finished loading at', cur_jd)
