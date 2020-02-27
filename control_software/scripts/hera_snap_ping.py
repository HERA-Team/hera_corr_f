#!/usr/bin/env python
"""SNAP ping monitor."""
import subprocess
import redis
import json
from datetime import datetime
from os import path


r = redis.Redis('redishost')
snaps_cm = list(json.loads(r.hget('corr:map', 'all_snap_inputs')).keys())
snap_to_host = json.loads(r.hget('corr:map', 'snap_host'))

now = datetime.strftime(datetime.now(), '%Y/%m/%d %H:%M')
path_to_use = '/home/hera/logs'

for snap in snaps_cm:
    try:
        snap_ping = 'ping -c 1 {}'.format(snap_to_host[snap])
    except KeyError:
        continue
    try:
        stats = subprocess.check_output(snap_ping, shell=True).splitlines()
    except subprocess.CalledProcessError:
        continue

    packets = 1.0 - float(stats[4].split(',')[2].strip().split()[0].strip('%')) / 100.0
    fn = path.join(path_to_use, '{}.txt'.format(snap_to_host[snap]))
    with open(fn, 'a') as fp:
        fp.write('{}\t{}\t{:.2f}'.format(now, snap, packets))
