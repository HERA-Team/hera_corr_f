#! /usr/bin/env python

import os
import sys
import json
import time
import socket
import logging
import argparse
import datetime
import numpy as np

from hera_corr_f import HeraCorrelator, __version__, __package__
from hera_corr_cm.handlers import add_default_log_handlers

logger = add_default_log_handlers(logging.getLogger(__file__))

hostname = socket.gethostname()

pol_name_from_char = {"e": "east", "n": "north"}


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


def get_pam_stats(corr, host, stream):
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
    rv = {}
    feng = corr.fengs[host]
    pam = feng.pams[stream // 2]

    try:
        rv["pam_atten"] = pam.get_attenuation()[stream % 2]
    except:  # noqa
        logger.info(
            "Error getting PAM attenuation on snap {} ant {}; "
            "Setting to None. "
            "Full error output:".format(host, stream // 2),
            exc_info=True,
        )
        rv["pam_atten"] = None

    try:
        rv["pam_power"] = pam.power(name=pol_name_from_char[pol])
    except:  # noqa
        logger.info(
            "Error getting PAM Power on snap {} ant {}; "
            "Setting to None. "
            "Full error output:".format(host, stream // 2),
            exc_info=True,
        )
        rv["pam_power"] = None

    try:
        rv["pam_voltage"] = pam.shunt("u")
    except:  # noqa
        logger.info(
            "Error getting PAM Voltage on snap {} ant {}; "
            "Setting to None. "
            "Full error output:".format(host, stream // 2),
            exc_info=True,
        )
        rv["pam_voltage"] = None

    try:
        rv["pam_current"] = pam.shunt("i")
    except:  # noqa
        logger.info(
            "Error getting PAM Current on snap {} ant {}; "
            "Setting to None. "
            "Full error output:".format(host, stream // 2),
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


def get_fem_stats(corr, host, stream):
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
    feng = corr.fengs[host]
    fem = feng.fems[stream // 2]
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


def print_ant_log_messages(corr):
    for ant, antval in corr.ant_to_snap.iteritems():
        for pol, polval in antval.iteritems():
            # Skip if the antenna is associated with a board we can't reach
            if polval['host'] is not None:
                host = polval['host']
                chan = polval['channel']
                try:
                    _ = corr.fengs[host]
                    logger.debug("Expecting data from Ant %s, Pol %s from host %s input %d" % (ant, pol, host, chan))
                except KeyError:
                    # If the entry is set to a bogus hostname I suppose.
                    logger.warning("Failed to find F-Engine %s associated with ant/pol %s/%s" % (polval['host'], ant, pol))

            else:
                logger.warning("Failed to find F-Engine %s associated with ant/pol %s/%s" % (polval['host'], ant, pol))


if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='Poll running SNAPs for FPGA/PAM/FEM monitoring data',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                        help='Host servicing redis requests')
    parser.add_argument('-d', dest='delay', type=float, default=10.0,
                        help='Seconds between polling loops')
    parser.add_argument('-c', dest='poco', action='store_true', default=False,
                        help='Upload pocket correlator output to redis')
    parser.add_argument('-D', dest='retrytime', type=float, default=300.0,
                        help='Seconds between reconnection attempts to dead boards')
    parser.add_argument('-l', dest='loglevel', type=str, default="INFO",
                        help='Log level. DEBUG / INFO / WARNING / ERROR')
    parser.add_argument('--noredistapcp', action='store_true',
                        help='Don\'t use the redis-based SNAP comms protocol')
    args = parser.parse_args()

    if args.loglevel not in ["DEBUG", "INFO", "WARNING", "ERROR"]:
        logger.error("I don't undestand log level %s" % args.loglevel)
    else:
        for handler in logger.handlers:
            handler.setLevel(getattr(logging, args.loglevel))

    corr = HeraCorrelator(redishost=args.redishost, use_redis=(not args.noredistapcp), block_monitoring=False)
    upload_time = corr.r.hget('snap_configuration', 'upload_time')
    print_ant_log_messages(corr)

    retry_tick = time.time()
    script_redis_key = "status:script:{:s}:{:s}".format(hostname, __file__)
    locked_out = False
    logger.info('Starting SNAP redis monitor')
    while(True):
        tick = time.time()
        corr.r.set(script_redis_key, "alive", ex=max(60, args.delay * 2))
        while corr.r.exists('disable_monitoring'):
            if not locked_out:
                logger.warning('Monitoring locked out. Retrying every 10 seconds')
                locked_out = True
            corr.r.set(script_redis_key, "locked out", ex=20)
            time.sleep(10)
        if locked_out:
            logger.warning('Monitoring unlocked')
            locked_out = False

        # Check for a new configuration, and if one exists, update the Fengine list
        if corr.r.hget('snap_configuration', 'upload_time') != upload_time:
            upload_time = corr.r.hget('snap_configuration', 'upload_time')
            logger.info('New configuration detected. Reinitializing fengine list')
            corr = HeraCorrelator(redishost=args.redishost, use_redis=(not args.noredistapcp), block_monitoring=False)
            print_ant_log_messages(corr)

        # Recompute the hookup every time. It's fast
        corr._hookup_from_redis()

        # load this module's version into redis
        corr.r.hmset(
            "version:{:s}:{:s}".format(__package__, os.path.basename(__file__)),
            {"version": __version__, "timestamp": datetime.datetime.now().isoformat()}
        )

        bins = np.arange(-128, 128)
        bin_centers = (bins[1:] + bins[:1]) / 2
        adc_x = None
        adc_y = None
        adc_val = None
        for host in corr.fengs:
            if corr.r.exists("disable_monitoring"):
                continue

            fpga_stats = corr.fengs[host].get_fpga_stats()
            corr.r.hmset("status:snap:{:s}".format(host), fpga_stats)

            antpols = corr.snap_to_ant[host]
            # there are 6 antpols possibly attached to each feng
            for stream in range(6):
                if corr.r.exists("disable_monitoring"):
                    continue

                if stream % 2 == 0:
                    # every other antplot we need to get a new ADC snapshot
                    # because we will be on a new antenna
                    # we could do this for every stream but the function
                    # returns both polarization and we don't need to overload
                    # the network

                    # 25 AUG 2020
                    # recent bitfile change has removed some blocks on the snap.
                    # must use adc snapshot now and build statistics in software instead.
                    try:
                        adc_x, adc_y = corr.fengs[host].input.get_adc_snapshot(stream // 2)
                    except:  # noqa
                        logger.info(
                            "Connection issue on snap {} ant {}; "
                            "Skipping adc data acquistion. "
                            "Full error output:".format(host, stream // 2),
                            exc_info=True,
                        )
                        adc_x = None
                        adc_y = None
                    adc_val = adc_x
                else:
                    adc_val = adc_y

                if adc_val is not None:
                    hist, _ = np.histogram(adc_val, bins=bins)
                    hist = [bin_centers.tolist(), hist.tolist()]
                    adc_mean = adc_val.mean()
                    adc_power = np.mean(adc_val ** 2)
                    adc_rms = np.sqrt(adc_power)
                else:
                    histogram = [[None], [None]]
                    adc_mean = None
                    adc_power = None
                    adc_rms = None

                try:
                    autocorrelation = corr.fengs[host].get_new_corr(stream, stream)
                    autocorrelation = json.dumps(autocorrelation.real.tolist())
                except:  # noqa
                    logger.info(
                        "Error getting autocorrelation on snap {} ant {}; "
                        "Setting to None. "
                        "Full error output:".format(host, stream // 2),
                        exc_info=True,
                    )
                    autocorrelation = None

                try:
                    eq_coeffs = corr.fengs[host].eq.get_coeffs(stream)
                    eq_coeffs = json.dumps(eq_coeffs.tolist())
                except:  # noqa
                    logger.info(
                        "Error getting equalization coefficietns on snap {} ant {}; "
                        "Setting to None. "
                        "Full error output:".format(host, stream // 2),
                        exc_info=True,
                    )
                    eq_coeffs = None

                try:
                    fft_of = corr.fengs[host].pfb.is_overflowing()
                except:  # noqa
                    logger.info(
                        "Error getting fft overflow on snap {} ant {}; "
                        "Setting to None."
                        "Full error output:".format(host, stream // 2),
                        exc_info=True,
                    )
                    fft_of = None
                finally:
                    try:
                        # this call resets the fft overflow boolean.
                        corr.fengs[host].pfb.rst_stats()
                    except:  # noqa
                        logger.info(
                            "Error resetting fft overflow on snap {} ant {}. "
                            "Full error output:".format(host, stream // 2),
                            exc_info=True,
                        )

                timestamp = datetime.datetime.now().isoformat()

                snaprf_status_redis_key = "status:snaprf:{:s}:{:d}".format(host, stream)
                snap_rf_stats = {}

                snap_rf_stats["histogram"] = histogram
                snap_rf_stats["autocorrelation"] = autocorrelation
                snap_rf_stats["eq_coeffs"] = eq_coeffs
                snap_rf_stats["fft_of"] = fft_of
                snap_rf_stats["timestamp"] = timestamp

                snap_rf_stats = validate_redis_dict(snap_rf_stats)
                corr.r.hmset(snaprf_status_redis_key, snap_rf_stats)

                # lookup if this is known to cm
                ant, pol = antpols[stream]
                if ant is None or pol is None:
                    # this snap has no listed antenna on this stream.
                    # do not try to make an antenna status and move to the
                    # next stream.
                    continue

                ant_status_redis_key = "status:ant:{:s}:{:s}".format(ant, pol)

                ant_status = {}

                ant_status["adc_mean"] = adc_mean
                ant_status["adc_power"] = adc_power
                ant_status["adc_rms"] = adc_rms
                ant_status['f_host'] = host
                ant_status['host_ant_id'] = stream
                ant_status['histogram'] = histogram
                ant_status["autocorrelation"] = autocorrelation
                ant_status["eq_coeffs"] = eq_coeffs

                ant_status.update(get_pam_stats(corr, host, stream))
                ant_status.update(get_fem_stats(corr, host, stream))

                ant_status["fft_of"] = fft_of

                ant_status['timestamp'] = timestamp

                ant_status = validate_redis_dict(ant_status)
                corr.r.hmset(ant_status_redis_key, ant_status)

            # all the data throughput from the adc call can cause network issues
            # a small sleep can help
            # 02/24/2021 MJK: is this sleep still necessary, we're not slamming
            # all the fengs one after another anymore
            time.sleep(0.1)

        # If executing the loop hasn't already taken longer than the loop delay time, add extra wait.
        extra_delay = args.delay - (time.time() - tick)
        if extra_delay > 0:
            logger.debug("Sleeping for {:.2f} seconds".format(extra_delay))
            time.sleep(extra_delay)
