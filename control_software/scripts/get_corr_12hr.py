#!/usr/bin/env python
import numpy as np
from hera_corr_f import SnapFengine
from hera_corr_f import helpers
from get_corr import get_corr_output
import time
import redis
import logging
import argparse
import os

logger = helpers.add_default_log_handlers(logging.getLogger(__name__))

parser = argparse.ArgumentParser(description='Obtain cross-correlation spectra from a SNAP Board',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('host', type=str, 
                    help='Host boards to collect data from')
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')
parser.add_argument('-n','--num_spectra',type=int,default=10,
                    help='Number of spectra per file')
parser.add_argument('-t', '--integration_time', type=int, default=1,
                    help='Integration time in seconds for each spectra')
parser.add_argument('-o','--output',type=str, default='.',
                    help='Path to destination folder')
args = parser.parse_args()

r = redis.Redis(args.redishost)
r.set('disable_monitoring', 1, ex=60)
logger.warning('Disabling the monitoring.')
time.sleep(2)

NCHAN    = 1024
NPOL     = 4

frequencies = np.arange(NCHAN) * 250e6/NCHAN
pols = range(NPOL)
ant1_array=np.array([[0,0,0,1,1,2] for t in range(args.num_spectra)]).astype(int).flatten()
ant2_array=np.array([[0,1,2,1,2,2] for t in range(args.num_spectra)]).astype(int).flatten()
antenna_pairs = ([[0,0],[0,1],[0,2],[1,1],[1,2],[2,2]])

fengine = SnapFengine(args.host)

while(True):
    try:
        times = []
        data = []
        # Start integrating and collecting data
        for n in range(args.num_spectra):
            for a1, a2 in antenna_pairs:
                r.set('disable_monitoring', 1, ex=60)
                logger.info('Getting baseline pair: (%d, %d)..'%(a1,a2))
                c = get_corr_output(fengine,a1,a2,args.integration_time) 
                times.append(c['times'])
                data.append(np.transpose(c['data']))
        times = np.concatenate(times)
        
        outfilename = os.path.join(args.output, 'snap_correlation_%d.npz'%(times[0]))
        logger.info('Writing output to file: %s'%outfilename)
        np.savez(outfilename,data=data,polarizations=pols,frequencies=frequencies,
                 times=times,ant1_array=ant1_array,ant2_array=ant2_array)

    except KeyboardInterrupt:
        logger.info('Manually interrupted')
        logger.info('Last file written: %s'%outfilename)
        break
