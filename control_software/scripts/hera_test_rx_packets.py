import socket
import struct
import argparse
import logging
import numpy as np

def decode_packet(packet):
    p = struct.unpack('>Q4608B', packet)
    time = p[0] >> 29
    chan = (p[0] >> 16) & (2**13 - 1)
    ant  = p[0] & 0xffff
    return time, chan, ant, np.array(p[1:])

def decode_header(packet):
    p = struct.unpack('>Q', packet[0:8])
    time = p[0] >> 29
    chan = (p[0] >> 16) & (2**13 - 1)
    ant  = p[0] & 0xffff
    return time, chan, ant


parser = argparse.ArgumentParser(description='Grab packets from an F-engine in '\
                                 'EQ TVG mode and check they look ok',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-i', dest='ip', type=str, default='10.10.10.136',
                    help = 'Socket to which to bind')
parser.add_argument('-p', dest='port', type=int, default=8511,
                    help = 'Port to collect packets from')
parser.add_argument('-s', dest='single_packet', action='store_true', default=False,
                    help = 'Use this flag to print a single packet')
parser.add_argument('-e', dest='errors', action='store_true', default=False,
                    help = 'Print all errors')
parser.add_argument('-m',dest='mode', type=str, default='ramp_pols',
                    choices=['const_ants','const_pols','ramp_ants','ramp_pols'],
                    help='The test vector mode choosen to program the Fengine.')
parser.add_argument('-v', dest='verbose', action='store_true', default=False,
                    help = 'Print packet details')
parser.add_argument('--stats', dest='stats', action='store_true', default=False,
                    help = 'Print stats on close')
parser.add_argument('--t', dest='timeerrors', action='store_true', default=False,
                    help = 'Print timestamp errors (timestamps not a multiple of 4')
parser.add_argument('--c', dest='chanerrors', action='store_true', default=False,
                    help = 'Print channel errors (There are more than 384 '\
                    'unique values per antenna)')
parser.add_argument('--o', dest='ordererrors', action='store_true', default=False,
                    help = 'Print payload vs header errors')
parser.add_argument('--dt',dest='timeorder',action='store_true',default=False,
                    help = 'Check that time increments by 1 after all channels '\
                           'and antennas are received. WORKS ONLY IF ALL PACKETS '\
                           'ARE CAPTURED.')

args = parser.parse_args()

BUFSIZE = 4616
chans_per_pkt = 384
nsamp_per_pkt = 2
pol = 2
tot_chans = 8192

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((args.ip, args.port))
sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 1024*4616*128)

if args.timeorder:
    payload, addr = sock.recvfrom(BUFSIZE)
    ti, chani, anti = decode_header(payload)
    errorctr = 0; n=0
    while(True):
        try:
            payload, addr = sock.recvfrom(BUFSIZE)
            time, chan, ant  = decode_header(payload)
            if (ant == anti) and (chan == chani):
                if (time-ti != 2*nsamp_per_pkt): #2x for even odd split
                    print "ERROR: TIME not incrementing by %d" %(2*nsamp_per_pkt)
                    print "ANT: %d CHAN: %d TIME: %d"%(ant,chan,time)
                    errorctr += 1
                ti = time;
                n += 1
        except KeyboardInterrupt:
            print '#######################'
            print 'Grabbed %d packets' % n
            print 'Errors: %d' % errorctr
            print '#######################'
            break
    exit()          

if args.single_packet:
    payload, addr = sock.recvfrom(BUFSIZE)
    time, chan, ant, data = decode_packet(payload)
    print 'TIME: %d (TIME%%4: %d), CHAN: %d , ANT: %d' % (time, time%4, chan, ant)
    for ant in range(3):
        print '\nAnt: %d'%ant
        offset = ant*chans_per_pkt*nsamp_per_pkt*pol
        for i in range(96):
            print '%3d:%3d: ' %(i*4, (i+1)*4),
            for d in data[(offset+i*4*2*2):(offset+4*2*2*(i+1)):1]:
                print '%4d'%d,
            print ''
    exit()
    

