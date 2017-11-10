#! /usr/bin/env python

import argparse
from hera_corr_f import SnapFengine
import numpy as np
import struct
import collections
import time

parser = argparse.ArgumentParser(description='Interact with a programmed SNAP board for testing and networking.',
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

args = parser.parse_args()


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
        ## Noise Block
        seed = 23
        for stream in range(fengine.noise.nstreams): 
            fengine.noise.set_seed(stream, seed)
        fengine.input.use_noise()


# Set the output ordering stuff
# First set the antenna indices for each board. For now we just
# assume 3 antennas per board, and increment in the order the
# boards are presented as arguments to this script.
nants = 3
for fn, fengine in enumerate(fengines):
    print 'Setting Antenna indices...'
    fengine.packetizer.initialize()
    fengine.reorder.initialize()
    fengine.packetizer.set_nants(nants)
    fengine.packetizer.set_ant_headers(np.arange(nants+1) + nants*fn) # TODO something smarter to number antennas

# output mappings
# Now prepare to map the destinations of different frequency slots.
# For now assume that we are going to send a contiguous chunk of 1536
# channels to 32 X-engines. Generate the mapping of channels to
# X-engine (but for now just make all the destinations the same.

dest_mac = 0x0002c91f1151                               # simech1
dest_ip  = (10<<24) + (0<<16) + (10<<8) + (123<<0)      # simech1

chans_to_send = np.arange(256, 256+1536) # A contiguous block in the middle of the band

n_xengs = 32
chans_per_packet = 16 # Hardcoded in firmware
chans_per_xeng = 1536 / 32 # 48
packets_per_xeng = chans_per_xeng / chans_per_packet # 3

xeng_ips = [dest_ip] * n_xengs
xeng_macs = [dest_mac] * n_xengs


chan_blocks = []
for xn in range(n_xengs):
    chan_blocks += [chans_to_send[xn*chans_per_xeng : (xn+1)*chans_per_xeng]]

# Populate the F-engine output slots of which there are 96
# Each slot is used to send 16 channels from all antennas to
# an arbitrary destination.
n_slots_to_send = 96
for fengine in fengines:
    for pk in range(packets_per_xeng):
        for xn in range(n_xengs):
            slot = pk*n_xengs + xn
            if slot < n_slots_to_send:
                chans = chan_blocks[xn][pk*chans_per_packet : (pk+1)*chans_per_packet]
                print 'Setting slot %d: IP: %d' % (slot, xeng_ips[xn]) , chans
                fengine.packetizer.assign_slot(slot, chans, xeng_ips[xn], fengine.reorder)
    
# Finally set the SNAP ARP tables and enable transmission

for fengine in fengines:
    fengine.eth.set_port(10000)
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
