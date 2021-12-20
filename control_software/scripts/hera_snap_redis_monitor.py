#! /usr/bin/env python
'''
Sets redis hash keys:
    status:snap:<host>
    status:snaprf:<host>:<stream 0-5>
    status:ant:<antnum>:<pol>
Also resets PFB overflow flag after reading.
'''

from __future__ import print_function
import time
import socket
import logging
import argparse
import json
from os import path as op
from datetime import datetime

from hera_corr_f import HeraCorrelator, __version__, __package__
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
    parser.add_argument('-D', dest='retrytime', type=float, default=300.0,
                        help='Seconds between reconnection attempts to dead boards')
    parser.add_argument('-l', dest='loglevel', type=str, default="INFO",
                        help='Log level. DEBUG / INFO / WARNING / ERROR')
    parser.add_argument('--verbose', help='Make more verbose.', action='store_true')
    args = parser.parse_args()

    if args.loglevel not in ["DEBUG", "INFO", "WARNING", "ERROR"]:
        logger.error("I don't undestand log level %s" % args.loglevel)
    else:
        for handler in logger.handlers:
            handler.setLevel(getattr(logging, args.loglevel))

    corr = HeraCorrelator(redishost=args.redishost, block_monitoring=False)
    upload_time = corr.r.hget('snap_configuration', 'upload_time')
    if args.verbose:
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
            corr = HeraCorrelator(redishost=args.redishost, block_monitoring=False)
            if args.verbose:
                corr.print_ant_log_messages()

        # Recompute the hookup every time. It's fast
        # corr._hookup_from_redis()

        # load this module's version into redis
        corr.r.hmset(
            "version:{:s}:{:s}".format(__package__, op.basename(__file__)),
            {"version": __version__, "timestamp": datetime.now().isoformat()}
        )

        if corr.r.exists("disable_monitoring"):
            continue
        # Put full set into redis status:snap:<host>
        corr.set_redis_status_fengs()

        # Copy values over to status:snaprf:<host> and status:ant:<ant>:<pol>
        for host in corr.fengs:
            feng = corr.r.hgetall("status:snap:{}".format(host))
            fft_overflow = corr.r.hget("status:snap:{}".format(host), "fft_overflow")
            clip_count = corr.r.hget("status:snap:{}".format(host), "eq_clip_count")
            for stream, antpol in enumerate(json.loads(feng['antpols'])):  #May not work!!!
                snap_rf_stats = {}
                snap_rf_stats["timestamp"] = datetime.now().isoformat()
                snap_rf_stats["autocorrelation"] = feng['stream{}_autocorr'.format(stream)]
                snap_rf_stats["eq_coeffs"] = feng['stream{}_eq_coeffs'.format(stream)]
                snap_rf_stats["fft_of"] = fft_overflow
                snap_rf_stats["clip_count"] = clip_count
                snap_rf_stats["histogram"] = feng['stream{}_hist'.format(stream)]
                snaprf_status_redis_key = "status:snaprf:{}:{}".format(host, stream)
                corr.r.hmset(snaprf_status_redis_key, snap_rf_stats)

                ant_status = {}
                ant_status['f_host'] = host
                ant_status['host_ant_id'] = stream
                for val in ['timestamp', 'autocorrelation', 'eq_coeffs', 'fft_of', 'histogram']:
                    ant_status[val] = snap_rf_stats[val]
                for val in ['adc_mean', 'adc_power', 'adc_rms', 'histogram']:
                    ant_status[val] = adc_stats[this_pol][val.split('_')[-1]]
                ant_status.update(corr.get_pam_stats(host, stream, pol))
                ant_status.update(corr.get_fem_stats(host, stream))
                ant_status_redis_key = "status:ant:{:d}:{:s}".format(ant, pol)
                corr.r.hmset(ant_status_redis_key, ant_status)

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
