#! /usr/bin/env python

import argparse
from hera_corr_f import SnapFengine
import numpy as np
import struct
import collections
import time
import yaml

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

parser = argparse.ArgumentParser(description='Interact with a programmed SNAP board for testing and '\
                                 'networking. Requires a yaml based config file (see example).',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('config_file',type=str,
                    help = 'YAML configuration file with hosts and channels list')
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

# Check that there are only 384 channels per x-engine.
for host,params in xengs.items():
    if 'chan_range' in params.keys():
        chanrange = params['chan_range']
        xengs[host]['chans'] = np.arange(chanrange[0], chanrange[1])
    assert(len(params['chans']) <= 384), "%s: Cannot process >48 channels."%host

# Initialize, set input according to command line flags.
for host,params in fengs.items():

    fengs[host]['fengine'] = SnapFengine(params['host_ip'])
    fengine = fengs[host]['fengine']
  
    if config['initialize']:
        print '%s: Initializing..'%host
        fengine.initialize()

    if config['tvg']:
        print '%s:  Enabling EQ TVGs...'%host
        set_test_vector(fengine,config['tvg'])

    if config['noise']:
        print '%s:  Setting noise TVGs...'%host
        ## Noise Block
        seed = 23
        for stream in range(fengine.noise.nstreams): 
            fengine.noise.set_seed(stream, seed)
        fengine.input.use_noise()

# Initialize and set input according to config file (if not set globally)
if not config['initialize']:
    for host,params in fengs.items():
        if params['init']: params['fengine'].initialize()

if not config['tvg']:
    for host,params in fengs.items():
        if params['tvg']:
            print '%s: Enabling EQ TVG...'%host
            set_test_vector(params['fengine'],params['tvg'])

if not config['noise']:
    for host,params in fengs.items():
        if params['noise']:
            print '%s: Setting noise TVG...'%host
            seed = 23; fengine = params['fengine']
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

#fengines_list=[SnapFengine('snap111')]
# Set packetizer chan values
#ips = [((10<<24)+(10<<16)+(10<<8)+136),0]
#ant = 63 #index of first antenna on board
#
#for slot in range(16): #16 Xengines
#    chans = np.arange(slot*384,(slot+1)*384,1)
#    fengs['snap111']['fengine'].packetizer.assign_slot(slot, chans, ips, fengine.reorder, ant) 
#
#fengs['snap111']['fengine'].eth.add_arp_entry(((10<<24)+(10<<16)+(10<<8)+136),0x02020a140102)
#fengs['snap111']['fengine'].eth.set_port(8511)


# Sync logic. Do global sync first, and then noise generators
# wait for a PPS to pass then arm all the boards
if config['sync']=='pps':
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

if config['sync']=='pps':
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

if config['sync']=='manual':
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

if config['eth']:
    print 'Enabling Ethernet outputs...'
    for fengine in fengines_list:
        fengine.eth.enable_tx()
else:
    for host, params in fengs.items():
        if params['eth']:
            print 'Enabling Ethernet outputs for %s'%host
            params['fengine'].eth.enable_tx()

print 'Initialization complete'
