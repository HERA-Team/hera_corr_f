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
args = parser.parse_args()

corr = HeraCorrelator(redishost=args.redishost, config=args.config_file)

for feng in corr.fengs:
    for pn, pam in enumerate(feng.pams):
        ants = feng.ants[2*pn : 2*pn + 2]
        try:
            pow_e = pam.power('east')
            pow_n = pam.power('north')
        except AssertionError:
            logger.error("Failed to read power from antenna %s. Skipping EQ" % ants)
            continue
        
        print "Antenna %s power: %.2f" % (ants[0], pow_e)
        print "Antenna %s power: %.2f" % (ants[1], pow_n)
