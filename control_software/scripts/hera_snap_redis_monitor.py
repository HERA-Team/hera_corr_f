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
FAIL_COUNT_LIMIT = 5

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
    stat['pmb_alert'] = feng.fpga.read_uint('pmbus_alert')
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

def get_poco_output(feng,redishost):
    """
    Get pocket correlator output. Antennas and integration time 
    polled from redis database.
    Params:  feng: SnapFengine object that maps to a SNAP board
             redishost: Redis database to upload the data to.
    Returns: Dict: {'data':shape(fqs, pols), 
                    'times':list of unix times}
    """
    int_time = int(redishost.hget('poco', 'integration_time'))
    acc_len = int_time * 250e6/ (8192 * feng.corr.spec_per_acc)
    
    if (acc_len != feng.corr.get_acc_len()):
        feng.corr.set_acc_len(acc_len)
  
    antenna_pairs = ([[0,0],[0,1],[0,2],[1,1],[1,2],[2,2]])
    pair = (int(redishost.hget('poco','ant1')), int(redishost.hget('poco','ant2')))
    idx = antenna_pairs.index(pair)
    ant1, ant2 = antenna_pairs[(idx+1)%len(antenna_pairs)]
    redishost.hset('poco','ant1',ant1)
    redishost.hset('poco','ant2',ant2)    

    ant1 *= 2; ant2 *= 2
    xcorr = []; times = []
    for i in range(4):
        xcorr.append(feng.corr.get_new_corr(ant1+i%2, (ant2+(i//2+i%2)%2)))
        times.append(time.time())
    xcorr = np.asarray(xcorr); times = np.asarray(times)
    redishost.hset('poco', 'corr',  xcorr.tostring())
    redishost.hset('poco', 'times', times.tostring())

    # to unpack from string: c = struct.unpack('<8192d'); xcorr = (c[::2] + 1j*c[1::2]).reshape(4,1024)
   
    return {'data':xcorr, 'times':times}
    
def print_ant_log_messages(corr):
    for ant, antval in corr.ant_to_snap.iteritems():
        for pol, polval in antval.iteritems():
            host = polval['host'].host # the dictionary contains FEngine instances
            chan = polval['channel']
            # Skip if the antenna is associated with a board we can't reach
            if polval['host'] in corr.dead_fengs.keys():
                logger.warning("Won't get data from Ant %s, Pol %s because host %s is dead" % (ant, pol, host))
                continue
            else:
                logger.info("Expecting data from Ant %s, Pol %s from host %s input %d" % (ant, pol, host, chan))

if __name__ == "__main__":
    
    parser = argparse.ArgumentParser(description='Poll running SNAPs for FPGA/PAM/FEM monitoring data',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                        help ='Host servicing redis requests')
    parser.add_argument('-d', dest='delay', type=float, default=10.0,
                        help ='Seconds between polling loops')
    parser.add_argument('-c', dest='poco',action='store_true',default=False,
                        help='Upload pocket correlator output to redis')
    parser.add_argument('-D', dest='retrytime', type=float, default=300.0,
                        help ='Seconds between reconnection attempts to dead boards')
    args = parser.parse_args()

    corr = HeraCorrelator(redishost=args.redishost)
    upload_time = corr.r.hget('snap_configuration', 'upload_time')
    print_ant_log_messages(corr)

    retry_tick = time.time()
    script_redis_key = "status:script:%s" % __file__
    fail_count = {} # Track board failures to decide when to declare a board dead
    while(True):
        tick = time.time()
        corr.r.set(script_redis_key, "alive", ex=max(60, args.delay * 2))
        while corr.r.exists('disable_monitoring'):
            logger.warning('Monitoring locked out. Waiting 10 seconds and retrying')
            corr.r.set(script_redis_key, "locked out", ex=20)
            time.sleep(10)
    
        # Check for a new configuration, and if one exists, update the Fengine list
        if corr.r.hget('snap_configuration', 'upload_time') != upload_time:
            upload_time = corr.r.hget('snap_configuration', 'upload_time')
            logger.info('New configuration detected. Reinitializing fengine list')
            corr = HeraCorrelator(redishost=args.redishost)
            print_ant_log_messages(corr)
        
        # Recompute the hookup every time. It's fast
        corr.compute_hookup()

        for ant, antval in corr.ant_to_snap.iteritems():
            for pol, polval in antval.iteritems():
                status_key = 'status:ant:%s:%s' % (ant, pol)
                feng = polval['host']
                chan = polval['channel']
                # Skip if the antenna is associated with a board we can't reach
                if feng in corr.dead_fengs.keys():
                    continue
                try:
                    corr.r.hmset(status_key, {'f_host':feng.host, 'host_ant_id':chan})
                    means, powers, rmss = feng.input.get_stats(sum_cores=True)
                    mean = means[chan]
                    power = powers[chan]
                    rms   = rmss[chan]
                    corr.r.hmset(status_key, {'adc_mean':mean, 'adc_power':power, 'adc_rms':rms})
                    hist_bins, hist_vals = feng.input.get_histogram(chan, sum_cores=True)
                    corr.r.hset(status_key, 'histogram', json.dumps([hist_bins.tolist(), hist_vals.tolist()]))
                    corr.r.hset(status_key, 'timestamp', datetime.datetime.now().isoformat())

                    if args.poco:
                        get_poco_output(feng,corr.r)
                        
                    # If this was all successful, reset the fail counter
                    fail_count[feng.host] = 0
                except KeyboardInterrupt:
                    exit()
                except:
                    logger.error('Failed to get stats for ant %s pol %s (feng %s, chan %s)' % (ant, pol, feng.host, chan))
                    count = fail_count.get(feng.host, 0)
                    fail_count[feng.host] = count + 1
                    logger.info('New fail count for SNAP %s is %d' % (feng.host, fail_count[feng.host]))
                    if fail_count[feng.host] > FAIL_COUNT_LIMIT:
                        logger.error('Declaring board %s bad' % feng.host)
                        corr.declare_feng_dead(feng)
                        fail_count[feng.host] = 0

        for feng in corr.fengs:
            # Skip if the fengine is associated with a board we can't reach
            if feng.host in corr.dead_fengs.keys():
                continue
            try:
                corr.r.hmset("status:snap:%s" % feng.host, get_fpga_stats(feng))
                fail_count[feng.host] = 0
            except KeyboardInterrupt:
                exit()
            except:
                count = fail_count.get(feng.host, 0)
                fail_count[feng.host] = count + 1
                # Issue warnings only if this is the second (or more) consecutive failure.
                if fail_count[feng.host] > 1:
                    logger.warning('Failed to get stats from SNAP %s' % feng.host)
                    logger.info('New fail count for SNAP %s is %d' % (feng.host, fail_count[feng.host]))
                if fail_count[feng.host] > FAIL_COUNT_LIMIT:
                    logger.error('Declaring board %s bad' % feng.host)
                    corr.declare_feng_dead(feng)
                    fail_count[feng.host] = 0

        # If the retry period has been exceeded, try to reconnect to dead boards:
        if time.time() > (retry_tick + args.retrytime):
            if len(corr.dead_fengs) > 0:
                logger.info('Trying to reconnect to dead boards')
                corr.reestablish_dead_connections()
                retry_tick = time.time()
                
        # If executing the loop hasn't already taken longer than the loop delay time, add extra wait.
        extra_delay = args.delay - (time.time() - tick)
        if extra_delay > 0:
            time.sleep(extra_delay)
