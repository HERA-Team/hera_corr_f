#!/usr/bin/env python
import numpy as np
from hera_corr_f import SnapFengine
from hera_corr_f import helpers
from hera_corr_f import HeraCorrelator
from astropy.time import Time
import time
import redis
import logging
import argparse
import os
import json
import yaml

logger = helpers.add_default_log_handlers(logging.getLogger(__name__), fglevel=logging.NOTSET)

parser = argparse.ArgumentParser(description='Obtain cross-correlation spectra from a SNAP Board',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('host',type=str,
                    help='Host board to program')
#parser.add_argument('config_file', type=str, 
#                    help='Configuration yaml file with hostboards and pols')
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')
parser.add_argument('-n','--num_spectra',type=int,default=10,
                    help='Number of spectra per file')
parser.add_argument('-t', '--integration_time', type=int, default=1,
                    help='Integration time in seconds for each spectra')
parser.add_argument('-o','--output',type=str, default='.',
                    help='Path to destination folder')
parser.add_argument('-f','--files', type=int, default=0,
                    help='Total number of files to write.')
args = parser.parse_args()

corr = HeraCorrelator(redishost=args.redishost)
corr.r.set('disable_monitoring', 1, ex=60)
logger.warning('Disabling the monitoring.')
time.sleep(2)

#with open(args.config_file,'r') as fp:
#    config = yaml.safe_load(fp)

#feng = {}
#for host in config.keys():
#    feng[host] = SnapFengine(args.host)

# Get antenna numbers from database
#corr.compute_hookup()
#ants = corr.snap_to_ant[argsg.host]

fqs = np.arange(feng.corr.nchans) * 250e6/feng.corr.nchans

# Mapping: 1x,1y,2x,2y,3x,3y = 0,1,2,3,4,5
cycle_pols = [(0,0),(1,1)]#,(2,2),(3,3),(4,4),(5,5)]

acc_len = int((args.integration_time*250e6)/\
              (8*feng.corr.nchans*feng.corr.spec_per_acc))
if not acc_len == feng.corr.get_acc_len():
    feng.corr.set_acc_len(acc_len)
corr.r.hset('poco','int_time_sec',args.integration_time)
corr.r.hset('poco','acc_len',acc_len)

first_run = 1
feng.corr.set_input(0,0)
feng.corr.wait_for_acc()

Nfiles = 0
recorded_pols =[]

while(Nfiles < args.files):
    try:
        times = []; avg = []; max_hold = []
        # Start integrating and collecting data
        for n in range(args.num_spectra):
            cmxhld = []; cavg = []
            for idx in range(len(cycle_pols)):
                a1,a2 = cycle_pols[idx]
                recorded_pols.append((a1,a2))
                next_a1, next_a2 = cycle_pols[(idx+1)%len(cycle_pols)]
                feng.corr.set_input(next_a1, next_a2)
                bram = feng.corr.read_bram()
                #logger.info('Getting baseline pair: (%d, %d)..'%(a1,a2)) 
                t = time.time()
                times.append(t)
                corr.r.hset('poco','timestamp',t)
                # Get avg
                bram.real = bram.real/float(feng.corr.acc_len*feng.corr.spec_per_acc)
                cavg.append(bram.real); cmxhld.append(bram.imag)
                corr.r.hset('poco','max_hold_%d'%a1,json.dumps(bram.imag.tolist()))
            avg.append(np.transpose(cavg))
            max_hold.append(np.transpose(cmxhld))
        
        ant1_array = [a[0] for a in recorded_pols]
        ant2_array = [a[1] for a in recorded_pols]
        jd = Time(times[0],format='unix')
        outfilename = os.path.join(args.output, 'maint.20181205.%7.7f.karoo.max_hold.npz'%(jd.jd))
        logger.info('Time: %s'%jd.to_datetime())
        logger.info('Writing output to file: %s'%outfilename)
        np.savez(outfilename, source=args.host, average=avg,\
                 max_hold=max_hold, frequencies=fqs,\
                 times=times, ant1_array=ant1_array, ant2_array=ant2_array)
        Nfiles += 1
        #time.sleep(900)
 
    except KeyboardInterrupt:
        logger.info('Manually interrupted')
        logger.info('Last file written: %s'%outfilename)
        break

#    except:
#        logger.info('Will try again in two minutes')
#        logger.info('Last file written: %s'%outfilename)
#        break
#
#    except:
#        logger.info('Will try again in two minutes')
#        time.sleep(120); cnt = 0
#        print 'Entering loop trying'
#        while cnt < 20:
#            try:
#                print cnt
#                feng = SnapFengine(args.host)
#                if feng.fpga.is_connected(): 
#                    print 'Got connection!'
#                    break
#            except: 
#                logger.info('Still cannot connect. Wait one more minute')
#                time.sleep(60)
#                cnt += 1
