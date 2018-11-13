#!/usr/env python
from hera_corr_f import SnapFengine
from hera_corr_f import HeraCorrelator
from hera_corr_f import helpers
import logging
import redis
import numpy as np
import argparse 
import time
import os

def get_corr_output(feng, ant1, ant2, int_time=10):

    feng.corr.set_input(ant1*2,ant2*2)
    feng.wait_for_acc()
    # Set integration length
    acc_len = int((int_time*250e6)/(8*feng.corr.nchans*feng.corr.spec_per_acc))
    if not acc_len == feng.corr.get_acc_len():
        feng.corr.set_acc_len(acc_len)

    ant1*= 2; ant2*= 2;
    corr = []; times = []
    time.sleep(1)
    for i in range(4):
        feng.corr.set_input(ant1+i%2, (ant2+(i//2+i%2)%2))
        corr.append(feng.corr.read_bram())
        times.append(time.time())
    
    return {'times':times,'data':corr}
    

if __name__ == "__main__":

    logger = helpers.add_default_log_handlers(logging.getLogger(__name__))

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
    
        
    r = redis.Redis(args.redishost)
    r.set('disable_monitoring', 1, ex=60)
    logger.warning('Disabling the monitoring. Use poco option in monitoring if you want both.')
    time.sleep(2)
    
    NCHAN    = 1024
    NPOL     = 4

    frequencies = np.arange(NCHAN) * 250e6/NCHAN
    pols = range(NPOL)
    ant1_array=np.array([[0,0,0,1,1,2] for t in range(args.num_spectra)]).astype(int).flatten()
    ant2_array=np.array([[0,1,2,1,2,2] for t in range(args.num_spectra)]).astype(int).flatten()
    antenna_pairs = ([[0,0],[0,1],[0,2],[1,1],[1,2],[2,2]])

    fengine = SnapFengine(args.host)
    
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
