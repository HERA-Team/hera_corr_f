#! /usr/bin/env python

import argparse
from hera_corr_f import HeraCorrelator, SnapFengine, helpers, __version__
import numpy as np
import struct
import collections
import time
import yaml
import logging

logger = helpers.add_default_log_handlers(logging.getLogger(__file__))

parser = argparse.ArgumentParser(description='Interact with a programmed SNAP board for testing and '\
                                 'networking. FLAGS OVERRIDE CONFIG FILE!',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('--config_file', type=str, default=None,
                    help = 'YAML configuration file with hosts and channels list')
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')
parser.add_argument('--rms', dest='rms', type=float, default=3.,
                    help ='Target RMS after quantization')
args = parser.parse_args()

corr = HeraCorrelator(redishost=args.redishost, config=args.config_file)

n_loop_max = 4

for ant, snap in corr.ant_to_snap.iteritems():
    corr.disable_monitoring(expiry=60, wait=True)
    for pol, snap_chan in snap.iteritems():
        print("Equalizing %s:%s" % (ant, pol))
        corr.disable_monitoring(expiry=30)
        feng = snap_chan['host']
        # feng can just be a string hostname if the SNAP board isn't connected
        if not isinstance(feng, SnapFengine):
            continue
        if not feng.is_programmed():
            continue
        chan = snap_chan['channel']
        #print "%s: %s:" % (feng.host, pol)
        # Get an autocorrelation (pure real)
        for i in range(n_loop_max):
            spec = feng.corr.get_new_corr(chan, chan).real
            #print spec[700:710]
            # Do some trivial rfi excision my masking around the median
            median = np.median(spec)
            print "median:", median
            # If the median is zero then the input is all zeros.
            # Give up and move on to the next input.
            if median == 0.:
                continue
            spec_sliced = spec[np.logical_and(spec < 2*median, spec > 0.5*median)]
            if spec_sliced.shape[0] == 0:
                continue
            mean = spec_sliced.mean()
            print "mean:", mean
            # Assuming gaussian noise, compute std dev of real/imag parts
            rms = np.sqrt(mean / 2.)
            print "rms:", rms
            scale = args.rms / rms
            print "scale:", scale
            if scale == np.nan:
                continue
            if (scale < 1.05) and (scale > 0.95):
                print 'Breaking without updating coefficients'
                break
            corr.set_eq(ant, pol, eq=feng.eq.get_coeffs(chan)*scale)
            #feng.eq.set_coeffs(pn, scale * feng.eq.get_coeffs(pn))
        
corr.enable_monitoring() 
