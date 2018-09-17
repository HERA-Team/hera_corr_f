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
parser.add_argument('-s', dest='sync', action='store_true', default=False,
                    help ='Use this flag to sync the F-engine(s) and Noise generators from PPS')
parser.add_argument('-m', dest='mansync', action='store_true', default=False,
                    help ='Use this flag to manually sync the F-engines with an asynchronous software trigger')
parser.add_argument('-i', dest='initialize', action='store_true', default=False,
                    help ='Use this flag to initialize the F-engine(s)')
parser.add_argument('-t', dest='tvg', action='store_true', default=False,
                    help ='Use this flag to switch to EQ TVG outputs')
parser.add_argument('-n', dest='noise', action='store_true', default=False,
                    help ='Use this flag to switch to Noise inputs')
parser.add_argument('-e', dest='eth', action='store_true', default=False,
                    help ='Use this flag to switch on the Ethernet outputs')
parser.add_argument('-p','--program', action='store_true', default=False,
                    help='Program FPGAs with the fpgfile specified in the config file if not programmed already')
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

# Check that there are only three antennas per board
for fn,(host,params) in enumerate(fengs.items()):
    if 'ants' in params.keys():
        assert (len(params['ants'])==3), "%s: Number of antennas is not 3!"%host
    else:
        fengs[host]['ants'] = np.arange(fn,fn+3)

# Check that there are only 48 channels per x-engine.
for host,params in xengs.items():
    if 'chan_range' in params.keys():
        chanrange = params['chan_range']
        xengs[host]['chans'] = np.arange(chanrange[0], chanrange[1])
    assert(len(params['chans'])<=384), "%s: Cannot process >384 channels."%host

# Before we start manipulating boards, prevent monitoing scripts from
# sending TFTP traffic. Expire the key after 5 minutes to lazily account for
# issues with this script crashing.
r.set('disable_monitoring', 1, ex=600)
time.sleep(1)

# Initialize, set input according to command line flags.
for host,params in fengs.items():
    # re-disable, in case we're doing something outrageous like programming
    # a gazillion boards, which could take a looooong time.
    r.set('disable_monitoring', 1, ex=600)

    if args.program:
        f = casperfpga.CasperFpga(host)
        print "Programming %s with %s" % (host, config['fpgfile'])
        f.upload_to_ram_and_program(config['fpgfile'])
        r.hset('snap_last_programmed', host, time.ctime())

    fengs[host]['fengine'] = SnapFengine(host)
    fengine = fengs[host]['fengine']
  
    if args.initialize:
        print '%s: Initializing..'%host
        fengine.initialize()

    if args.tvg:
        print '%s:  Enabling EQ TVGs...'%host
        fengine.eq_tvg.write_freq_ramp()
        fengine.eq_tvg.tvg_enable()

    if args.noise:
        print '%s:  Setting noise TVGs...'%host
        ## Noise Block
        seed = 23
        for stream in range(fengine.noise.nstreams): 
            fengine.noise.set_seed(stream, seed)
        fengine.input.use_noise()

# Now assign frequency slots to different X-engines as 
# per the config file. A total of 32 Xengs are assumed for 
# assigning slots- 16 for the even bank, 16 for the odd.  
# Channels not assigned to Xengs in the config file are 
# ignored. Following are the assumed globals:
n_xengs = 16
chans_per_packet = 384 # Hardcoded in firmware

fengines_list = []
for fhost, fparams in fengs.items():
    fengine = fparams['fengine']
    fengines_list.append(fengine)

    for xhost, xparams in xengs.items():
        if (xparams['num'] > n_xengs): 
           raise ValueError("Cannot have more than %d X-engs!!"%n_xengs)
        print '%s: Setting Xengine %d: '%(xhost,xparams['num']),\
              'IP Even: %s'%xparams['even']['ip'],\
              'IP Odd: %s'%xparams['odd']['ip']
           
        ip = [int(i) for i in xparams['even']['ip'].split('.')]
        ip_even = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
        ip = [int(i) for i in xparams['odd']['ip'].split('.')]
        ip_odd = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
        fengine.packetizer.assign_slot(xparams['num'], xparams['chans'], \
                                       [ip_even,ip_odd], fengine.reorder,\
                                       fparams['ants'][0])
        fengine.eth.add_arp_entry(ip_even,xparams['even']['mac'])
        fengine.eth.add_arp_entry(ip_odd,xparams['odd']['mac'])

    fengine.eth.set_port(fparams['dest_port'])

# Sync logic. Do global sync first, and then noise generators
# wait for a PPS to pass then arm all the boards
if args.sync:
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

if args.sync:
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

if args.eth:
    print 'Enabling Ethernet outputs...'
    for fengine in fengines_list:
        fengine.eth.enable_tx()
else:
    print '*NOT* enabling ethernet output.'
    for fengine in fengines_list:
        fengine.eth.disable_tx()


# Re-enable the monitoring process
r.delete('disable_monitoring')

print 'Initialization complete'

def set_test_vector(fengine,mode):
   if mode == 'const_ants':
       fengine.eq_tvg.write_const_ants(equal_pols=True)
   elif mode == 'const_pols':
       fengine.eq_tvg.write_const_ants(equal_pols=False)
   elif mode == 'ramp':
       fengine.eq_tvg.write_freq_ramp(equal_pols=True)
   elif mode == 'ramp_pols':
       fengine.eq_tvg.write_freq_ramp(equal_pols=False)
   else: 
       print "Not sure what is asked for. Writing ramp to all pols."
       fengine.eq_tvg.write_freq_ramp(equal_pols=True)
   fengine.eq_tvg.tvg_enable()
   return True

