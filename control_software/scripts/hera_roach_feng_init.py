import argparse
import casperfpga
from redis import Redis

parser = argparse.ArgumentParser(description='Initialize the ROACH2-based 32-input PAPER/HERA F-Engines',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument('-e', '--eq', type=int, default=600,
                    help='Specify the EQ scaling factor.')
parser.add_argument('-f', '--fftshift', type=int, default=(2**11 - 1),
                    help='Specify the FFT shift schedule.')
parser.add_argument('--seed', type=int, default=0xdeadbeef,
                    help='Specify the Noise seed')
parser.add_argument('-r', '--redishost', type=str, default='redishost',
                    help='Specify the hostname of the redis server')
parser.add_argument('-s', '--no-sync', dest='sync', action='store_false', default=True,
                    help='Do not arm the sync generator')
parser.add_argument('-n', '--noise', action='store_true', default=False,
                    help='Use digital noise generators')
parser.add_argument('hosts', nargs='+',
                    help='hosts to initialize. Should be of the form HOST:<FID>, uness the host is "pf<FID>", eg. pf4')
parser.add_argument('-v', '--verbose', action='store_true', default=False,
                    help='Be verbose')

args = parser.parse_args()

# Parse the hostnames, extracting the FIDs using either the HOST:<FID> or pf<FID> formatting
fids  = []
hosts = []
fengs = []
for host in args.hosts:
    if ':' in host:
        try:
            h, fid = host.split(':')
            fids += [int(fid)]
            hosts += [h]
        except ValueError:
            print("Can't determine FID from %s" % host)
    else:
        try:
            fid = int(host.strip('pf'))
            fids += [fid]
            hosts += [h]
        except ValueError:
            print("Can't determine FID from %s" % host)

# Set up the redis connection
redis = Redis(args.redishost)
try:
    redis.ping()
except:
    print("Failed to ping redis server at %s" % args.redishost)
    print("Exiting...")
    exit()

# Build a RoachFengine object from each host
for host in hosts:
    fengs += [RoachFengine(host)]

print("Disabling network transmission")
for fn, feng in enumerate(fengs):
    if opts.verbose:
        print("  Disabling %s" % feng.host)
    feng.eth.disable()

# There used to be an FID register -- now the FID is embedded in the antenna number
#print("Setting FID registers")
#for fn, feng in enumerate(fengs):
#    print("  Setting FID of %s to %d" % (feng.host, fids[fn]))
#    feng.packetizer.set_fid(fids[fn])

print("Setting FFT shift schedule to %4x" % args.fftshift)
for fn, feng in enumerate(fengs):
    feng.pfb.set_fft_shift(args.fftshift)

print("Setting EQ coefficient to %d" % args.eq)
for fn, feng in enumerate(fengs):
    feng.eq.set_eq(np.ones(32*1024) * args.eq) # this method will automatically quantize the coeff appropriately

# Setup details of 10 GbE cores

mac_base = 0x0202_c0a8_0000
ip_base  =      0x0a0a_0000

arp_table = np.range(256) + gpu_mac_base

print("configuring 10 GbE interfaces")
for fn, feng in enumerate(fengs):
  # Setup gpu 10 GbE cores and xip registers
  for i in range(4):
    if args.verbose:
        print("  configuring %s:eth%d" % (feng.host, i))

    my_ip   = 4*fn + i + ip_base
    my_mac  = 4*fn + i + mac_base
    tx_port = 10000 # This isn't what paper uses now

    feng.eth.config_tge_core(i, my_mac, my_ip, tx_port, arp_table)

if args.sync
    print("Arming sync generators")
    for i in range(2): # evidence suggests two arms are required(?!?)
        if args.verbose:
            print("  Beginning waiting for sync at %.2" % time.time())
        fengs[0].wait_for_sync() # wait until the last sync has passed
        if args.verbose:
            print("  Got sync at %.2" % time.time())
        # time how long the arm takes, to catch problems
        t0 = time.time()
        for fn, feng in enumerate(fengs):
            feng.arm_sync()
        t1 = time.time()
        if args.verbose:
            print("  Finished arming syncs at %.2" % time.time())
        if ((t1 - t0) > 0.5:
            print("  WARNING: Took over 0.5 seconds (%.2f s) to arm syncs." % (t1 - t0))
        sync_time = int(time.time()) + 1
        print("  Setting sync time to %d" % sync_time)
    time.sleep(1) # wait for the sync
    print("Storing sync time %d to redis server at %s" % (sync_time, args.redishost))
    redis['roachf_init_time'] = sync_time

    print("Setting Noise seeds to %d" % args.seed)
    for fn, feng in enumerate(fengs):
        for i in range(16)
            feng.noisegen.set_seed(i, args.seed)

    print("Arming noise generators")
    fengs[0].wait_for_sync() # wait until the last sync has passed
    for fn, feng in enumerate(fengs):
        feng.arm_noise()

    



