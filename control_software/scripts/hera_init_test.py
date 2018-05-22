from hera_corr_f import SnapFengine
import numpy as np
import struct
import time
import argparse

parser = argparse.ArgumentParser(description='Interact with the test desing',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('host', metavar='host', type=str,
                    help = 'Hostname / IP of the SNAP')
parser.add_argument('-m', dest='mansync', action='store_true', default=False,
                    help ='Use this flag to manually sync the F-engines with '\
                    'an asynchronous software trigger')
parser.add_argument('-i', dest='initialize', action='store_true', default=False,
                    help ='Use this flag to initialize the F-engine(s)')
parser.add_argument('-e', dest='eth', action='store_true', default=False,
                    help ='Use this flag to switch on the Ethernet outputs')

args = parser.parse_args()

fengine = SnapFengine(args.host)

if args.initialize():
    fengine.eq_tvg.initialize()
    fengine.
