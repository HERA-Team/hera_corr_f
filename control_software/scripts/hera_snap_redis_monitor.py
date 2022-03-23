#! /usr/bin/env python
"""
Sets redis hash keys:
    status:snap:<host>                    Done from HeraCorrelator, but adds antpol
    status:snaprf:<host>:<stream 0-5>     Duplicated data taken from redis
    status:ant:<antnum>:<pol>             Duplicated data taken from redis
Also resets PFB overflow flag after reading.
"""
from __future__ import print_function
import time
import socket
import logging
import argparse
from os import path as op
from datetime import datetime
# WON'T NEED WITH CHANGE IN HERA_MC
# from redis import exceptions as RedisException

from hera_corr_f import HeraCorrelator, __version__, __package__
from hera_corr_cm.handlers import add_default_log_handlers

logger = add_default_log_handlers(logging.getLogger(__file__))
hostname = socket.gethostname()

# WON'T NEED THIS WITH CHANGE IN HERA_MC
# Values to write to redis - status:snaprf:<host>:<stream>
# snaprf_mon = {'autocorrelation': 'stream${STREAMNUM}_autocorr',
#               'eq_coeffs': 'stream${STREAMNUM}_eq_coeffs',
#               'histogram': 'stream${STREAMNUM}_hist',
#               'adc_mean': 'stream${STREAMNUM}_mean',
#               'adc_power': 'stream${STREAMNUM}_power',
#               'adc_rms': 'stream${STREAMNUM}_rms'}
# antpol_mon = {  # These are in addition to snaprf_mon items above - status:ant:<ant>:<pol>
#               'pam_power': 'pam${DEVNUM}_power_${POL}',
#               'pam_atten': 'pam${DEVNUM}_atten_${POL}',
#               'pam_current': 'pam${DEVNUM}_current',
#               'pam_voltage': 'pam${DEVNUM}_voltage',
#               'pam_id': 'pam${DEVNUM}_id',
#               'fem_lna_power': 'fem${DEVNUM}_lna_power_${POL}',
#               'fem_current': 'fem${DEVNUM}_current',
#               'fem_voltage': 'fem${DEVNUM}_voltage',
#               'fem_switch': 'fem${DEVNUM}_switch',
#               'fem_humidity': 'fem${DEVNUM}_humidity',
#               'fem_temp': 'fem${DEVNUM}_temp',
#               'fem_id': 'fem${DEVNUM}_id',
#               'fem_imu_phi': 'fem${DEVNUM}_imu_phi',
#               'fem_imu_theta': 'fem${DEVNUM}_imu_theta',
#               'fem_pressure': 'fem${DEVNUM}_pressure'
#               }  # entries without ${POL} are duplicated over both pol
# stream2pol = {0: 'e', 1: 'n'}


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
                    logger.warning("Failed to find F-Eng {} associated with ant/pol {}/{}"
                                   .format(polval['host'], ant, pol))
            else:
                logger.warning("Failed to find F-Eng {} associated with ant/pol {}/{}"
                               .format(polval['host'], ant, pol))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Polling SNAPs for FPGA/PAM/FEM monitoring data',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--hosts', type=str, default=None,
                        help='Hosts to monitor (None uses all).')
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
        logger.error("I don't understand log level %s" % args.loglevel)
    else:
        for handler in logger.handlers:
            handler.setLevel(getattr(logging, args.loglevel))

    if args.hosts is not None:
        args.hosts = args.hosts.split(',')

    corr = HeraCorrelator(hosts=args.hosts, redishost=args.redishost, block_monitoring=False)
    upload_time = corr.r.hget('snap_configuration', 'upload_time')
    if args.verbose:
        print_ant_log_messages(corr)

    retry_tick = time.time()
    script_redis_key = "status:script:{:s}:{:s}".format(hostname, __file__)
    locked_out = False
    logger.info('Starting SNAP redis monitor')

    counter = 0
    while(True):
        tick = time.time()
        counter += 1
        if args.verbose:
            print("Tick {}:  {}".format(counter, datetime.now().isoformat()))
        corr.r.set(script_redis_key, "alive", ex=max(60, args.delay * 2))
        while corr.r.exists('disable_monitoring'):
            if not locked_out:
                logger.warning('Monitoring locked out by {}. Retrying every 10 seconds'
                               .format(corr.r.get('disable_monitoring')))
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
                print_ant_log_messages(corr)

        # Recompute the hookup every time. It's fast
        corr._hookup_from_redis()

        # load this module's version into redis
        corr.r.hmset(
            "version:{:s}:{:s}".format(__package__, op.basename(__file__)),
            {"version": __version__, "timestamp": datetime.now().isoformat()}
        )

        # Put full set into redis status:snap:<host>
        try:
            corr.set_redis_status_fengs(args.hosts)
        except Exception as e:
            logger.warning(str(e))

        # WON'T NEED OF THE BELOW WITH CHANGE IN HERA_MC
        # Copy values over to status:snaprf:<host>:<stream> and status:ant:<ant>:<pol>
        # for host in corr.fengs:
        #     sskey = "status:snap:{}".format(host)
        #     feng = corr.r_bytes.hgetall(sskey)
        #     fft_overflow = corr.r.hget(sskey, "fft_overflow")
        #     clip_count = corr.r.hget(sskey, "eq_clip_count")
        #     antpols = corr.snap_to_ant[host]
        #     for stream, (ant, pol) in enumerate(antpols):
        #         if ant is None:  # no antenna there
        #             continue
        #
        #         # Update status:snaprf:<host>:<stream>
        #         snap_rf_stats = {}
        #         snap_rf_stats["timestamp"] = feng['timestamp']
        #         snap_rf_stats["fft_of"] = fft_overflow
        #         snap_rf_stats["clip_count"] = clip_count
        #         for key, val in snaprf_mon.items():
        #             hval = val.replace("${STREAMNUM}", str(stream))
        #             try:
        #                 snap_rf_stats[key] = feng[hval]
        #             except KeyError:
        #                 if args.verbose:
        #                     logger.info("snap_rf:  No key {} in host {}".format(hval, host))
        #                 pass
        #         snaprf_status_redis_key = "status:snaprf:{}:{}".format(host, stream)
        #         try:
        #             corr.r.hmset(snaprf_status_redis_key, snap_rf_stats)
        #         except RedisException.DataError as msg:
        #             logger.warning(str(msg))
        #
        #         # Update status:ant:<ant>:<pol>
        #         ant_status = {}
        #         ant_status['f_host'] = host
        #         ant_status['host_ant_id'] = stream
        #         ant_status.update(snap_rf_stats)
        #         devnum = stream // 2
        #         pol = stream2pol[stream % 2]
        #         for key, val in antpol_mon.items():
        #             hval = val.replace("${DEVNUM}", str(devnum)).replace("${POL}", pol)
        #             try:
        #                 ant_status[key] = feng[hval]
        #             except KeyError:
        #                 if args.verbose:
        #                     logger.info("ant_status: No key {} in host {}".format(hval, host))
        #                 pass
        #         ant_status_redis_key = "status:ant:{:d}:{:s}".format(ant, pol)
        #         try:
        #             corr.r.hmset(ant_status_redis_key, ant_status)
        #         except RedisException.DataError as msg:
        #             logger.warning(str(msg))
        #
        #     time.sleep(0.1)

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
