#! /usr/bin/env python
import sys
import os
import time
import datetime
import argparse
import logging
import json
import socket
from hera_corr_f import HeraCorrelator, SnapFengine, __version__, __package__, helpers

logger = helpers.add_default_log_handlers(logging.getLogger(__file__))
FAIL_COUNT_LIMIT = 5

hostname = socket.gethostname()


def get_all_pam_stats(corr):
    """
    Get PAM stats.
    returns: Dictionary of dictionaries
    dict[key1][key2][key3] = value
    where key1 is an antenna name, key2 is a polarization, key3 is a stat type (eg. "pam_power")
    """
    rv = {}
    sensors = {}
    sensors["pam_east_powers"]  = []
    sensors["pam_north_powers"] = []
    sensors["pam_attens"]       = []
    sensors["pam_voltages"]     = []
    sensors["pam_currents"]     = []
    sensors["pam_ids"]          = []
    for i in range(3):
        sensors["pam_east_powers"]  += [corr.do_for_all_f("power", block="pams", block_index=i, kwargs={"name":"east"})]
        sensors["pam_north_powers"] += [corr.do_for_all_f("power", block="pams", block_index=i, kwargs={"name":"north"})]
        sensors["pam_attens"]       += [corr.do_for_all_f("get_attenuation", block="pams", block_index=i)]
        sensors["pam_voltages"]     += [corr.do_for_all_f("shunt", block="pams", block_index=i, kwargs={"name":"u"})]
        sensors["pam_currents"]     += [corr.do_for_all_f("shunt", block="pams", block_index=i, kwargs={"name":"i"})]
        sensors["pam_ids"]          += [corr.do_for_all_f("id", block="pams", block_index=i)]
    
    for feng in corr.fengs:
        for antn, antpol in enumerate(feng.ants):
            if antpol is None:
                continue
            try:
               host = feng.host
            except:
               continue
            ant, pol = helpers.hera_antpol_to_ant_pol(antpol)
            if ant not in rv.keys():
                rv[ant] = {"e":{}, "n":{}}

            block_index = antn // 2
            if pol == "e":
                try:
                    rv[ant][pol]["pam_power"] = sensors["pam_east_powers"][block_index][host]
                except KeyError:
                    rv[ant][pol]["pam_power"] = None
                try:
                    rv[ant][pol]["pam_atten"] = sensors["pam_attens"][block_index][host][0]
                except KeyError:
                    rv[ant][pol]["pam_atten"] = None
            elif pol == "n":
                try:
                    rv[ant][pol]["pam_power"] = sensors["pam_north_powers"][block_index][host]
                except KeyError:
                    rv[ant][pol]["pam_power"] = None
                try:
                    rv[ant][pol]["pam_atten"] = sensors["pam_attens"][block_index][host][1]
                except KeyError:
                    rv[ant][pol]["pam_atten"] = None
            
            try:
                rv[ant][pol]["pam_voltage"] = sensors["pam_voltages"][block_index][host]
            except KeyError:
                rv[ant][pol]["pam_voltage"] = None
            try:
                rv[ant][pol]["pam_current"] = sensors["pam_currents"][block_index][host]
            except KeyError:
                rv[ant][pol]["pam_current"] = None
            try:
                rv[ant][pol]["pam_id"] = sensors["pam_ids"][block_index][host]
            except KeyError:
                rv[ant][pol]["pam_id"] = None
    return rv

