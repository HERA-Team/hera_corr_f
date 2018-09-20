#! /usr/bin/env python

import argparse
from hera_corr_f import SnapFengine
import numpy as np
import struct
import collections
import time
import yaml

parser = argparse.ArgumentParser(description='Interact with a programmed SNAP board for testing and '\
                                 'networking. FLAGS OVERRIDE CONFIG FILE!',
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

args = parser.parse_args()

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
    assert(len(params['chans'])<=48), "%s: Cannot process >48 channels."%host

# Initialize, set input according to command line flags.
for host,params in fengs.items():

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

# Initialize and set input according to config file (if not set globally)
if not args.initialize:
    for host,params in fengs.items():
        if params['init']: params['fengine'].initialize()

if not args.tvg:
    for host,params in fengs.items():
        if params['tvg']:
            print '%s: Enabling EQ TVG...'%host
            params['fengine'].eq_tvg.write_freq_ramp()
            params['fengine'].eq_tvg.tvg_enable()

if not args.noise:
    for host,params in fengs.items():
        if params['noise']:
            print '%s: Setting noise TVG...'%host
            seed = 23; fengine = params['fengine']
            for stream in range(fengine.noise.nstreams): 
                fengine.noise.set_seed(stream, seed)
            fengine.input.use_noise()
 
# Now assign frequency slots to different X-engines as 
# per the config file. A total of 32 Xengs are assumed for 
# assigning slots. Xengs not defined in the config file are 
# ignored. Following are the assumed globals:
n_xengs = 32
chans_per_packet = 16 # Hardcoded in firmware
chans_per_xeng = 1536 / 32 # 48
packets_per_xeng = chans_per_xeng / chans_per_packet # 3

# Populate the F-engine output slots of which there are 96
# Each slot is used to send 16 channels from all antennas to
# an arbitrary destination.
n_slots_to_send = 96
fengines_list = []
for fhost, fparams in fengs.items():
    fengine = fparams['fengine']
    fengines_list.append(fengine)

    for xhost, xparams in xengs.items():
        ip = [int(i) for i in xparams['ip'].split('.')]
        ip = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
        for pk in range(packets_per_xeng):
            slot = pk*n_xengs + xparams['num']
            if slot < n_slots_to_send:
                chans = xparams['chans'][pk*chans_per_packet: (pk+1)*chans_per_packet]
                print '%s: Setting slot %d: IP: %s'%(fhost, slot, xparams['ip']), chans
                fengine.packetizer.assign_slot(slot, chans, ip, fengine.reorder, ants=fparams['ants'])
        fengine.eth.add_arp_entry(ip,xparams['mac'])

    fengine.eth.set_port(params['host_port'])

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
    for host, params in fengs.items():
        if params['eth']:
            print 'Enabling Ethernet outputs for %s'%host
            params['fengine'].eth.enable_tx()

print 'Initialization complete'
