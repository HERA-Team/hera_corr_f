#! /usr/bin/env python

import argparse
from hera_corr_f import SnapFengine
import numpy as np
import struct, collections
import argparse

parser = argparse.ArgumentParser(description='Interact with a programmed SNAP board for testing and networking.',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('fpga',type=str,
                    help= 'Name of the SNAP- looks up IP from the /etc/hosts file')
args = parser.parse_args()

fengine = SnapFengine(host=args.fpga,port=69)
fengine.initialize()

## Noise Block
seed = 23
nstreams = 6
for stream in range(nstreams): 
    fengine.noise.set_seed(stream,seed)

## Input
# fengine.input.use_noise()

## Sync
fengine.sync.arm_sync()

## Test Vector Generator
fengine.eq_tvg.write_freq_ramp()
fengine.eq_tvg.tvg_enable()

## Packetizer

map_ips_chans = collections.OrderedDict({'192.0.0.1':(0,12*16), '192.0.0.2':(13*16,(13+12)*16), '192.0.0.3':(25*16,(25+12)*16), '192.0.0.4':100*16})
                                         #'192.0.0.5':(38*16,50*16),'192.0.0.6':(51*16,(51+12)*16),'192.0.0.7':(64*16,76*16),'192.0.0.8':80*16})

## 96 udp pkts per spectrum per antenna. Of these, max 96/Nx get
## sent to one X-engine.

# Full bandwidth per X-engine
Nx = len(map_ips_chans.keys())
Nchax = 1536/Nx

Nchans = 0
for ip,chan in map_ips_chans.iteritems():
    if type(chan) == tuple:
        Nchans+=chan[1]-chan[0]
    else:
        map_ips_chans[ip] = (chan, chan+Nchax)
        Nchans+=Nchax
        
if Nchans <= 1536:
    print("Assigned:: Number of channels: %d  Bandwidth: %.2f MHz"%(Nchans,Nchans*200/2048.))
else:
    exit("Error: You have assigned %d channels. Data rate larger than 10Gbps!")
    
reorder_map = np.zeros(Nchax)
chans = np.zeros(Nchax/16)

for i,chan in enumerate(map_ips_chans.values()):
    if (chan[1]-chan[0]) < Nchax:
        chan_order = np.append(np.arange(chan[0],chan[1],step=1),np.zeros(Nchax-(chan[1]-chan[0])))
    else:
        chan_order = np.arange(chan[0],chan[1],step=1)
        
    reorder_map = np.vstack((reorder_map,chan_order))
    chans = np.vstack((chans,chan_order[::16]/16))

reorder_map = reorder_map[1:].reshape((-1,),order='F')
reorder_map = np.insert(reorder_map,np.arange(3,1537,step=3),0)

chans = chans[1:].reshape((-1,),order='F')
chans = np.insert(chans,np.arange(3,97,step=3),0)

ips = []
for key in map_ips_chans.keys():
    idx = key.rsplit('.')
    ips.append((int(idx[0])<<24) + (int(idx[1])<<16) + (int(idx[2])<<8) + (int(idx[3])))
ips = ips*(Nchax/16)
ips = np.insert(ips,np.arange(3,97,step=3),0)

nants = 3
ants = np.arange(4)

fengine.reorder.set_channel_order(reorder_map)
fengine.packetizer.set_chan_headers(chans)
fengine.packetizer.set_nants(nants)
fengine.packetizer.set_dest_ips(ips)
fengine.packetizer.set_ant_headers(ants)

## Eth
#0x0002c94f0660
mac = [0x02020a0a0a85]*16
fengine.eth.set_arp_table(mac)#Port 10000 by default
fengine.eth.set_port(10000)
fengine.eth.enable_tx()

## Start sending the sync pulse
fengine.sync.sw_sync()

def assign_chans(map_ips_chans):
    '''Write the reorder map based on the input dictionary of channels to ip
    addresses assignment. If only the start values are specified, the
    full bandwidth per X-engine is assigned to it.
    
    :param map_ips_chans: OrderedDict, ip_addr: (start_chan,end_chan) or
    ip_addr:start_chan

    :return: reorder_map packed binary data for the software reorder block
    '''

    return "Implementing"
