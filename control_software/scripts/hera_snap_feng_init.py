#! /usr/bin/env python

import argparse
from hera_corr_f import HeraCorrelator
from hera_corr_f import helpers
import numpy as np
import struct
import collections
import casperfpga
import redis
import time
import yaml
import logging

logger = helpers.add_default_log_handlers(logging.getLogger(__name__))

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

corr = HeraCorrelator(redishost=args.redishost, config=args.config_file)

if not corr.config_is_valid:
    logger.error('Currently loaded config is invalid')
    exit()

# Before we start manipulating boards, prevent monitoing scripts from
# sending TFTP traffic. Expire the key after 5 minutes to lazily account for
# issues with this script crashing.
corr.disable_monitoring(expiry=300)
time.sleep(1) # wait for the monitor to pause

if args.program:
    corr.program() # This should multithread the programming process.
    if not args.initialize:
        logger.warning('Programming but *NOT* initializing. This is unlikely to be what you want')

if args.initialize:
    corr.initialize()

if args.tvg:
    logger.info('Enabling EQ TVGs...')
    for feng in corr.fengs:
        feng.eq_tvg.write_freq_ramp()
        feng.eq_tvg.tvg_enable()

if args.noise:
    logger.info('Setting noise TVGs...')
    for feng in corr.fengs:
        seed = 23
        for stream in range(fengine.noise.nstreams): 
            feng.noise.set_seed(stream, seed)
        feng.input.use_noise()

# Now assign frequency slots to different X-engines as 
# per the config file. A total of 32 Xengs are assumed for 
# assigning slots- 16 for the even bank, 16 for the odd.  
# Channels not assigned to Xengs in the config file are 
# ignored. Following are the assumed globals:
if not corr.configure_freq_slots():
    logger.error('Configuring frequency slots failed!')
    exit()

# Sync logic. Do global sync first, and then noise generators
# wait for a PPS to pass then arm all the boards
if args.sync:
    corr.resync(manual=args.mansync)
    corr.sync_noise()

if args.eth:
    corr.enable_output()
else:
    corr.disable_output()


# Re-enable the monitoring process
corr.enable_monitoring()

print 'Initialization complete'
