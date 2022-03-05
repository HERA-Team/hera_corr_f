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
                                     'change FEM switch state.',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--hosts', type=str, nargs='+', default=None,
                        help='Specific SNAPs to run on')
    parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                        help='Host servicing redis requests')
    parser.add_argument('--state',choices=['antenna','noise','load'], required=True)
    args = parser.parse_args()

    logger = handlers.add_default_log_handlers(logging.getLogger(__file__))
    handlers.log_notify(logger)  # send a NOTIFY level message that this script has started

    corr = HeraCorrelator(hosts=args.hosts, redishost=args.redishost)
    try:
        if len(corr.fengs) == 0:
            logger.error("No F-Engines are connected. Is the power off?")
            return
    	#TODO communicate what we do to redis which is in turn monitored by M&C
    	init_time = time.time()
    	fem_failed = corr.switch_fems(args.state)
    	if len(fem_failed) > 0:
    	    logger.warn('FEM initialization failed: %s' % (','.join(fem_failed)))
    	corr.r.hmset('corr:fem_switch_state',{'state':args.state,'time':init_time})
    except(AssertionError) as e:
        logger.error('FAILURE!\n' + e.message)
if __name__ == "__main__":
    main()
