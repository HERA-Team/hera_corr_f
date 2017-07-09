from snap_fengine import SnapFengine
import numpy as np

fengine = SnapFengine('10.0.10.112')

## Noise Block
seed = 23
nstreams = 6
for stream in range(nstreams): 
    fengine.noise.set_seed(seed, stream)

## Input
fengine.input.use_noise()

## Sync
fengine.sync.arm_sync()
fengine.sync.sw_sync()

## Test Vector Generator
fengine.eq_tvg.tvg_enable()

## Reorder
order = np.arange(2048)
fengine.reorder.set_channel_order(order)

## Packetizer
nants = 3
ips = [(10<<24)+(0<<16)+(10<<8)+10]*(2**8)#np.array([(10<<24)+(0<<16)+(10<<8)+10]*(2**8),dtype='>L') 
chans = np.arange(0,2048,step=16)#,dtype='>H')
ants = np.arange(nants)#,dtype='>H')

fengine.packetizer.set_chan_headers(chans)
fengine.packetizer.set_nants(nants)
fengine.packetizer.set_dest_ips(ips)
fengine.packetizer.set_ant_headers(ants)

## Eth
mac = [0x0002c94f0660]*256
fengine.eth.set_arp_table(mac)#Port 10000 by default
fengine.eth.enable_tx()
