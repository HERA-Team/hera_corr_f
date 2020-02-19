#! /usr/bin/env python

"""Add snap hostnames to redis."""

import argparse
import logging
from hera_corr_cm.handlers import add_default_log_handlers
from hera_corr_cm import redis_cm

logger = add_default_log_handlers(logging.getLogger(__file__))

parser = argparse.ArgumentParser(description='Update redis with snap hostnames',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help='Host servicing redis requests')

args = parser.parse_args()

redis_cm.write_snap_hostnames_to_redis(redishost=args.redishost)
