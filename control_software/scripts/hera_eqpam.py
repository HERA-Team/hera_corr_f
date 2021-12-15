#! /usr/bin/env python
import argparse
from hera_corr_f import hcf_atten


ap = argparse.ArgumentParser()
ap.add_argument('--set', help="Set to use.", default='calc')
ap.add_argument('--cf', help='Center frequency in MHz for equalization calculation.', default=168.0)
ap.add_argument('--bw', help='Bandwidth in MHz for equalization calculation.', default=8.0)
ap.add_argument('--target-pwr', dest='target_pwr', default=75.0,
                help='Target power for equalization calculation')
ap.add_argument('--default-atten', dest='default_atten', default=5.0,
                help='Default attenuation to use for unsuccessful equalization calculation.')
ap.add_argument('--retries', help="Number of retries", default=2)
ap.add_argument('-v', '--verbose', help="Flag for verbose mode.", action='store_true')
ap.add_argument('--set-atten', dest='set_atten', help="Flag to actually set attentuation.",
                action='store_true')
ap.add_argument('--log-values', dest='log_values', default=None,
                choices=[None, 'antenna', 'load', 'noise', 'all', 'None'],
                help="Flag to log current switch/values to redis.")
ap.add_argument('--update-from-redis', dest='update_from_redis', action='store_true',
                help='Flag to update info from corr with redis values.')
args = ap.parse_args()

atten = hcf_atten.Attenuator()

atten.get_current_state(update_from_redis=args.update_from_redis)

if args.set == 'calc':
    atten.calc_equalization(cf=args.cf, bw=args.bw, target_pwr=args.target_pwr,
                            default_atten=args.default_atten, verbose=args.verbose)
else:
    atten.load_atten_sets(switch=args.set)

if args.log_values is not None and args.log_values != 'None':
    atten.handle_atten_sets(switch=args.log_values)

if args.set_atten:
    atten.set_pam_attenuation(retries=args.retries, set_to=args.set)
