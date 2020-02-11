import logging
import logging.handlers
import sys
import time
import redis
import json
import socket
import numpy as np
from astropy.coordinates import EarthLocation
import astropy.units as u
import pyuvdata.utils as utils
from argparse import Namespace

'''
A Redis-based log handler from:
http://charlesleifer.com/blog/using-redis-pub-sub-and-irc-for-error-logging-with-python/
'''

logger = logging.getLogger(__name__)
NOTIFY = logging.INFO + 1
logging.addLevelName(NOTIFY, "NOTIFY")

IS_INITIALIZED_ATTR = "_hera_has_default_handlers"


class RedisHandler(logging.Handler):
    def __init__(self, channel, conn, *args, **kwargs):
        logging.Handler.__init__(self, *args, **kwargs)
        self.channel = channel
        self.redis_conn = conn

    def emit(self, record):
        attributes = [
            'name', 'msg', 'levelname', 'levelno', 'pathname', 'filename',
            'module', 'lineno', 'funcName', 'created', 'msecs', 'relativeCreated',
            'thread', 'threadName', 'process', 'processName',
        ]
        record_dict = dict((attr, getattr(record, attr)) for attr in attributes)
        record_dict['formatted'] = self.format(record)
        try:
            self.redis_conn.publish(self.channel, json.dumps(record_dict))
        except UnicodeDecodeError:
            self.redis_conn.publish(self.channel, 'UnicodeDecodeError on emit!')
        except redis.RedisError:
            pass


class HeraMCHandler(logging.Handler):
    def __init__(self, subsystem, *args, **kwargs):
        from hera_mc import mc
        from astropy.time import Time
        self.Time = Time
        logging.Handler.__init__(self, *args, **kwargs)
        self.subsystem = subsystem
        db = mc.connect_to_mc_db(None)
        self.session = db.sessionmaker()

    def emit(self, record):
        # Re-code level because HeraMC logs 1 as most severe, and python logging
        # calls critical:50, debug:10
        severity = max(1, 100 / record.levelno)
        message = self.format(record)
        logtime = self.Time(time.time(), format="unix")
        self.session.add_subsystem_error(logtime, self.subsystem, severity, message)


def log_notify(log, message=None):
    msg = message or "%s starting on %s" % (log.name, socket.gethostname())
    log.log(NOTIFY, msg)


def add_default_log_handlers(logger, redishostname='redishost', fglevel=logging.INFO,
                             bglevel=NOTIFY, include_mc=False, mc_level=logging.WARNING):
    if getattr(logger, IS_INITIALIZED_ATTR, False):
        return logger
    setattr(logger, IS_INITIALIZED_ATTR, True)

    logger.setLevel(logging.DEBUG)
    logger.propagate = False

    formatter = logging.Formatter('%(asctime)s - %(name)20s - %(levelname)s - %(message)s')

    stream_handler = logging.StreamHandler(stream=sys.stdout)
    stream_handler.setLevel(fglevel)
    stream_handler.setFormatter(formatter)
    logger.addHandler(stream_handler)

    syslog_handler = logging.handlers.SysLogHandler(address='/dev/log')
    syslog_handler.setLevel(bglevel)
    syslog_handler.setFormatter(formatter)
    logger.addHandler(syslog_handler)

    if include_mc:
        try:
            mc_handler = HeraMCHandler("correlator")
            mc_handler.setLevel(mc_level)
            mc_handler.setFormatter(formatter)
            logger.addHandler(mc_handler)
        except:  # noqa
            logger.warn("Failed to add HERA MC log handler")
            logger.exception(sys.exc_info()[0])

    redis_host = redis.StrictRedis(redishostname, socket_timeout=1)
    try:
        redis_host.ping()
    except redis.ConnectionError:
        logger.warn("Couldn't connect to redis server at %s" % redishostname)
        return logger

    redis_handler = RedisHandler('log-channel', redis_host)
    redis_handler.setLevel(bglevel)
    redis_handler.setFormatter(formatter)
    logger.addHandler(redis_handler)
    return logger


def write_snap_hostnames_to_redis(redishost='redishost'):
    if isinstance(redishost, str):
        redishost = redis.Redis(redishost)
    snap_host = {}
    snap_list = list(json.loads(redishost.hget('corr:map', 'snap_to_ant')).keys())
    for snap in snap_list:
        try:
            true_name, aliases, addresses = socket.gethostbyaddr(snap)
        except:  # noqa
            logger.error('Failed to gethostbyname for host %s' % snap)
            continue
        snap_host[snap] = aliases[-1]
    redhash = {}
    redhash['snap_host'] = json.dumps(snap_host)
    redhash['snap_host_update_time'] = time.time()
    redhash['snap_host_update_time_str'] = time.ctime(redhash['snap_host_update_time'])
    redishost.hmset('corr:map', redhash)


def hera_antpol_to_ant_pol(antpol):
    antpol = antpol.lower().lstrip('h')
    pol = antpol[-1]
    ant = int(antpol[:-1])
    return ant, pol


def read_maps_from_redis(redishost='redishost'):
    if isinstance(redishost, str):
        redishost = redis.Redis(redishost)
    if not redishost.exists('corr:map'):
        return None
    x = redishost.hgetall('corr:map')
    x['update_time'] = float(x['update_time'])
    x['ant_to_snap'] = json.loads(x['ant_to_snap'])
    x['snap_to_ant'] = json.loads(x['snap_to_ant'])
    return x


def read_locations_from_redis(redishost='redishost'):
    loc = Namespace()
    redishost = redis.Redis('redishost')
    cofa_xyz = json.loads(redishost.hget('corr:map', 'cofa_xyz'))
    loc.COFA_telescope_location = [cofa_xyz['X'], cofa_xyz['Y'], cofa_xyz['Z']]
    cofa_info = json.loads(redishost.hget('corr:map', 'cofa'))
    loc.observatory = EarthLocation(lat=cofa_info['lat']*u.degree,
                                    lon=cofa_info['lon']*u.degree,
                                    height=cofa_info['alt']*u.m)
    loc.antenna_numbers = json.loads(redishost.hget('corr:map', 'antenna_numbers'))
    loc.antenna_numbers = np.array(loc.antenna_numbers).astype(int)
    loc.antenna_names = json.loads(redishost.hget('corr:map', 'antenna_names'))
    loc.antenna_names = np.asarray([str(a) for a in loc.antenna_names])
    loc.antenna_positions = json.loads(redishost.hget('corr:map', 'antenna_positions'))
    antenna_utm_eastings = json.loads(redishost.hget('corr:map', 'antenna_utm_eastings'))
    antenna_utm_northings = json.loads(redishost.hget('corr:map', 'antenna_utm_northings'))
    loc.number_of_antennas = len(loc.antenna_numbers)
    # Compute uvw for baselines
    loc.all_antennas_enu = {}
    for i, antnum in enumerate(loc.antenna_numbers):
        ant_enu = (antenna_utm_eastings[i],
                   antenna_utm_northings[i],
                   cofa_info['alt'])
        loc.all_antennas_enu[antnum] = np.array(ant_enu)
    return loc
