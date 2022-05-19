#! /usr/bin/env python
"""
Sets redis key status:snap:<host> from HeraCorrelator - also resets PFB overflow flag after reading.
"""
from __future__ import print_function
import time
import socket
import logging
import redis
import argparse
from os import path as op
import sys
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
    parser.add_argument('-l', dest='loglevel', type=str, default="INFO",
                        help='Log level. DEBUG / INFO / WARNING / ERROR',
                        choices=['DEBUG', 'INFO', 'WARNING', 'ERROR'])
    parser.add_argument('--verbose', help='Make more verbose.', action='store_true')
    args = parser.parse_args()

    for handler in logger.handlers:
        handler.setLevel(getattr(logging, args.loglevel))

    if args.hosts is not None:
        args.hosts = args.hosts.split(',')

    script_redis_key = "status:script:{:s}:{:s}".format(hostname, __file__)
    logger.info('Starting SNAP redis monitor')

    r = redis.Redis(args.redishost, decode_responses=True)

    if r.exists('disable_monitoring'):
        r.set(script_redis_key, "locked out (%s)" % datetime.now())
        logger.warning('Monitoring locked out by {}.'.format(r.get('disable_monitoring')))
    else:
        corr = HeraCorrelator(hosts=args.hosts, redishost=args.redishost, block_monitoring=False)
        if args.verbose:
            print_ant_log_messages(corr)

        corr.r.hmset(
            "version:{:s}:{:s}".format(__package__, op.basename(__file__)),
            {"version": __version__, "timestamp": datetime.now().isoformat()}
        )

        # Put full set into redis status:snap:<host>
        corr.r.set(script_redis_key, "getting status (%s)" % datetime.now())
        try:
            corr.set_redis_status_fengs()
        except Exception as e:
            logger.warning(str(e))
    logger.info('Finished SNAP redis monitor')
