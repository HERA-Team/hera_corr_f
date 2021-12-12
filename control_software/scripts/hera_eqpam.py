#! /usr/bin/env python
import argparse
from hera_corr_f import hcf_tools as hcft


ap = argparse.ArgumentParser()
ap.add_argument('--set', help="Set to use.", choices=['calc_pam_atten', 'antenna', 'load', 'noise'],
                default='calc_pam_atten')
ap.add_argument('--cf', help='Center frequency in MHz for equalization calculation.', default=168.0)
ap.add_argument('--bw', help='Bandwidth in MHz for equalization calculation.', default=8.0)
ap.add_argument('--target-pwr', dest='target_pwr', default=75.0,
                help='Target power for equalization calculation')
ap.add_argument('--default-atten', dest='default_atten', default=5.0,
                help='Default attenuation to use for unsuccessful equalization calculation.')
ap.add_argument('--retries', help="Number of retries", default=2)
ap.add_argument('--verbose', help="Flag for verbose mode.", action='store_true')
ap.add_argument('--set-atten', dest='set_atten', help="Flag to actually set attentuation.",
                action='store_true')
ap.add_argument('--update-from-redis', dest='update_from_redis', action='store_true',
                help='Flag to update no info from corr with redis values.')
args = ap.parse_args()

atten = hcft.Attenuator()

atten.get_current_state(update_from_redis=args.update_from_redis)
if args.set == 'calc_pam_atten':
    atten.calc_equalization()
