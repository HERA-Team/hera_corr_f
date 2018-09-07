#! /usr/bin/env python
import sys
import time
import datetime
import argparse
import redis
import logging
import yaml
from hera_corr_f import SnapFengine
from hera_corr_f import helpers

logger = helpers.add_default_log_handlers(logging.getLogger(__file__))

def get_fengs():
    """
    Check redis for the latest config, and connect to listed ROACHs
    returns: time of config file upload, list ofFengine instances
    """
    config_str  = r.hget('snap_configuration', 'config')
    config_time = r.hget('snap_configuration', 'upload_time')
    logger.info('Using configuration from redis, uploaded at %s' % config_time)
    config = yaml.load(config_str)

    fengines = []

    for host in config['fengines'].keys():
        try:
            logger.info('Connecting to SNAP %s' % host)
            fengines += [SnapFengine(host)]
        except:
            logger.warning('Connection to %s failed' % host)
            pass

    return config_time, fengines

def get_fpga_stats():
    """
    Get FPGA stats.
    returns: Dictionary of stats
    """
    stat = {}
    stat['temp'] = fengine.fpga.transport.get_temp()
    stat['timestamp'] = datetime.datetime.now().isoformat()
    return stat

def get_pam_stats():
    """
    Get PAM stats.
    returns: Dictionary of dictionaries
    dict[key1][key2] = value
    where key1 is an antenna name, key2 is a stat type (eg. Power)
    """
    pass

def get_fem_stats():
    """
    Get FEM stats.
    returns: Dictionary of dictionaries
    dict[key1][key2] = value
    where key1 is an antenna name, key2 is a stat type (eg. Power)
    """
    pass


if __name__ == "__main__":
    
    parser = argparse.ArgumentParser(description='Poll running SNAPs for FPGA/PAM/FEM monitoring data',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                        help ='Host servicing redis requests')
    parser.add_argument('-d', dest='delay', type=float, default=10.0,
                        help ='Seconds between polling loops')

    args = parser.parse_args()

    logger.info('Connecting to Redis database on %s' % args.redishost)
    r = redis.Redis(args.redishost)
    
    # Don't do anything if a script is blocking the monitor
    while r.exists('disable_monitoring'):
        logger.warning('Monitoring locked out. Waiting 10 seconds and retrying')
        time.sleep(10)

    upload_time, fengines = get_fengs()
        
    logger.info("Using F-Engines: %r" % [fengine.host for fengine in fengines])

    while(True):
        tick = time.time()
        while r.exists('disable_monitoring'):
            logger.warning('Monitoring locked out. Waiting 10 seconds and retrying')
            time.sleep(10)
    
        # Check for a new configuration, and if one exists, update the Fengine list
        if r.hget('snap_configuration', 'upload_time') > upload_time:
            upload_time, fengines = get_fengs()

        for fn, fengine in enumerate(fengines):
            try:
                r.hmset("status:snap:%s" % fengine.host, get_fpga_stats())
            except:
                logger.warning("Fengine %s failed. Reconnecting" % fengine.host)
                r.hset("status:snap:%s" % fengine.host, "failed-time", datetime.datetime.now().isoformat())
                # if we've failed, try reconnecting to the board:
                fengines[n] = SnapFengine(fengine.host)
                
        # If executing the loop hasn't already taken longer than the loop delay time, add extra wait.
        extra_delay = args.delay - (time.time() - tick)
        if extra_delay > 0:
            time.sleep(extra_delay)
