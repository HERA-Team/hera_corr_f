from hera_corr_f import SnapFengine
import casperfpga
import numpy as np
import argparse 
import time

parser = argparse.ArgumentParser(description='Obtain cross-correlation spectra from a SNAP Board',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('host', type=str, 
                    help='Host boards to collect data from')
parser.add_argument('-s', dest='sync', action='store_true', default=False,
                    help ='Use this flag to sync the F-engine(s) and Noise generators from PPS')
parser.add_argument('-m', dest='mansync', action='store_true', default=False,
                    help ='Use this flag to manually sync the F-engines with an asynchronous software trigger')
parser.add_argument('-i', dest='initialize', action='store_true', default=False,
                    help ='Use this flag to initialize the F-engine(s)')
parser.add_argument('--noise', dest='noise', action='store_true', default=False,
                    help ='Use this flag to switch to Noise inputs')
parser.add_argument('--tvg', dest='tvg', action='store_true', default=False,
                    help ='Use this flag to switch to EQ TVG outputs')
parser.add_argument('-n','--num_spectra',type=int,default=10,
                    help='Number of spectra per baseline')
parser.add_argument('-t', '--integration_time', type=int, default=1,
                    help='Integration time in seconds for each spectra')
parser.add_argument('-p','--program', type=str, default=None,
                    help='Program FPGAs with the fpgfile')
parser.add_argument('-o','--output',type=str, default='.',
                    help='Path to destination folder')
args = parser.parse_args()

NCHAN    = 1024
NPOL     = 4
NBL      = 6
NTIME    = args.num_spectra
NBLTIMES = (NTIME * NBL)
    
if args.program  is not None:
    snap = casperfpga.CasperFpga(args.host)
    print 'Programming %s with %s'%(args.host, args.program)
    snap.upload_to_ram_and_program(args.program)

frequencies = np.arange(NCHAN) * 250e6/NCHAN
pols = range(NPOL)
ant1_array=np.array([[0,0,0,1,1,2] for t in range(NTIME)]).astype(int).flatten()
ant2_array=np.array([[0,1,2,1,2,2] for t in range(NTIME)]).astype(int).flatten()
antenna_pairs = ([[0,0],[0,1],[0,2],[1,1],[1,2],[2,2]])

fengine = SnapFengine(args.host)

if args.initialize:
    print '%s: Initializing..'%args.host
    fengine.initialize()

if args.tvg:
    print '%s:  Enabling EQ TVGs...'%args.host
    fengine.eq_tvg.write_const_ants()
    fengine.eq_tvg.tvg_enable()

if args.noise:
    print '%s:  Setting noise TVGs...'%args.host
    ## Noise Block
    seed = 23
    for stream in range(fengine.noise.nstreams): 
        fengine.noise.set_seed(stream, seed)
    fengine.input.use_noise()

# Set integration length
acc_len = (args.integration_time * 500e6)/(8192*8*2) 
# convert to spectra (/8192), accumulations (/2)
# TODO: Don't understand the empirical factor of 2

# Sync the SNAP boards before collecting data    
if args.sync:
    print 'Sync-ing Fengine'
    print 'Waiting for PPS at time %.2f' % time.time()
    fengine.sync.wait_for_sync()
    print 'Sync passed at time %.2f' % time.time()
    before_sync = time.time()
    fengine.sync.arm_sync()
    after_sync = time.time()
    print 'Syncing took %.2f seconds' % (after_sync - before_sync)
    if after_sync - before_sync > 0.5:
        print "WARNING!!!"

if args.sync:
    print 'Sync-ing Noise generators'
    print 'Waiting for PPS at time %.2f' % time.time()
    fengine.sync.wait_for_sync()
    print 'Sync passed at time %.2f' % time.time()
    before_sync = time.time()
    fengine.sync.arm_noise()
    after_sync = time.time()
    print 'Syncing took %.2f seconds' % (after_sync - before_sync)
    if after_sync - before_sync > 0.5:
        print "WARNING!!!"

if args.mansync:
    print 'Generating a software sync trigger'
    fengine.sync.arm_sync()
    fengine.sync.arm_noise()
    # It takes multiple (3?) syncs to clear the mrst.
    fengine.sync.sw_sync()
    fengine.sync.sw_sync()
    fengine.sync.sw_sync()
    fengine.sync.sw_sync()

times = []
data = []
# Start integrating and collecting data
for t in range(NTIME):
    for a1, a2 in antenna_pairs:
        print 'Getting baseline pair: (%d, %d)..'%(a1,a2)
        a1*= 2; a2*= 2;
        corr = [] 
        corr.append(fengine.corr.get_new_corr(a1, a2)) #xx
        times.append(time.time())
        corr.append(fengine.corr.get_new_corr(a1+1, a2+1)) #yy
        times.append(time.time())
        corr.append(fengine.corr.get_new_corr(a1,   a2+1)) #xy
        times.append(time.time())
        corr.append(fengine.corr.get_new_corr(a1+1, a2)) #yx
        times.append(time.time())
        data.append(np.transpose(corr))

if args.output.endswith('/'):
    outfilename = args.output + 'snap_correlation_%d.npz'%(times[0])
else:
    outfilename = args.output + '/snap_correlation_%d.npz'%(times[0])

np.savez(outfilename,data=data,polarizations=pols,frequencies=frequencies,
         times=times,ant1_array=ant1_array,ant2_array=ant2_array)
