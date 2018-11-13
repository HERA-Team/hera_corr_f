import numpy as np
import argparse
from pyuvdata import UVData
from pyuvdata.untils import polstr2num
import pyuvdata.utils as utils
from astropy.time import Time
from astropy.coordinates import SkyCoord, EarthLocation, AltAz
from hera_mc.sys_handling import Handling
from hera_mc import cm_utils
from hera_corr_f import SnapFengine
from hera_corr_f import HeraCorrelator
from hera_corr_f import helpers
import logging
import redis
import time, os

logger = helpers.add_default_log_handlers(logging.getLogger(__name__))

parser = argparse.ArgumentParser(description='Obtain cross-correlation spectra from a SNAP Board',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('host', type=str, 
                    help='Host board to collect data from')
parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                    help ='Host servicing redis requests')
parser.add_argument('-n','--num_spectra',type=int,default=10,
                    help='Number of spectra per file')
parser.add_argument('-t', '--integration_time', type=int, default=1,
                    help='Integration time in seconds for each spectra')
parser.add_argument('-o','--output',type=str, default='.',
                    help='Path to destination folder')
parser.add_argument('-w','--wait_time',type=int,default=0,
                    help='Wait time between files (duty cycle basically)')
args = parser.parse_args()

corr.r.set('disable_monitoring', 1, ex=60)
logger.warning('Disabling the monitoring.')
time.sleep(2)

feng = SnapFengine(args.host)

# Get antenna numbers from database
#corr.compute_hookup()
#ants = corr.snap_to_ant[argsg.host]

fqs = np.arange(feng.corr.nchans) * 250e6/feng.corr.nchans
pols = range(4)
ant1_array=np.array([[0,0,0,1,1,2] for t in range(args.num_spectra)]).astype(int).flatten()
ant2_array=np.array([[0,1,2,1,2,2] for t in range(args.num_spectra)]).astype(int).flatten()

# Mapping: 1x,1y,2x,2y,3x,3y = 0,1,2,3,4,5
cycle_pols = {'xx': [(0,0),(0,2),(1,1),()]
             }


[(0,0),(1,1),(0,1),(0,2),(1,3),(0,3),(1,2),
              (0,4),(1,5),(0,5),(1,4),(2,2),(3,3),(2,3),
              (2,4),(3,5),(2,5),(3,4),(4,4),(5,5),(4,5)]

acc_len = int((args.integration_time*250e6)/\
              (8*feng.corr.nchans*feng.corr.spec_per_acc))
if not acc_len == feng.corr.get_acc_len():
    feng.corr.set_acc_len(acc_len)

first_run = 1
logger.info('Getting baseline pair: (%d, %d)..'%(0,0))
feng.corr.set_input(0,0)

# Write different files for different polarizations

