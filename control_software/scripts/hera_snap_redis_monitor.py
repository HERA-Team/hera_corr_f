#! /usr/bin/env python
"""
Sets redis key status:snap:<host> from HeraCorrelator - also resets PFB overflow flag after reading.
"""
from __future__ import print_function
import time
import socket
import logging
import argparse
from os import path as op
from datetime import datetime

from hera_corr_f import HeraCorrelator, __version__, __package__
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
            corr.set_redis_status_fengs()
        except Exception as e:
            logger.warning(str(e))

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
