#! /usr/bin/env python

import argparse
from hera_corr_f import SnapFengine
import numpy as np
import struct
import collections
import time

parser = argparse.ArgumentParser(description='Set a programmed SNAP board to send data as arbitrary number '\
                                 'of antennas in the test vector or noise generator mode. (Only headers change).',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('hosts', metavar='hosts', type=str, nargs='+',
                    help = 'Hostnames / IPs of the SNAPs')
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
parser.add_argument('-ants',dest='nants',type=int, default=96,
                    help='Sets the number of antennas per SNAP')
args = parser.parse_args()


# Initialise and set input
fengines = [SnapFengine(host) for host in args.hosts]
for fengine in fengines:
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
 
# Assumptions:
# (1) There are 16 packets per channel.
# (2) Number of antennas is a multiple of 3.
# (3) There are 48 channels per X-eng? (Untested)

chans_per_packet = 16 # Hardcoded in firmware
num_chans = 1536*3/args.nants  # BW that gives ~10G with nants
chans_to_send = np.arange(256,256+num_chans) # A contiguous block in the middle of the band

chans_per_xeng = 1536 / 32 # 48 (hardcoded)
n_xengs = int(np.ceil(num_chans/chans_per_xeng))
packets_per_xeng = chans_per_xeng / chans_per_packet # 3

chan_blocks = []
for xn in range(n_xengs):
    chan_blocks += [chans_to_send[xn*chans_per_xeng : (xn+1)*chans_per_xeng]]

ant_blocks = np.arange(args.nants).reshape(-1,3)
num_ant_slots = ant_blocks.shape[0] 

# output mappings
dest_mac = 0x02020a0a0046                               # hera-gpu0
dest_ip = (10<<24) + (0<<16) + (10<<8) + (12<<0)        # hera-gpu0
#dest_mac = 0x0002c91f1151                              # simech1
#dest_ip  = (10<<24) + (0<<16) + (10<<8) + (27<<0)      # simech1

# Setting all the the destinations to the same IP for now.
xeng_ips = [dest_ip] * n_xengs
xeng_macs = [dest_mac] * n_xengs

# Populate the F-engine output slots of which there are 96
# Each slot is used to send 16 channels from 3 antennas to
# an arbitrary destination.
n_slots_to_send = 96
for fn,fengine in enumerate(fengines):
    print 'Setting Antenna indices for fengine: %d .... '%fn
    fengine.packetizer.initialize()
    fengine.reorder.initialize()
    for xn in range(n_xengs):
        for pk in range(packets_per_xeng):
            for an in range(num_ant_slots):
                slot = num_ant_slots*(xn*(packets_per_xeng) + pk) + an
                if slot < n_slots_to_send:
                    chans = chan_blocks[xn][pk*chans_per_packet : (pk+1)*chans_per_packet]
                    antarr = fn*args.nants + ant_blocks[an]
                    print 'Setting slot %d: IP: %d' % (slot, xeng_ips[xn]) , antarr, chans
                    fengine.packetizer.assign_slot(slot, chans, xeng_ips[xn], fengine.reorder,ants=antarr)
    

# Finally set the SNAP ARP tables and enable transmission

for fengine in fengines:
    fengine.eth.set_port(8511)
    for xn in range(n_xengs):
        fengine.eth.add_arp_entry(xeng_ips[xn], xeng_macs[xn])

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
