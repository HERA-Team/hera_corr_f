#! /usr/bin/env python

import argparse
from hera_corr_f import SnapFengine
import numpy as np
import struct
import collections
import casperfpga
import redis
import time
import yaml

parser = argparse.ArgumentParser(description='Interact with a programmed SNAP board for testing and '\
                                 'networking. FLAGS OVERRIDE CONFIG FILE!',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('--config_file', type=str, default=None,
                    help = 'YAML configuration file with hosts and channels list')
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')
parser.add_argument('-m', dest='mansync', action='store_true', default=False,
                    help ='Use this flag to manually sync the F-engines with an asynchronous software trigger')
args = parser.parse_args()

r = redis.Redis(args.redishost)
if args.config_file is None:
    config_str  = r.hget('snap_configuration', 'config')
    config_time = r.hget('snap_configuration', 'upload_time_str')
    print 'Using configuration from redis, uploaded at %s' % config_time
    config = yaml.load(config_str)
else:
    with open(args.config_file,'r') as fp:
        config = yaml.load(fp)

fengs = config['fengines']
xengs = config['xengines']

# sending TFTP traffic. Expire the key after 1 minute to lazily account for
# issues with this script crashing.
r.set('disable_monitoring', 1, ex=60)
time.sleep(1)

# Initialize, set input according to command line flags.
fengines_list = []
for host,params in fengs.items():
    fengines_list += [SnapFengine(host)]

print 'Sync-ing Fengines'
print 'Waiting for PPS at time %.2f' % time.time()
fengines_list[0].sync.wait_for_sync()
print 'Sync passed at time %.2f' % time.time()
before_sync = time.time()
for fengine in fengines_list:
    fengine.sync.arm_sync()
after_sync = time.time()
sync_time = int(before_sync) + 3 # Takes 3 clcok cycles to arm
r['corr:feng_sync_time'] = sync_time
r['corr:feng_sync_time_str'] = time.ctime(sync_time)
print 'Syncing took %.2f seconds' % (after_sync - before_sync)
if after_sync - before_sync > 0.5:
    print "WARNING!!!"

print 'Sync-ing Noise generators'
print 'Waiting for PPS at time %.2f' % time.time()
fengines_list[0].sync.wait_for_sync()
print 'Sync passed at time %.2f' % time.time()
before_sync = time.time()
for fengine in fengines_list:
    fengine.sync.arm_noise()
after_sync = time.time()
print 'Syncing took %.2f seconds' % (after_sync - before_sync)
if after_sync - before_sync > 0.5:
    print "WARNING!!!"

if args.mansync:
    print 'Generating a software sync trigger'
    for fengine in fengines_list:
        fengine.sync.arm_sync()
        fengine.sync.arm_noise()
    for fengine in fengines_list:
        # It takes multiple (3?) syncs to clear the mrst.
        fengine.sync.sw_sync()
        fengine.sync.sw_sync()
        fengine.sync.sw_sync()
        fengine.sync.sw_sync()

# Re-enable the monitoring process
r.delete('disable_monitoring')

print 'Syncing complete'
