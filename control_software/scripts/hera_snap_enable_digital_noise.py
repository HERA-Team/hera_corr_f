#! /usr/bin/env python

import argparse
from hera_corr_f import HeraCorrelator, __version__
from hera_corr_cm import handlers
import redis
import time
import yaml
import logging
import json

TIMEOUT = 10
NTRIES = 3

def main():
    parser = argparse.ArgumentParser(description='Interact with a programmed SNAP board to '
                                     'change digital data source (ADC or NOISE).',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--hosts', type=str, nargs='+', default=None,
                        help='Specific SNAPs to run on')
    parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                        help='Host servicing redis requests')
    parser.add_argument('--source',choices=['adc','noise'], required=True)
    args = parser.parse_args()

    logger = handlers.add_default_log_handlers(logging.getLogger(__file__))
    handlers.log_notify(logger)  # send a NOTIFY level message that this script has started

    corr = HeraCorrelator(hosts=args.hosts, redishost=args.redishost)
    try:
        if len(corr.fengs) == 0:
            logger.error("No F-Engines are connected. Is the power off?")
            return
    	init_time = time.time()
        snap_failed = corr.set_input_fengs(source=args.source)
    	if len(snap_failed) > 0:
    	    logger.warn('SNAP initialization failed: %s' % (','.join(snap_failed)))
    except(AssertionError) as e:
        logger.error('FAILURE!\n' + e.message)
if __name__ == "__main__":
    main()
