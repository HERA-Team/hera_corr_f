#! /usr/bin/env python
from __future__ import print_function
import time
import socket
import logging
import argparse
from os import path as op
from datetime import datetime
from numpy import arange

from hera_corr_f import HeraCorrelator, __version__, __package__
from hera_corr_f import hcf_util as hcfu
from hera_corr_cm.handlers import add_default_log_handlers

logger = add_default_log_handlers(logging.getLogger(__file__))
hostname = socket.gethostname()


def print_ant_log_messages(corr):
    for ant, antval in corr.ant_to_snap.iteritems():
        for pol, polval in antval.iteritems():
            # Skip if the antenna is associated with a board we can't reach
            if polval['host'] is not None:
                host = polval['host']
                chan = polval['channel']
                try:
                    _ = corr.fengs[host]
                    logger.debug("Expecting data from Ant {}, Pol {} from host {} input {}"
                                 .format(ant, pol, host, chan))
                except KeyError:
                    # If the entry is set to a bogus hostname I suppose.
                    logger.warning("Failed to find F-Engine {} associated with ant/pol {}/{}"
                                   .format(polval['host'], ant, pol))
            else:
                logger.warning("Failed to find F-Engine {} associated with ant/pol {}/{}"
                               .format(polval['host'], ant, pol))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Polling SNAPs for FPGA/PAM/FEM monitoring data',
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

    corr = HeraCorrelator(redishost=args.redishost, redis_transport=(not args.noredistapcp),
                          block_monitoring=False)
    upload_time = corr.r.hget('snap_configuration', 'upload_time')
    print_ant_log_messages(corr)

    retry_tick = time.time()
    script_redis_key = "status:script:{:s}:{:s}".format(hostname, __file__)
    locked_out = False
    logger.info('Starting SNAP redis monitor')
    bins = arange(-128, 128)
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
            corr = HeraCorrelator(redishost=args.redishost, use_redis=(not args.noredistapcp),
                                  block_monitoring=False)
            print_ant_log_messages(corr)

        # Recompute the hookup every time. It's fast
        corr._hookup_from_redis()

        # load this module's version into redis
        corr.r.hmset(
            "version:{:s}:{:s}".format(__package__, op.basename(__file__)),
            {"version": __version__, "timestamp": datetime.now().isoformat()}
        )

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
                    adc_stats = hcfu.get_adc_stats(corr, host, stream, bins, logger)
                    this_pol = 'x'
                else:
                    this_pol = 'y'
                autocorrelation = hcfu.get_autocorrelation(corr, host, stream, logger)
                eq_coeffs = hcfu.get_eq_coeff(corr, host, stream, logger)
                fft_of = hcfu.get_fft_of(corr, host, stream, logger)

                # LEAVING IN BECAUSE I DON'T UNDERSTAND THE FINALLY!!!
                # try:
                #     fft_of = corr.fengs[host].pfb.is_overflowing()
                # except:  # noqa
                #     logger.info(
                #         "Error getting fft overflow on snap {} ant {}; "
                #         "Setting to None."
                #         "Full error output:".format(host, stream // 2),
                #         exc_info=True,
                #     )
                #     fft_of = None
                # finally:
                #     try:
                #         # this call resets the fft overflow boolean.
                #         corr.fengs[host].pfb.rst_stats()
                #     except:  # noqa
                #         logger.info(
                #             "Error resetting fft overflow on snap {} ant {}. "
                #             "Full error output:".format(host, stream // 2),
                #             exc_info=True,
                #         )
                timestamp = datetime.now().isoformat()

                snaprf_status_redis_key = "status:snaprf:{:s}:{:d}".format(host, stream)
                snap_rf_stats = {}

                snap_rf_stats["histogram"] = adc_stats[this_pol]['histogram']
                snap_rf_stats["autocorrelation"] = autocorrelation
                snap_rf_stats["eq_coeffs"] = eq_coeffs
                snap_rf_stats["fft_of"] = fft_of
                snap_rf_stats["timestamp"] = timestamp

                snap_rf_stats = hcfu.validate_redis_dict(snap_rf_stats)
                corr.r.hmset(snaprf_status_redis_key, snap_rf_stats)

                # lookup if this is known to cm
                ant, pol = antpols[stream]
                if ant is None or pol is None:
                    # this snap has no listed antenna on this stream.
                    # do not try to make an antenna status and move to the
                    # next stream.
                    continue
                ant_status_redis_key = "status:ant:{:d}:{:s}".format(ant, pol)

                ant_status = {}
                ant_status["adc_mean"] = adc_stats[this_pol]['mean']
                ant_status["adc_power"] = adc_stats[this_pol]['power']
                ant_status["adc_rms"] = adc_stats[this_pol]['rms']
                ant_status['f_host'] = host
                ant_status['host_ant_id'] = stream
                ant_status['histogram'] = adc_stats[this_pol]['histogram']
                ant_status["autocorrelation"] = autocorrelation
                ant_status["eq_coeffs"] = eq_coeffs
                ant_status.update(hcfu.get_pam_stats(corr, host, stream, pol, logger))
                ant_status.update(hcfu.get_fem_stats(corr, host, stream, logger))
                ant_status["fft_of"] = fft_of
                ant_status['timestamp'] = timestamp

                ant_status = hcfu.validate_redis_dict(ant_status)
                corr.r.hmset(ant_status_redis_key, ant_status)

            # all the data throughput from the adc call can cause network issues
            # a small sleep can help
            # 02/24/2021 MJK: is this sleep still necessary, we're not slamming
            # all the fengs one after another anymore
            time.sleep(0.1)

        # If the retry period has been exceeded, try to reconnect to dead boards:
        if time.time() > (retry_tick + args.retrytime):
            if len(corr._unconnected) > 0:
                logger.debug('Trying to reconnect to unreachable boards')
                corr._unconnected = corr.connect_fengs(hosts=corr._unconnected)
                retry_tick = time.time()

        # If executing the loop hasn't already taken longer than the loop delay time add extra wait.
        extra_delay = args.delay - (time.time() - tick)
        if extra_delay > 0:
            logger.debug("Sleeping for {:.2f} seconds".format(extra_delay))
            time.sleep(extra_delay)
