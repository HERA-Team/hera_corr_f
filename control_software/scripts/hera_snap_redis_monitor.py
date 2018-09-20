#! /usr/bin/env python
import sys
import time
import datetime
import argparse
import logging
import json
from hera_corr_f import HeraCorrelator
from hera_corr_f import helpers

logger = helpers.add_default_log_handlers(logging.getLogger(__file__))

def get_fpga_stats(feng):
    """
    Get FPGA stats.
    returns: Dictionary of stats
    """
    stat = {}
    stat['temp'] = feng.fpga.transport.get_temp()
    stat['timestamp'] = datetime.datetime.now().isoformat()
    stat['uptime'] = feng.sync.uptime()
    stat['pps_count'] = feng.sync.count()
    stat['serial'] = feng.serial
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

    corr = HeraCorrelator(redishost=args.redishost)
    upload_time = corr.r.hget('snap_configuration', 'upload_time')

    while(True):
        tick = time.time()
        while corr.r.exists('disable_monitoring'):
            logger.warning('Monitoring locked out. Waiting 10 seconds and retrying')
            time.sleep(10)
    
        # Check for a new configuration, and if one exists, update the Fengine list
        if corr.r.hget('snap_configuration', 'upload_time') != upload_time:
            upload_time = corr.r.hget('snap_configuration', 'upload_time')
            logger.info('New configuration detected. Reinitializing fengine list')
            corr = HeraCorrelator(redishost=args.redishost)
        
        # Recompute the hookup every time. It's fast
        corr.compute_hookup()

        for ant, antval in corr.ant_to_snap.iteritems():
            for pol, polval in antval.iteritems():
                status_key = 'status:ant:%s:%s' % (ant, pol)
                feng = polval['host']
                chan = polval['channel']
                corr.r.hmset(status_key, {'f_host':feng.host, 'host_ant_id':chan})
                means, powers, rmss = feng.input.get_stats(sum_cores=True)
                mean = means[chan]
                power = powers[chan]
                rms   = rmss[chan]
                corr.r.hmset(status_key, {'adc_mean':mean, 'adc_power':power, 'adc_rms':rms})
                hist_bins, hist_vals = feng.input.get_histogram(chan, sum_cores=True)
                corr.r.hset(status_key, 'histogram', json.dumps([hist_bins.tolist(), hist_vals.tolist()]))
                corr.r.hset(status_key, 'timestamp', datetime.datetime.now().isoformat())

        for feng in corr.fengs:
            corr.r.hmset("status:snap:%s" % feng.host, get_fpga_stats(feng))
                
        # If executing the loop hasn't already taken longer than the loop delay time, add extra wait.
        extra_delay = args.delay - (time.time() - tick)
        if extra_delay > 0:
            time.sleep(extra_delay)
