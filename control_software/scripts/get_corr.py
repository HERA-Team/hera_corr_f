#!/usr/env python
import os
from hera_corr_f import SnapFengine
from hera_corr_f import helpers
import redis
import logging
import numpy as np
import argparse 
import time

logger = helpers.add_default_log_handlers(logging.getLogger(__file__))

parser = argparse.ArgumentParser(description='Obtain cross-correlation spectra from a SNAP Board',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('host', type=str, 
                    help='Host boards to collect data from')
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')
parser.add_argument('--noise', dest='noise', action='store_true', default=False,
                    help ='Use this flag to switch to Noise inputs')
parser.add_argument('--tvg', dest='tvg', action='store_true', default=False,
                    help ='Use this flag to switch to EQ TVG outputs')
parser.add_argument('-n','--num_spectra',type=int,default=10,
                    help='Number of spectra per baseline')
parser.add_argument('-t', '--integration_time', type=int, default=1,
                    help='Integration time in seconds for each spectra')
parser.add_argument('-o','--output',type=str, default='.',
                    help='Path to destination folder')
args = parser.parse_args()

NCHAN    = 1024
NPOL     = 4
NBL      = 6
NTIME    = args.num_spectra
NBLTIMES = (NTIME * NBL)
    
r = redis.Redis(args.redishost)
r.set('disable_monitoring', 1, ex=60)
time.sleep(2)

frequencies = np.arange(NCHAN) * 250e6/NCHAN
pols = range(NPOL)
ant1_array=np.array([[0,0,0,1,1,2] for t in range(NTIME)]).astype(int).flatten()
ant2_array=np.array([[0,1,2,1,2,2] for t in range(NTIME)]).astype(int).flatten()
antenna_pairs = ([[0,0],[0,1],[0,2],[1,1],[1,2],[2,2]])

fengine = SnapFengine(args.host)

if args.tvg:
    logger.info('%s:  Enabling EQ TVGs...'%args.host)
    fengine.eq_tvg.write_const_ants()
    fengine.eq_tvg.tvg_enable()

if args.noise:
    logger.info('%s:  Setting noise TVGs...'%args.host)
    ## Noise Block
    seed = 23
    for stream in range(fengine.noise.nstreams): 
        fengine.noise.set_seed(stream, seed)
    fengine.input.use_noise()

# Set integration length
acc_len = (args.integration_time * 500e6)/(8192*8*2) 
# convert to spectra (/8192), accumulations (/2)
# TODO: Don't understand the empirical factor of 2

times = []
data = []
# Start integrating and collecting data
for t in range(NTIME):
    for a1, a2 in antenna_pairs:
        r.set('disable_monitoring', 1, ex=60)
        logger.info('Getting baseline pair: (%d, %d)..'%(a1,a2))
        a1*= 2; a2*= 2;
        corr = [] 
        corr.append(fengine.corr.get_new_corr(a1, a2)) #xx
        times.append(time.time())
        corr.append(fengine.corr.get_new_corr(a1+1, a2+1)) #yy
        times.append(time.time())
        corr.append(fengine.corr.get_new_corr(a1,   a2+1)) #xy
        times.append(time.time())
        corr.append(fengine.corr.get_new_corr(a1+1, a2)) #yx
        times.append(time.time())
        data.append(np.transpose(corr))

outfilename = os.path.join(args.output, 'snap_correlation_%d.npz'%(times[0]))
logger.info('Output written to %s'%outfilename)
np.savez(outfilename,data=data,polarizations=pols,frequencies=frequencies,
         times=times,ant1_array=ant1_array,ant2_array=ant2_array)
