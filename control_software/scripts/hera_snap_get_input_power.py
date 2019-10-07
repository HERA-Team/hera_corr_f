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
args = parser.parse_args()

corr = HeraCorrelator(redishost=args.redishost, config=args.config_file)

for feng in corr.fengs:
    corr.disable_monitoring(30, wait=True)
    for pn, pam in enumerate(feng.pams):
        ants = feng.ants[2*pn : 2*pn + 2]
        try:
            pow_e = pam.power('east')
            pow_n = pam.power('north')
        except AssertionError:
            logger.error("Failed to read power from antenna %s. Skipping EQ" % ants)
            continue
        att_e, att_n = pam.attenuation()
        print "Antenna %s power: N: %.2f (attenuation %d dB) E: %.2f (attenuation %d dB)" % (ants, pow_n, att_n, pow_e, att_e)

corr.enable_monitoring(30, wait=True)