n = 0
ant_counter = np.zeros(23)
chan_counter = np.zeros(8192)
#data_chan_counter = np.zeros(2048*3)
err_count = 0

# Determine the bank you are receiving
if args.timeerrors or args.errors:
    payload, addr = sock.recvfrom(BUFSIZE)
    time, c, a, d = decode_packet(payload)
    bank = time%4

# Generate the test vector you expect to receive
# ['const_ants','const_pols','ramp_ants','ramp_pols']
if args.ordererrors or args.errors:
    tvg = np.zeros(8192*6,dtype='>B')
    if args.mode == 'const_pols':
        for a in range(6):
            tvg[a*8192:(a+1)*8192] = a
    if args.mode == 'const_ants':
        for a in range(6):
            tvg[a*8192:(a+1)*8192] = a//2
    else:
        ramp = np.arange(8192,dtype='>B')
        if args.mode == 'ramp_pols':
            for a in range(6):
                tvg[a*8192:(a+1)*8192] = ramp + a
        if args.mode == 'ramp_ants':
            for a in range(6):
                tvg[a*8192:(a+1)*8192] = ramp + a//2

while(True):
    try:
        payload, addr = sock.recvfrom(BUFSIZE)
        time, chan, ant, data = decode_packet(payload)

        if args.verbose:
            print '%d: TIME: %d (TIME%%4: %d), CHAN: %4d, ANT: %3d, DATA0: %d'\
                   % (n, time, time%4, chan, ant, data[0])
        ant_counter[ant//3] += 1
        chan_counter[chan] += 1

        if args.errors or args.timeerrors:
            # Check you are getting only one (odd/even) bank
            if (time % 4!=bank):
                print 'ERROR: Receiving both odd and even banks!'
                err_count += 1

        if args.errors or args.ordererrors:
            # Check payload matches
            nbytes = chans_per_pkt
            for a in range(3):
                for p in range(pol):
                    tvg_offset = (a*pol + p)*tot_chans + chan
                    for t in range(nsamp_per_pkt):
                        offset = a * pol * chans_per_pkt * nsamp_per_pkt + t*pol + p
                        if not np.all(data[offset:offset+(pol*nsamp_per_pkt*nbytes):pol*nsamp_per_pkt] == tvg[tvg_offset:tvg_offset+nbytes]):
                            print 'ERROR: Header and packet contents do not match! (Ant %d (pkt ant %d), Pol: %d, Sample %d, Chan %d)' % (ant, a, p, t, chan)
                            print 'Expected:', tvg[tvg_offset:tvg_offset+nbytes]
                            print 'Received:', data[offset:offset+(pol*nsamp_per_pkt*nbytes):pol*nsamp_per_pkt]
                            err_count += 1

        if args.errors or args.chanerrors:
            # Check that you have atmost 16 unique chans
            nchans = len(np.where(chan_counter != 0)[0])
            if nchans > 384:
                err_count += 1
        #for d in data:
        #    data_chan_counter[d] += 1
        n += 1

    except KeyboardInterrupt:
        break

if args.stats:
    print 'Packet count by antenna:'
    for xn, x in enumerate(ant_counter):
        print 'ANT %3d: %d' % (3*xn, x)
    print 'Packet count by channel: from headers (from data)'
    for xn, x in enumerate(chan_counter[0::chans_per_pkt]):
        #a0 = data_chan_counter[xn]
        #a1 = data_chan_counter[xn+2048]
        #a2 = data_chan_counter[xn+4096]
        #tot = a0+a1+a2
        print 'CHAN %4d-%4d: %d '%(xn*chans_per_pkt, (xn+1)*chans_per_pkt-1, x)
        #(ANT0:%d, ANT1:%d, ANT2:%d TOTAL:%d)' % (xn, x, a0, a1, a2, tot)

print '#######################'
print 'Grabbed %d packets' % n
print 'Errors: %d' % err_count
print '#######################'

    
