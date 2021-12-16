#! /usr/bin/env python
from __future__ import print_function
import time
import socket
import logging
import argparse
from os import path as op
from datetime import datetime

from hera_corr_f import __version__, __package__
from hera_corr_f import hcf_snap_reporter
from hera_corr_cm.handlers import add_default_log_handlers

logger = add_default_log_handlers(logging.getLogger(__file__))
hostname = socket.gethostname()


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

    corr = hcf_snap_reporter.SnapReporter(redishost=args.redishost,
                                          redis_transport=(not args.noredistapcp),
                                          block_monitoring=False,
                                          logger=logger)
    upload_time = corr.r.hget('snap_configuration', 'upload_time')
    corr.print_ant_log_messages()

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
            corr = hcf_snap_reporter.SnapReporter(redishost=args.redishost,
                                                  redis_transport=(not args.noredistapcp),
                                                  block_monitoring=False,
                                                  logger=logger)
            corr.print_ant_log_messages()

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
                    # adc_stats returns both polarizations, so only read every other
                    adc_stats = corr.get_adc_stats(host, stream)
                    this_pol = 'x'
                else:
                    this_pol = 'y'

                # Build snap_rf_stats and add to redis
                snap_rf_stats = {}
                snap_rf_stats["timestamp"] = datetime.now().isoformat()
                snap_rf_stats["autocorrelation"] = corr.get_auto(host, stream)
                snap_rf_stats["eq_coeffs"] = corr.get_eq_coeff(host, stream)
                snap_rf_stats["fft_of"] = corr.get_fft_of(host, stream)
                snap_rf_stats["histogram"] = adc_stats[this_pol]['histogram']
                snap_rf_stats = hcf_snap_reporter.validate_redis_dict(snap_rf_stats)

                snaprf_status_redis_key = "status:snaprf:{}:{}".format(host, stream)
                corr.r.hmset(snaprf_status_redis_key, snap_rf_stats)

                # lookup if this is known to cm, if not no antenna is listed so skip
                ant, pol = antpols[stream]
                if ant is None or pol is None:
                    continue

                # Build ant_status and add to redis.
                ant_status = {}
                ant_status['f_host'] = host
                ant_status['host_ant_id'] = stream
                for val in ['timestamp', 'autocorrelation', 'eq_coeffs', 'fft_of', 'histogram']:
                    ant_status[val] = snap_rf_stats[val]
                for val in ['adc_mean', 'adc_power', 'adc_rms', 'histogram']:
                    ant_status[val] = adc_stats[this_pol][val.split('_')[-1]]
                ant_status.update(corr.get_pam_stats(host, stream, pol))
                ant_status.update(corr.get_fem_stats(host, stream))
                ant_status = hcf_snap_reporter.validate_redis_dict(ant_status)
                ant_status_redis_key = "status:ant:{:d}:{:s}".format(ant, pol)
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
