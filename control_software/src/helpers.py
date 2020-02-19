"""Redis functions for CM data."""

import logging
import logging.handlers
import time
import redis
import json
import socket
import numpy as np
from astropy.coordinates import EarthLocation
import astropy.units as u
from argparse import Namespace

logger = logging.getLogger(__name__)
NOTIFY = logging.INFO + 1
logging.addLevelName(NOTIFY, "NOTIFY")

IS_INITIALIZED_ATTR = "_hera_has_default_handlers"


def write_snap_hostnames_to_redis(redishost='redishost'):
    """
    Write the snap hostnames to redis.

    This allows hera_mc to map hostnames to SNAP part numbers.
    """
    if isinstance(redishost, str):
        redishost = redis.Redis(redishost)
    snap_host = {}
    snap_list = list(json.loads(redishost.hget('corr:map', 'all_snap_inputs')).keys())
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
    """Parse antpol."""
    antpol = antpol.lower().lstrip('h')
    pol = antpol[-1]
    ant = int(antpol[:-1])
    return ant, pol


def read_maps_from_redis(redishost='redishost'):
    """Read subset of corr:map."""
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
    """Read location information from redis."""
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
