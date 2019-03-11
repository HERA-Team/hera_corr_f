#! /usr/bin/env python
import sys
import os
import time
import datetime
import argparse
import logging
import json
from hera_corr_f import HeraCorrelator, SnapFengine, __version__, __package__, helpers

logger = helpers.add_default_log_handlers(logging.getLogger(__file__))
FAIL_COUNT_LIMIT = 5


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
            # Skip if the antenna is associated with a board we can't reach
            if polval['host'] in corr.dead_fengs.keys():
                logger.warning("Won't get data from Ant %s, Pol %s because host %s is dead" % (ant, pol, polval['host']))
                continue
            else:
                if isinstance(polval['host'], SnapFengine):
                    host = polval['host'].host # the dictionary contains FEngine instances
                    chan = polval['channel']
                    logger.info("Expecting data from Ant %s, Pol %s from host %s input %d" % (ant, pol, host, chan))
                else:
                    logger.warning("Failed to find F-Engine %s associated with ant/pol %s/%s" % (polval['host'], ant, pol))

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
    parser.add_argument('-l', dest='loglevel', type=str, default="INFO",
                        help ='Log level. DEBUG / INFO / WARNING / ERROR')
    args = parser.parse_args()

    if args.loglevel not in ["DEBUG", "INFO", "WARNING", "ERROR"]:
        logger.error("I don't undestand log level %s" % args.loglevel)
    else:
        for handler in logger.handlers:
            handler.setLevel(getattr(logging, args.loglevel))
       

    corr = HeraCorrelator(redishost=args.redishost)
    upload_time = corr.r.hget('snap_configuration', 'upload_time')
    print_ant_log_messages(corr)

    retry_tick = time.time()
    script_redis_key = "status:script:%s" % __file__
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

        # load this module's version into redis
        corr.r.hmset('version:%s:%s' % (__package__, os.path.basename(__file__)), {'version':__version__, 'timestamp':datetime.datetime.now().isoformat()})

        # Get antenna stats
        input_stats = corr.do_for_all_f("get_stats", block="input", kwargs={"sum_cores" : True})
        histograms = []
        eq_coeffs = []
        for i in range(6):
            histograms += [corr.do_for_all_f("get_histogram", block="input", args=(i,), kwargs={"sum_cores" : True})]
            eq_coeffs += [corr.do_for_all_f("get_coeffs", block="eq", args=(i,))]
        pam_east_powers = []
        pam_north_powers = []
        pam_attens = []
        for i in range(3):
            pam_east_powers += [corr.do_for_all_f("power", block="pams", block_index=i, kwargs={"name":"east"})]
            pam_north_powers += [corr.do_for_all_f("power", block="pams", block_index=i, kwargs={"name":"north"})]
            pam_attens += [corr.do_for_all_f("get_attenuation", block="pams", block_index=i)]
       
        for key, val in input_stats.iteritems():
            antpols = corr.fengs_by_name[key].ants
            means, powers, rmss = val
            for antn, antpol in enumerate(antpols):
                # Don't report inputs which aren't connected
                if antpol is None:
                    continue
                ant, pol = helpers.hera_antpol_to_ant_pol(antpol)
                status_key = 'status:ant:%s:%s' % (ant, pol)
                mean  = means[antn]
                power = powers[antn]
                rms   = rmss[antn]
                redis_vals = {'adc_mean':mean, 'adc_power':power, 'adc_rms':rms}
                try:
                    hist_bins, hist_vals = histograms[antn][key]
                    redis_vals['histogram'] = json.dumps([hist_bins.tolist(), hist_vals.tolist()])
                except:
                    redis_vals['histogram'] = None
                try:
                    coeffs = eq_coeffs[antn][key]
                    redis_vals['eq_coeffs'] = json.dumps(coeffs.tolist())
                except:
                    redis_vals['eq_coeffs'] = None
                if pol == 'e':
                    try:
                        redis_vals['pam_power'] = pam_east_powers[antn][key]
                    except:
                        redis_vals['pam_power'] = None
                else:
                    try:
                        redis_vals['pam_power'] = pam_north_powers[antn][key]
                    except:
                        redis_vals['pam_power'] = None
                try:
                    atten_e, atten_n = pam_attens[antn][key]
                    if pol == 'e':
                        atten = atten_e
                    else:
                        atten = atten_n 
                    redis_vals['pam_atten'] = atten
                except:
                    redis_vals['pam_atten'] = None
                redis_vals['timestamp'] = datetime.datetime.now().isoformat()
                corr.r.hmset(status_key, redis_vals)
            
        # Get FPGA stats
        fpga_stats = corr.do_for_all_f("get_fpga_stats")
        for key, val in fpga_stats.iteritems():
            corr.r.hmset("status:snap:%s" % key, val) 
        
        # If the retry period has been exceeded, try to reconnect to dead boards:
        if time.time() > (retry_tick + args.retrytime):
            if len(corr.dead_fengs) > 0:
                logger.info('Trying to reconnect to dead boards')
                corr.reestablish_dead_connections()
                retry_tick = time.time()
                
        # If executing the loop hasn't already taken longer than the loop delay time, add extra wait.
        extra_delay = args.delay - (time.time() - tick)
        if extra_delay > 0:
            logger.debug("Sleeping for %.2f seconds" % extra_delay)
            time.sleep(extra_delay)
