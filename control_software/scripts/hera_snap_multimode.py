#! /usr/bin/env python

import argparse
from hera_corr_f import SnapFengine
import numpy as np
import struct
import collections
import time
import yaml
import casperfpga

parser = argparse.ArgumentParser(description='Set a programmed SNAP board to send data as arbitrary number '\
                                 'of antennas in the test vector or noise generator mode. (Only headers change).',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('config_file',type=str,
                    help = 'YAML configuration file with hosts and channels list')
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

with open(args.config_file,'r') as fp:
    config = yaml.load(fp)
fengs = config['fengines']
xengs = config['xengines']

## Assumptions:
## 1. You cannot send more than 48 antennas from a SNAP.
## 2. Number of antennas per SNAP should be a multiple of 3.
## 2. You can send 384 channels to each X-eng.
## 3. There are 2 time banks with 16 X-engs each.

# Check that there are a maximum of 48 antennas per SNAP
Nants = 0
for host,params in fengs.items():
    if 'ant_range' in params.keys():
        ant_range = params['ant_range']
        fengs[host]['ants'] = np.arange(ant_range[0],ant_range[1])
    assert (len(params['ants'])<=48), "%s: Cannot allocate more than 48 antennas!"%host
    assert (len(params['ants'])%3 == 0), "%s: Number of antennas should be a multiple of 3"%host
    if (len(params['ants'])>Nants): Nants = len(params['ants'])

# Check that there are 384 channels per X-eng
for host,params in xengs.items():
    if 'chan_range' in params.keys():
        chanrange = params['chan_range']
        xengs[host]['chans'] = np.arange(chanrange[0], chanrange[1])
    assert(len(params['chans'])<=384), "%s: Cannot process >384 channels."%host

# Initialize, set input according to command line flags.
for host,params in fengs.items():

    if args.program:
        f = casperfpga.CasperFpga(params['host_ip'])
        print "Programming %s with %s" % (params['host_ip'], config['fpgfile'])
        f.upload_to_ram_and_program(config['fpgfile'])

    fengs[host]['fengine'] = SnapFengine(params['host_ip'])
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
# ignored.

# For N antennas per board, you can only 
# allot channels to (48//Nants) Xengs.
n_xengs = 48/Nants
chans_per_packet = 384 # Hardcoded in firmware

fengines_list = []
for fhost, fparams in fengs.items():
    fengine = fparams['fengine']
    fengines_list.append(fengine)

    print 'Setting Antenna indices for fengine: %s .... '%fhost
    fengine.packetizer.initialize()
    fengine.reorder.initialize()

    ant_list = fparams['ants'].reshape(-1,3)

    for xhost, xparams in xengs.items():
        if (xparams['num'] > n_xengs): 
           raise ValueError("Cannot have more than %d X-engs!!"%n_xengs)
        ip = [int(i) for i in xparams['even']['ip'].split('.')]
        ip_even = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
        ip = [int(i) for i in xparams['odd']['ip'].split('.')]
        ip_odd = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
        for a in range(ant_list.shape[0]):
            slot_num = xparams['num']*ant_list.shape[0] + a 
            print 'Slot_num: %d\t'%slot_num,
            print 'Ants: ', ant_list[a], 
            print '\tChans: ', xparams['chans'][0:8]
            fengine.packetizer.assign_slot(slot_num, xparams['chans'], \
                                           [ip_even,ip_odd], fengine.reorder,\
                                           ant_list[a][0])
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

print 'Initialization complete'
