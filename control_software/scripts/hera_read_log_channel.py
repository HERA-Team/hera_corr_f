#!/usr/env python

import redis
import json
import time
import argparse


parser = argparse.ArgumentParser(description='Subscribe to the redis-based log stream',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')

args = parser.parse_args()

print('Connecting to redis server %s' % args.redishost)
connection_pool = redis.ConnectionPool(host=args.redishost)
r = redis.Redis(connection_pool=connection_pool, max_connections=100)

ps = r.pubsub()

ps.subscribe('log-channel')

while(True):
    try:
        mess = ps.get_message(ignore_subscribe_messages=True)
        if mess is not None:
            print json.loads(mess['data'])['formatted']
        else:
            time.sleep(0.01)
    except KeyboardInterrupt:
        ps.close()
        exit()
