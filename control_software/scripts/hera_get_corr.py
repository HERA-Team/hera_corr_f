#!/usr/bin/env python
import numpy as np
from hera_corr_f import SnapFengine
from hera_corr_f import helpers
from hera_corr_f import HeraCorrelator
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
parser.add_argument('-c','--cc', nargs=2, action='append', type=int, default=None,
                    help='List of cross-correlations. None defaults to all.')
parser.add_argument('-o','--output',type=str, default='.',
                    help='Path to destination folder')
parser.add_argument('-f','--files',type=int, default=1,
                    help='Total number of files to write. Runs until KeyboardInterrupt otherwise.')
args = parser.parse_args()

corr = HeraCorrelator(redishost=args.redishost)
corr.r.set('disable_monitoring', 1, ex=60)
logger.warning('Disabling the monitoring.')
time.sleep(2)

feng = SnapFengine(args.host)

# Get antenna numbers from database
#corr.compute_hookup()
#ants = corr.snap_to_ant[argsg.host]

fqs = np.arange(feng.corr.nchans) * 250e6/feng.corr.nchans
pols = range(4)
ant1_array=np.array([[0,0,0,1,1,2] for t in range(args.num_spectra)]).astype(int).flatten()
ant2_array=np.array([[0,1,2,1,2,2] for t in range(args.num_spectra)]).astype(int).flatten()

# Mapping: 1x,1y,2x,2y,3x,3y = 0,1,2,3,4,5
if args.cc is None:
    cycle_pols = [(0,0),(1,1),(0,1),(0,2),(1,3),(0,3),(1,2),
                  (0,4),(1,5),(0,5),(1,4),(2,2),(3,3),(2,3),
                  (2,4),(3,5),(2,5),(3,4),(4,4),(5,5),(4,5)]
else:
    cycle_pols = args.cc

acc_len = int(args.integration_time*250e6 // (feng.corr.nchans*feng.corr.spec_per_acc))
if not acc_len == feng.corr.get_acc_len():
    feng.corr.set_acc_len(acc_len)

first_run = 1
feng.corr.set_input(0,0)
feng.corr.wait_for_acc()

Nfiles = 0

while(Nfiles < args.files):
    try:
        times = []
        data = []
        # Start integrating and collecting data
        for n in range(args.num_spectra):
            c = []
            for idx in range(len(cycle_pols)):
                a1,a2 = cycle_pols[idx]
                next_a1, next_a2 = cycle_pols[(idx+1)%len(cycle_pols)]
                feng.corr.set_input(next_a1, next_a2)
                bram = feng.corr.read_bram()
                logger.info('Getting baseline pair: (%d, %d)..'%(a1,a2)) 
                times.append(time.time())
                if a1 == a2:
                   bram.imag = 0; bram.real = bram.real/float(feng.corr.acc_len*feng.corr.spec_per_acc)
                else:
                   bram = bram/float(feng.corr.acc_len*feng.corr.spec_per_acc)  
                c.append(bram)
            data.append(np.transpose(c))
        
        outfilename = os.path.join(args.output, 'snap_correlation_%d.npz'%(times[0]))
        logger.info('Writing output to file: %s'%outfilename)
        np.savez(outfilename, source=args.host, data=data,\
                 polarizations=pols,frequencies=fqs,\
                 times=times,ant1_array=ant1_array,ant2_array=ant2_array)
        Nfiles += 1
 
    except KeyboardInterrupt:
        logger.info('Manually interrupted')
        logger.info('Last file written: %s'%outfilename)
        break

    except:
        logger.info('Will try again in two minutes')
        time.sleep(120); cnt = 0
        while cnt < 20:
            try: 
                feng = SnapFengine(args.host)
                if feng.fpga.is_connected(): break
            except: 
                logger.info('Still cannot connect. Wait two more minutes')
                time.sleep(60)
                cnt += 1
                continue
        if cnt>=20: 
           logger.error('Tried 20 times. Done.')
           exit()
        else: continue
