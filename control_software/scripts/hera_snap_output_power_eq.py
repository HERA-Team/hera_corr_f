#! /usr/bin/env python

import argparse
from hera_corr_f import HeraCorrelator, helpers, __version__
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

for feng in corr.fengs:
    for pn, pol in enumerate(feng.ants):
        if pol is None:
            continue
        print "%s: %s:" % (feng.host, pol)
        spec = feng.corr.get_new_corr(pn, pn).real
        print spec[700:710]
        median = np.median(spec)
        print median
        if median == 0.:
            continue
        mean = spec[spec < 2*median].mean()
        print mean
        amp = np.sqrt(mean / 2.)
        print amp
        scale = args.rms / amp
        print scale
        feng.eq.set_coeffs(pn, scale * feng.eq.get_coeffs(pn))
        
        
