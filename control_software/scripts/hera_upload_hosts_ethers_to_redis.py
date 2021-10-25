#!/usr/env python

"""
Upload hosts/ethers files to redis.
"""

import redis
import argparse
import socket

parser = argparse.ArgumentParser(description='hosts/ethers file upload to redis',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-r', '--redishost', type=str, default='redishost',
                    help='Host servicing redis requests')
parser.add_argument('--expire', help="Set expire time in redis [3600 sec].", type=int, default=3600)

args = parser.parse_args()

r = redis.Redis(args.redishost, decode_responses=True)
hostname = socket.gethostname()

for cfile in ['/etc/hosts', '/etc/ethers']:
    ctype = cfile.split('/')[-1]
    with open(cfile, 'r') as fh:
        config = fh.read()
        r.hset(ctype, hostname, config)
        r.expire(ctype, args.expire)
