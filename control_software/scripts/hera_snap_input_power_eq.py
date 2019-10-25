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
group = parser.add_mutually_exclusive_group()
group.add_argument('--epower', type=float, default=None,
                    help ='Target ADC power for E-pol in dBm')
group.add_argument('--erms', type=float, default=None,
                    help ='Target ADC RMS for E-pol in ADC units')
group = parser.add_mutually_exclusive_group()
group.add_argument('--npower', type=float, default=None,
                    help ='Target ADC power for N-pol in dBm')
group.add_argument('--nrms', type=float, default=None,
                    help ='Target ADC RMS for N-pol in ADC units')
args = parser.parse_args()

corr = HeraCorrelator(redishost=args.redishost, config=args.config_file)

for feng in corr.fengs:
    corr.disable_monitoring(60, wait=True)
    for input_n, antenna in enumerate(feng.ants):
        if antenna is None:
            continue
        ant = antenna[:-1].lstrip('HH')
        pol = antenna[-1].lower()
        corr.logger.info("Balancing %s (SNAP %s, input %d)" % (antenna, feng.host, input_n))
        if pol == 'e':
            corr.tune_pam_attenuation(ant, pol, target_pow=args.epower, target_rms=args.erms)
        else:
            corr.tune_pam_attenuation(ant, pol, target_pow=args.npower, target_rms=args.nrms)
