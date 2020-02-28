#!/usr/bin/env python
"""SNAP ping monitor."""
import argparse
import subprocess
from datetime import datetime
import time
from os import path
from hera_corr_f import redis_cm

ap = argparse.ArgumentParser()
ap.add_argument('-s', '--snaps', help="Use snaps from redis for one of cm/cfg/corr.", default='cfg')
ap.add_argument('-n', '--nap', help="Nap time in seconds between snap pings.", default=1.0)
ap.add_argument('-c', '--count', help="Number of pings to send.", default=1)
args = ap.parse_args()

snaps = redis_cm.get_snaps_from_redis()
print("Using snaps from redis for {}".format(args.snaps))
print(snaps[args.snaps])

now = datetime.strftime(datetime.now(), '%Y/%m/%d %H:%M')
path_to_use = '/home/hera/logs'

for snap in snaps[args.snaps]:
    time.sleep(args.nap)
    snap_ping = 'ping -c {} {}'.format(args.count, snap)
    try:
        stats = subprocess.check_output(snap_ping, shell=True).splitlines()
    except subprocess.CalledProcessError:
        continue

    packets = 1.0 - float(stats[4].split(',')[2].strip().split()[0].strip('%')) / 100.0
    fn = path.join(path_to_use, '{}.txt'.format(snap))
    with open(fn, 'a') as fp:
        fp.write('{}\t{}\t{:.2f}\n'.format(now, snap, packets))
