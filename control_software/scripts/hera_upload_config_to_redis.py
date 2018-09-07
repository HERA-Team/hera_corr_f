#!/usr/env python

"""
Upload a yaml configuration file to redis.
"""

import sys
import redis
import argparse
import time

parser = argparse.ArgumentParser(description='Config file to upload to redis',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('config_file',type=str,
                    help = 'YAML configuration file with hosts and channels list')
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')

args = parser.parse_args()

r = redis.Redis(args.redishost)

with open(args.config_file, 'r') as fh:
    upload_time = time.time()
    r.hmset('snap_configuration', {'config':fh.read(), 'upload_time':upload_time, 'upload_time_str':time.ctime(upload_time)})
