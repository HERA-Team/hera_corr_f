#! /usr/bin/env python

import argparse
from hera_corr_f import SnapFengine
import numpy as np
import struct
import collections
import time
import yaml

parser = argparse.ArgumentParser(description='Set a programmed SNAP board to send data '\
                                 'as arbitrary number of antennas in the test vector '\
                                 'or noise generator mode. (Only headers change).',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('config_file', type=str,
                    help = 'Configuration file in YAML format (see example)')
parser.add_argument('-s', dest='sync', action='store_true', default=False,
                    help ='Use this flag to sync the F-engine(s) and Noise generators from PPS')
parser.add_argument('-m', dest='mansync', action='store_true', default=False,
                    help ='Use this flag to manually sync the F-engines with an '\
                          'asynchronous software trigger')
parser.add_argument('-i', dest='initialize', action='store_true', default=False,
                    help ='Use this flag to initialize the F-engine(s)')
parser.add_argument('-t', dest='tvg', action='store_true', default=False,
                    help ='Use this flag to switch to EQ TVG outputs')
parser.add_argument('-n', dest='noise', action='store_true', default=False,
                    help ='Use this flag to switch to Noise inputs')
parser.add_argument('-e', dest='eth', action='store_true', default=False,
                    help ='Use this flag to switch on the Ethernet outputs')
args = parser.parse_args()

with open(args.config_file,'r') as fp:
    config = yaml.load(fp)
fengs = config['fengines']
xengs = config['xengines']

# (1) ants%3 = 0 for all hosts
ants = []
for host,params in fengs.items():
    if 'ant_range' in params.keys():
        ant_range = params['ant_range']
        fengs[host]['ants'] = np.arange(ant_range[0],ant_range[1])
    ants.append(len(params['ants']))
    assert (np.sum(ants)%3 ==0),'%s : Number of antennas should be a multiple of 3.'%host

# (2) chans_per_xeng = 48
chans = 0
for host,params in xengs.items():
    if 'chan_range' in params.keys():
        chan_range = params['chan_range']
        xengs[host]['chans'] = np.arange(chan_range[0],chan_range[1])
    assert (len(params['chans'])<=48), '%s : Cannot process more than 48 channels per xeng.'%host
    chans += len(params['chans'])

# (3) BW per feng < 1536*3/ants
assert (3.0*1536/np.max(ants) >= chans),\
'Cannot set %d ants with %d channels'%(np.max(ants),chans)

# Initialise, set input and slot
fengines = []
for host,params in fengs.items():
    fengine = SnapFengine(host)
    fengines.append(fengine)

    if args.initialize:
        fengine.initialize()

    if args.tvg:
        print 'Enabling EQ TVGs...'
        fengine.eq_tvg.write_freq_ramp()
        fengine.eq_tvg.tvg_enable()

    if args.noise:
        print 'Setting noise TVGs...'
        seed = 23
        for stream in range(fengine.noise.nstreams): 
            fengine.noise.set_seed(stream, seed)
        fengine.input.use_noise() 
   
    # Set output mapping using xeng info from config file
    # Slots are set to cycle through xengs. 
    # Untested: Different num of channels to each xeng.
    print '\n\nSetting Antenna indices for fengine: %s .... '%host
    n_slots_to_send = 96
    ant_blocks = np.asarray(params['ants']).reshape(-1,3)
    num_ant_slots = ant_blocks.shape[0]
    n_xengs = len(xengs.keys())
    for xeng,xparam in xengs.items():
        chans_per_packet = 16 # hardcoded
        num_pkts = len(xparam['chans'])/chans_per_packet
        ip = [int(i) for i in xparam['ip'].split('.')]
        ip = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
        for pk in range(num_pkts):
            for an in range(num_ant_slots):
                slot = num_ant_slots*(pk*n_xengs + xparam['num']) + an
                if slot < n_slots_to_send:
                    chans = xparam['chans'][pk*chans_per_packet : (pk+1)*chans_per_packet]
                    antarr = ant_blocks[an]
                    print 'Setting slot %2d: IP: %s' % (slot, xparam['ip']), antarr, chans
                    fengine.packetizer.assign_slot(slot, chans, ip, fengine.reorder,ants=antarr)
        fengine.eth.add_arp_entry(ip,xparam['mac'])

    fengine.eth.set_port(params['udp_port'])

# Sync logic. Do global sync first, and then noise generators
# wait for a PPS to pass then arm all the boards
if args.sync:
    print 'Sync-ing Fengines'
    print 'Waiting for PPS at time %.2f' % time.time()
    fengines[0].sync.wait_for_sync()
    print 'Sync passed at time %.2f' % time.time()
    before_sync = time.time()
    for fengine in fengines:
        fengine.sync.arm_sync()
    after_sync = time.time()
    print 'Syncing took %.2f seconds' % (after_sync - before_sync)
    if after_sync - before_sync > 0.5:
        print "WARNING!!!"

if args.sync:
    print 'Sync-ing Noise generators'
    print 'Waiting for PPS at time %.2f' % time.time()
    fengines[0].sync.wait_for_sync()
    print 'Sync passed at time %.2f' % time.time()
    before_sync = time.time()
    for fengine in fengines:
        fengine.sync.arm_noise()
    after_sync = time.time()
    print 'Syncing took %.2f seconds' % (after_sync - before_sync)
    if after_sync - before_sync > 0.5:
        print "WARNING!!!"

if args.mansync:
    print 'Generating a software sync trigger'
    for fengine in fengines:
        fengine.sync.arm_sync()
        fengine.sync.arm_noise()
    for fengine in fengines:
        # It takes multiple (3?) syncs to clear the mrst.
        fengine.sync.sw_sync()
        fengine.sync.sw_sync()
        fengine.sync.sw_sync()
        fengine.sync.sw_sync()

if args.eth:
    print 'Enabling Ethernet outputs...'
    for fengine in fengines:
        fengine.eth.enable_tx()
else:
    print '**NOT** enabling Ethernet outputs...'

print 'Initialization complete'
