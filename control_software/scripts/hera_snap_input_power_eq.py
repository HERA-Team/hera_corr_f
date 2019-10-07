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
parser.add_argument('-e', dest='etargetpower', type=float, default=-13.,
                    help ='Target ADC power for E-pol in dBm')
parser.add_argument('-n', dest='ntargetpower', type=float, default=-13.,
                    help ='Target ADC power for N-pol in dBm')
args = parser.parse_args()

corr = HeraCorrelator(redishost=args.redishost, config=args.config_file)

for feng in corr.fengs:
    corr.disable_monitoring(60, wait=True)
    for pn, pam in enumerate(feng.pams):
        ants = feng.ants[2*pn : 2*pn + 2]
        # Start by setting attenuation to zero
        pam.set_attenuation(0, 0)
        time.sleep(0.1) # no idea if this is necessary
        try:
            pow_e = pam.power('east')
            pow_n = pam.power('north')
        except AssertionError:
            logger.error("Failed to read power from antenna %s. Skipping EQ" % ants)
            continue
        if (pow_e is None) or (pow_n is None):
            logger.error("Failed to read power from antenna %s. Skipping EQ" % ants)
            continue
        
        print "Antenna %s power: N: %.2f E: %.2f" % (ants, pow_n, pow_e)
        req_attn_e = int(pow_e - args.etargetpower)
        req_attn_n = int(pow_n - args.ntargetpower)
        if req_attn_e > 15:
            req_attn_e = 15
        elif req_attn_e < 0:
            req_attn_e = 0
        if req_attn_n > 15:
            req_attn_n = 15
        elif req_attn_n < 0:
            req_attn_n = 0
        print "%s:%d Setting attenuation of antenna %s to (E,N):(%d, %d)" % (feng.host, pn, ants, req_attn_e, req_attn_n)
        pam.set_attenuation(req_attn_e, req_attn_n)
        rb_attn_e, rb_attn_n = pam.get_attenuation()
        if rb_attn_e != req_attn_e:
            logger.error("Requested E attenuation %d but read back %d" % (req_attn_e, rb_attn_e))
        if rb_attn_n != req_attn_n:
            logger.error("Requested E attenuation %d but read back %d" % (req_attn_n, rb_attn_n))
    corr.enable_monitoring()
