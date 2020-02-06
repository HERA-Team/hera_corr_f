#! /usr/bin/env python

import argparse
import logging
from hera_corr_f import helpers

logger = helpers.add_default_log_handlers(logging.getLogger(__file__))

parser = argparse.ArgumentParser(description='Update redis with snap hostnames',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help='Host servicing redis requests')

args = parser.parse_args()

helpers.write_snap_hostnames_to_redis(redishost=args.redishost)
