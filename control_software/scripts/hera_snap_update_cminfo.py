#! /usr/bin/env python

import argparse
import redis
import logging
from hera_corr_f import helpers

logger = helpers.add_default_log_handlers(logging.getLogger(__file__))

parser = argparse.ArgumentParser(description='Suspend snap monitors for a specified time period',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')
parser.add_argument('-t', dest='suspend_mins', type=float, default=5.0,
                    help ='Time, in minutes, for which to suspend monitor processes')

args = parser.parse_args()

logger.info('Connecting to redis server %s' % args.redishost)
r = redis.Redis(args.redishost)

helpers.cminfo_compute()