def get_all_fem_stats(corr):
    """
    Get FEM stats.
    returns: Dictionary of dictionaries
    dict[key1][key2][key3] = value
    where key1 is an antenna name, key2 is a polarization, key3 is a stat type (eg. "fem_power")
    """
    rv = {}
    sensors = {}
    sensors["fem_switches"] = []
    sensors["fem_temps"]    = []
    sensors["fem_currents"] = []
    sensors["fem_voltages"] = []
    sensors["fem_ids"]      = []
    sensors["fem_imu"]      = []
    for i in range(3):
        sensors["fem_switches"] += [corr.do_for_all_f("switch", block="fems", block_index=i)]
        sensors["fem_temps"]    += [corr.do_for_all_f("temperature", block="fems", block_index=i)]
        sensors["fem_currents"] += [corr.do_for_all_f("shunt", block="fems", block_index=i, kwargs={"name":"i"})]
        sensors["fem_voltages"] += [corr.do_for_all_f("shunt", block="fems", block_index=i, kwargs={"name":"u"})]
        sensors["fem_ids"]      += [corr.do_for_all_f("id", block="fems", block_index=i)]
        sensors["fem_imu"]      += [corr.do_for_all_f("imu", block="fems", block_index=i)]
    
    for feng in corr.fengs:
        for antn, antpol in enumerate(feng.ants):
            if antpol is None:
                continue
            try:
               host = feng.host
            except:
               continue
            ant, pol = helpers.hera_antpol_to_ant_pol(antpol)
            if ant not in rv.keys():
                rv[ant] = {"e":{}, "n":{}}

            block_index = antn // 2
            try:
                if sensors["fem_switches"][block_index][host] is None:
                    switch_state = None
                    e_powered = None
                    n_powered = None
                else:
                    switch_state, e_powered, n_powered = sensors["fem_switches"][block_index][host]
                rv[ant][pol]["fem_switch"] = switch_state
                rv[ant][pol]["fem_e_lna_power"]  = e_powered
                rv[ant][pol]["fem_n_lna_power"]  = n_powered
            except KeyError:
                rv[ant][pol]["fem_switch"] = None
                rv[ant][pol]["fem_e_lna_power"]  = None
                rv[ant][pol]["fem_n_lna_power"]  = None
            try:
                rv[ant][pol]["fem_temp"] = sensors["fem_temps"][block_index][host]
            except KeyError:
                rv[ant][pol]["fem_temp"] = None
            try:
                rv[ant][pol]["fem_current"] = sensors["fem_currents"][block_index][host]
            except KeyError:
                rv[ant][pol]["fem_current"] = None
            try:
                rv[ant][pol]["fem_voltage"] = sensors["fem_voltages"][block_index][host]
            except KeyError:
                rv[ant][pol]["fem_voltage"] = None
            try:
                rv[ant][pol]["fem_id"] = sensors["fem_ids"][block_index][host]
            except KeyError:
                rv[ant][pol]["fem_id"] = None
            try:
                rv[ant][pol]["fem_imu_theta"], rv[ant][pol]["fem_imu_phi"] = sensors["fem_imu"][block_index][host]
            except KeyError:
                rv[ant][pol]["fem_imu_theta"], rv[ant][pol]["fem_imu_phi"] = None, None
    return rv


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
                    logger.debug("Expecting data from Ant %s, Pol %s from host %s input %d" % (ant, pol, host, chan))
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
    parser.add_argument('--noredistapcp', action='store_true',
                        help='Don\'t use the redis-based SNAP comms protocol')
    args = parser.parse_args()

    if args.loglevel not in ["DEBUG", "INFO", "WARNING", "ERROR"]:
        logger.error("I don't undestand log level %s" % args.loglevel)
    else:
        for handler in logger.handlers:
            handler.setLevel(getattr(logging, args.loglevel))
       

    corr = HeraCorrelator(redishost=args.redishost, use_redis=(not args.noredistapcp), block_monitoring=False)
    upload_time = corr.r.hget('snap_configuration', 'upload_time')
    print_ant_log_messages(corr)

    retry_tick = time.time()
    script_redis_key = "status:script:%s:%s" % (hostname, __file__)
    locked_out = False
    logger.info('Starting SNAP redis monitor')
    while(True):
        tick = time.time()
        corr.r.set(script_redis_key, "alive", ex=max(60, args.delay * 2))
        while corr.r.exists('disable_monitoring'):
            if not locked_out:
                logger.warning('Monitoring locked out. Retrying every 10 seconds')
                locked_out = True
            corr.r.set(script_redis_key, "locked out", ex=20)
            time.sleep(10)
        if locked_out:
            logger.warning('Monitoring unlocked')
            locked_out = False
    
        # Check for a new configuration, and if one exists, update the Fengine list
        if corr.r.hget('snap_configuration', 'upload_time') != upload_time:
            upload_time = corr.r.hget('snap_configuration', 'upload_time')
            logger.info('New configuration detected. Reinitializing fengine list')
            corr = HeraCorrelator(redishost=args.redishost, use_redis=(not args.noredistapcp), block_monitoring=False)
            print_ant_log_messages(corr)
        
        # Recompute the hookup every time. It's fast
        corr.compute_hookup()

        # load this module's version into redis
        corr.r.hmset('version:%s:%s' % (__package__, os.path.basename(__file__)), {'version':__version__, 'timestamp':datetime.datetime.now().isoformat()})

        # Get antenna stats
        input_stats = corr.do_for_all_f("get_stats", block="input", kwargs={"sum_cores" : True})
        if corr.r.exists('disable_monitoring'):
            continue
        histograms = []
        eq_coeffs = []
        autocorrs = []
        for i in range(6):
            if corr.r.exists('disable_monitoring'):
                continue
            histograms += [corr.do_for_all_f("get_input_histogram", block="input", args=(i,))]
            eq_coeffs += [corr.do_for_all_f("get_coeffs", block="eq", args=(i,))]
            autocorrs += [corr.do_for_all_f("get_new_corr", block="corr", args=(i,i))]
        # We only detect overflow once per FPGA (not per antenna).
        # Get the overflow flag and reset it
        fft_of = corr.do_for_all_f("is_overflowing", block="pfb")
        corr.do_for_all_f("rst_stats", block="pfb")

        # Get FEM/PAM sensor values
        fem_stats = get_all_fem_stats(corr)
        if corr.r.exists('disable_monitoring'):
            continue
        pam_stats = get_all_pam_stats(corr)
        if corr.r.exists('disable_monitoring'):
            continue

        # Write spectra to snap-indexed keys. This means we'll get spectra even from
        # unconnected (according to the CM database) antennas
        for snap in histograms[0].keys():
           for antn in range(6):
               status_key = 'status:snaprf:%s:%d' % (snap, antn)
               snap_rf_stats = {}
               try:
                   hist_bins, hist_vals = histograms[antn][snap]
                   snap_rf_stats['histogram'] = json.dumps([hist_bins.tolist(), hist_vals.tolist()])
               except:
                   snap_rf_stats['histogram'] = None
               try:
                   snap_rf_stats['autocorrelation'] = json.dumps(autocorrs[antn][snap].real.tolist())
               except:
                   snap_rf_stats['autocorrelation'] = None
               try:
                   coeffs = eq_coeffs[antn][snap]
                   snap_rf_stats['eq_coeffs'] = json.dumps(coeffs.tolist())
               except:
                   snap_rf_stats['eq_coeffs'] = None
               snap_rf_stats['timestamp'] = datetime.datetime.now().isoformat()
               corr.r.hmset(status_key, snap_rf_stats)
           
       
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
                # Give the antenna hash a key indicating the SNAP and input number it is associated with
                redis_vals['f_host'] = key
                redis_vals['host_ant_id'] = antn
                try:
                    hist_bins, hist_vals = histograms[antn][key]
                    redis_vals['histogram'] = json.dumps([hist_bins.tolist(), hist_vals.tolist()])
                except:
                    redis_vals['histogram'] = None
                try:
                    redis_vals['autocorrelation'] = json.dumps(autocorrs[antn][key].real.tolist())
                except:
                    redis_vals['autocorrelation'] = None
                try:
                    coeffs = eq_coeffs[antn][key]
                    redis_vals['eq_coeffs'] = json.dumps(coeffs.tolist())
                except:
                    redis_vals['eq_coeffs'] = None
                try:
                    redis_vals.update(pam_stats[ant][pol])
                except KeyError:
                    # if a SNAP died between getting input stats (which is the dictionary we are looping over)
                    # and getting pam/fem stats, the appropriate PAM/FEM keys may not exist
                    pass
                try:
                    redis_vals.update(fem_stats[ant][pol])
                except KeyError:
                    pass
                try:
                    redis_vals["fft_of"] = fft_of[key]
                except KeyError:
                    pass
                redis_vals['timestamp'] = datetime.datetime.now().isoformat()
                corr.r.hmset(status_key, redis_vals)
            
        # Get FPGA stats
        fpga_stats = corr.do_for_all_f("get_fpga_stats")
        for key, val in fpga_stats.iteritems():
            corr.r.hmset("status:snap:%s" % key, val) 
        
        # If the retry period has been exceeded, try to reconnect to dead boards:
        if time.time() > (retry_tick + args.retrytime):
            if len(corr.dead_fengs) > 0:
                logger.debug('Trying to reconnect to dead boards')
                corr.reestablish_dead_connections(programmed_only=True)
                retry_tick = time.time()
                
        # If executing the loop hasn't already taken longer than the loop delay time, add extra wait.
        extra_delay = args.delay - (time.time() - tick)
        if extra_delay > 0:
            logger.debug("Sleeping for %.2f seconds" % extra_delay)
            time.sleep(extra_delay)
