#! /usr/bin/env python

import argparse
from redis import Redis
from hera_corr_f import RoachFengine
import numpy as np
import time
import socket
import struct

parser = argparse.ArgumentParser(description='Initialize the ROACH2-based 32-input PAPER/HERA F-Engines',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument('-e', '--eq', type=int, default=600,
                    help='Specify the EQ scaling factor.')
parser.add_argument('-f', '--fftshift', type=int, default=(2**11 - 1),
                    help='Specify the FFT shift schedule.')
parser.add_argument('--seed', type=int, default=0xdd,
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
            fid = int(host.strip('pf')) - 1
            fids += [fid]
            hosts += [host]
        except ValueError:
            print("Can't determine FID from %s" % host)
	   
print("Hosts: %s" % hosts)

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
time.sleep(0.1)

# Determine if we are using the original packetizer
if 'ctmode' in fengs[0].fpga.listdev():
    new_packetizer = False
else:
    new_packetizer = True

# initialize all registers to their default values
print("Initializing registers")
for fn, feng in enumerate(fengs):
    feng.initialize()


print("Disabling network transmission")
for fn, feng in enumerate(fengs):
    if args.verbose:
        print("  Disabling %s" % feng.host)
    feng.eth.disable_tx()

print("Setting FID registers")
for fn, feng in enumerate(fengs):
    print("  Setting FID of %s to %d" % (feng.host, fids[fn]))
    feng.set_fid(fids[fn])

if not new_packetizer:
    print("Setting Corner-Turn mode to 0 (8 boards)")
    for fn, feng in enumerate(fengs):
        feng.set_ctmode(0)

print("Setting FFT shift schedule to %4x" % args.fftshift)
for fn, feng in enumerate(fengs):
    feng.pfb.set_fft_shift(args.fftshift)

print("Setting EQ coefficient to %d" % args.eq)
for fn, feng in enumerate(fengs):
    for i in range(16):
        # two ants per stream, 1024 channels
        feng.eq.set_coeffs(i, np.ones(2*1024) * args.eq) # this method will automatically quantize the coeff appropriately

# Setup details of 10 GbE cores
print("configuring 10 GbE interfaces")
# On the ROACHs, port 0 sends chans 256-512
# On the ROACHs, port 1 sends chans 0-256
# On the ROACHs, port 2 sends chans 768-1024
# On the ROACHs, port 3 sends chans 512-768
# In the original design with the loopback, packets would be sprayed between ports 0<->1, and 2<->3.
# This had the effect that (for ROACH0) channels 0,8,16,etc. ended up back at port 0, chans 256,264,.. -> port 1,
# chans 512,520,... -> port 3, chans 768,776,... -> port 4. 
# The direct connect was then configured so that anything arriving at ROACH<N> port<P> was forwarded
# to X-Engine <N>, port<P>. Host naming conventions mean that X-Engine hosts are px1..8, and have ports
# with hostnames px{1..8}-{2..5}.tenge.pvt
# Thus, channels 0,8,.. should go to px1-2.tenge.pvt
# channels 1,9,.. should go to px2-2.tenge.pvt
# ....
# channels 7,15,.. should go to px8-2.tenge.pvt

# Channels 256,264... should go to px1-3.tenge.pvt
# etc.
# The port mapping is such that ports [0,1,2,3] on the ROACH send to ports [1,0,3,2] on the X-engines
# which have hostnames px<N>-[3,2,5,4].tenge.pvt

port_map = [3,2,5,4]

# We could do something smart here with mac addresses and IPs, but let's just hard code them for now
macs = {
  'px1-2.tenge.pvt' : 0x02c9ed7250, # 1/1
  'px1-3.tenge.pvt' : 0x02c9ed7251, # 1/2
  'px1-4.tenge.pvt' : 0x02c9ed6e60, # 1/3
  'px1-5.tenge.pvt' : 0x02c9ed6e61, # 1/4
  'px2-2.tenge.pvt' : 0x02c9ed6e40, # 2/1
  'px2-3.tenge.pvt' : 0x02c9ed6e41, # 2/2
  'px2-4.tenge.pvt' : 0x02c9ed7210, # 2/3
  'px2-5.tenge.pvt' : 0x02c9ed7211, # 2/4
  'px3-2.tenge.pvt' : 0x02c9ed7010, # 3/1
  'px3-3.tenge.pvt' : 0x02c9ed7011, # 3/2
  'px3-4.tenge.pvt' : 0x02c9ed71f0, # 3/3
  'px3-5.tenge.pvt' : 0x02c9ed71f1, # 3/4
  'px4-2.tenge.pvt' : 0x02c9ed6ff0, # 4/1
  'px4-3.tenge.pvt' : 0x02c9ed6ff1, # 4/2
  'px4-4.tenge.pvt' : 0x02c9ed6e10, # 4/3
  'px4-5.tenge.pvt' : 0x02c9ed6e11, # 4/4
  'px5-2.tenge.pvt' : 0x02c9ed7000, # 5/1
  'px5-3.tenge.pvt' : 0x02c9ed7001, # 5/2
  'px5-4.tenge.pvt' : 0x02c9ed7240, # 5/3
  'px5-5.tenge.pvt' : 0x02c9ed7241, # 5/4
  'px6-2.tenge.pvt' : 0x02c9ed6e50, # 6/1
  'px6-3.tenge.pvt' : 0x02c9ed6e51, # 6/2
  'px6-4.tenge.pvt' : 0x02c9ed7060, # 6/3
  'px6-5.tenge.pvt' : 0x02c9ed7061, # 6/4
  'px7-2.tenge.pvt' : 0x02c9ed6e00, # 7/1
  'px7-3.tenge.pvt' : 0x02c9ed6e01, # 7/2
  'px7-4.tenge.pvt' : 0x02c9ed7020, # 7/3
  'px7-5.tenge.pvt' : 0x02c9ed7021, # 7/4
  'px8-2.tenge.pvt' : 0x02c9ed7040, # 8/1
  'px8-3.tenge.pvt' : 0x02c9ed7041, # 8/2
  'px8-4.tenge.pvt' : 0x02c9ed6df0, # 8/3
  'px8-5.tenge.pvt' : 0x02c9ed6df1, # 8/4
}

mac_base = 0x020200000000

arp_table = np.arange(256) + mac_base

for fn, feng in enumerate(fengs):
  for p in range(4):
    arp_table = np.zeros(256)
    if args.verbose:
        print("  configuring %s:eth%d" % (feng.host, p))

    # Configure Destination Addresses
    # These are stored for each ROACH port in an 8-element RAM.
    # The n-th element is the address where you want channels <chan_num> % d = n to go
    # Eveything out of port P should go to X-engine port P,
    # so the n-th element address map in the ram for port P is:
    # px<n+1>-port_map[P]
    for n in range(len(fengs)):
        hostname = ('px%d-%d.tenge.pvt' % (n+1, port_map[p]))
	ip_asc = socket.gethostbyname(hostname)
        ip_str = socket.inet_aton(ip_asc)
        ip_int = struct.unpack('>L', ip_str)[0]
        feng.fpga.write('eth_%d_dest_ips' % p, ip_str, offset=4*n)
        # add this IP's mac to the arp_table for this core
        ip_low_octet = ip_int & 0xff
        ip_base = ip_int & 0xffffff00
        mac = macs[hostname]
        arp_table[ip_low_octet] = mac
	if args.verbose:
	    print "Wrote %s port %d ip %s mac 0x%.12x" % (feng.fpga.host, p, ip_asc, mac)
    
    my_ip   = ip_base + 16 + fn # doesn't have to depend on port since each port is a different subnet (included in ip_base)
    my_mac  = mac_base + my_ip
    tx_port = 8511

    feng.eth.config_tge_core(p, my_mac, my_ip, tx_port, arp_table)

if args.noise:
    print("Configuring inputs to use noise generators")
    for fn, feng in enumerate(fengs):
        feng.input.use_noise()
else:
    print("Configuring inputs to use ADC signals")
    for fn, feng in enumerate(fengs):
        feng.input.use_adc()

if args.sync:
    print("Setting Noise seeds to %d" % args.seed)
    for fn, feng in enumerate(fengs):
        for i in range(16):
            feng.noise.set_seed(i, args.seed)

    print("Arming noise generators")
    fengs[0].sync.wait_for_sync() # wait until the last sync has passed
    for fn, feng in enumerate(fengs):
        feng.sync.arm_noise()

    print("Arming sync generators")
    for i in range(2): # evidence suggests two arms are required(?!?)
        if args.verbose:
            print("  Beginning waiting for sync at %.2f" % time.time())
        fengs[0].sync.wait_for_sync() # wait until the last sync has passed
        if args.verbose:
            print("  Got sync at %.2f" % time.time())
        # time how long the arm takes, to catch problems
        t0 = time.time()
        for fn, feng in enumerate(fengs):
            feng.sync.arm_sync()
        t1 = time.time()
        if args.verbose:
            print("  Finished arming syncs at %.2f" % time.time())
        if ((t1 - t0) > 0.5):
            print("  WARNING: Took over 0.5 seconds (%.2f s) to arm syncs." % (t1 - t0))
        sync_time = int(time.time()) + 1
        print("  Setting sync time to %d" % sync_time)
    time.sleep(1) # wait for the sync
    print("Storing sync time %d to redis server at %s" % (sync_time, args.redishost))
    redis['roachf_init_time'] = sync_time

print("Resetting network interfaces")
for fn, feng in enumerate(fengs):
    feng.eth.reset()
    feng.eth.status_reset()

print("Enabling TGE outputs")
for fn, feng in enumerate(fengs):
    feng.eth.enable_tx()

print("###########################")
print("# Initialization complete #")
print("###########################")
