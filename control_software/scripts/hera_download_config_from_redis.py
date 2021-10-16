#! /usr/bin/env python
from __future__ import print_function
import redis

r = redis.Redis('redishost')

cfgdat = r.hget('snap_configuration','config').decode().splitlines()

for line in cfgdat:
    print(line)

