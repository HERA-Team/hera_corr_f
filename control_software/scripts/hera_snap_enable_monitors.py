#! /usr/bin/env python

import argparse
import redis
import logging
from hera_corr_f import helpers

logger = helpers.add_default_log_handlers(logging.getLogger(__file__))

parser = argparse.ArgumentParser(description='Delete the "disable monitoring" redis key',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')

args = parser.parse_args()

logger.info('Connecting to redis server %s' % args.redishost)
r = redis.Redis(args.redishost)

logger.info('Enabling snap monitoring')
r.delete('disable_monitoring')
