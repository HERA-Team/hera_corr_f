#! /usr/bin/env python

import argparse
from hera_corr_f import SnapFengine, HeraCorrelator, helpers, __version__
import numpy as np
import struct
import collections
import redis
import time
import yaml
import casperfpga
import logging

logger = helpers.add_default_log_handlers(logging.getLogger(__name__))

parser = argparse.ArgumentParser(description='Set a programmed SNAP board to send data as arbitrary number '\
                                 'of antennas in the test vector or noise generator mode. (Only headers change).',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('config_file',type=str,
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
parser.add_argument('-P','--forceprogram', action='store_true', default=False,
                    help='Program FPGAs with the fpgfile specified in the config file irrespective of whether they are programmed already')
parser.add_argument('--nomultithread', action='store_true', default=False,
                    help='Don\'t multithread initialization')
parser.add_argument('--noredistapcp', action='store_true', default=False,
                    help='Don\'t use the redis-based SNAP comms protocol')
args = parser.parse_args()

corr = HeraCorrelator(redishost=args.redishost, config=args.config_file, use_redis=(not args.noredistapcp))

# Before we start manipulating boards, prevent monitoing scripts from
# sending TFTP traffic. Expire the key after 5 minutes to lazily account for
# issues with this script crashing.
corr.disable_monitoring(expiry=600, wait=True)


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
    ant_range = params['ants']
    fengs[host]['ant_list'] = np.arange(ant_range[0],ant_range[1])
    assert (len(params['ant_list'])<=48),\
           "%s: Cannot allocate more than 48 antennas!"%host
    assert (len(params['ant_list'])%3 == 0),\
           "%s: Number of antennas should be a multiple of 3"%host
    if (len(params['ant_list'])>Nants): Nants = len(params['ant_list'])

# Check that there are 384 channels per X-eng
for host,params in xengs.items():
    chanrange = params['chan_range']
    xengs[host]['chans'] = np.arange(chanrange[0], chanrange[1])
    assert(len(params['chans'])<=384),\
          "%s: Cannot process >384 channels."%host

# For N antennas per board, you can only 
# allot channels to (48//Nants) Xengs.
n_xengs = 48/Nants
chans_per_packet = 384 # Hardcoded in firmware

# Check that there are only n_xengs specified
assert (len(xengs.keys()) <= n_xengs),\
       "Cannot have more than %d X-engs!!"%n_xengs

# Initialize, set input according to command line flags.

if args.program or args.forceprogram:
    corr.program(unprogrammed_only=(not args.forceprogram)) # This should multithread the programming process.
    if not args.initialize:
        logger.warning('Programming but *NOT* initializing. This is unlikely to be what you want')

if args.initialize:
    corr.disable_output()
    corr.initialize(multithread=(not args.nomultithread))

if args.tvg:
    logger.info('Enabling EQ TVGs...')
    corr.do_for_all_f("write_freq_ramp", block="eq_tvg")
    corr.do_for_all_f("tvg_enable", block="eq_tvg")

if args.noise:
    logger.info('Setting noise TVGs...')
    seed = 23
    for stream in range(fengine.noise.nstreams): 
        corr.do_for_all_f("set_seed", block="noise", args=[stream, seed])
    corr.do_for_all_f("use_noise", block="input")

# Now assign frequency slots to different X-engines as 
# per the config file. A total of 32 Xengs are assumed for 
# assigning slots- 16 for the even bank, 16 for the odd.  
# Channels not assigned to Xengs in the config file are 
# ignored.

fengines_list = []
for fengine, fparams in zip(corr.fengs, fengs.values()):
    print 'Setting Antenna indices for fengine: %s .... '%fengine.host
    fengine.packetizer.initialize()
    fengine.reorder.initialize()

    ant_list = fparams['ant_list'].reshape(-1,3)

    for xhost, xparams in xengs.items():
        ip = [int(i) for i in xparams['even']['ip'].split('.')]
        ip_even = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
        ip = [int(i) for i in xparams['odd']['ip'].split('.')]
        ip_odd = (ip[0]<<24) + (ip[1]<<16) + (ip[2]<<8) + ip[3]
        for a in range(ant_list.shape[0]):
            slot_num = xhost*ant_list.shape[0] + a 
            print 'Slot_num: %d\t'%slot_num,
            print 'Ants: ', ant_list[a], 
            print '\tChans: ', xparams['chans'][0:4],
            print '\t...', xparams['chans'][-5:]
            fengine.packetizer.assign_slot(slot_num, xparams['chans'], \
                                           [ip_even,ip_odd], fengine.reorder,\
                                           ant_list[a][0])
        fengine.eth.add_arp_entry(ip_even,xparams['even']['mac'])
        fengine.eth.add_arp_entry(ip_odd,xparams['odd']['mac'])

    fengine.eth.set_port(config['dest_port'])

# Sync logic. Do global sync first, and then noise generators
# wait for a PPS to pass then arm all the boards
if args.sync:
    corr.disable_output()
    corr.do_for_all_f("change_period", block="sync", args=[0])
    corr.resync(manual=args.mansync)
    corr.sync_noise(manual=args.mansync)

if args.eth:
    corr.enable_output()
else:
    corr.disable_output()

# Re-enable the monitoring process
corr.enable_monitoring()

print 'Initialization complete'
