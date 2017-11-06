import socket
import struct
import argparse
import numpy as np

def decode_packet(packet):
    p = struct.unpack('>Q512H', packet)
    time = p[0] >> 27
    chan = (p[0] >> 16) & (2**11 - 1)
    ant  = p[0] & (2**16 - 1)

    return time, chan, ant, np.array(p[1:])


parser = argparse.ArgumentParser(description='Grab packets from an F-engine in EQ TVG mode and check they look ok',
                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('-p', dest='port', type=int, default=10000,
                    help = 'Port to collect packets from')
parser.add_argument('-s', dest='single_packet', action='store_true', default=False,
                    help = 'Use this flag to print a single packet')
parser.add_argument('-e', dest='errors', action='store_true', default=False,
                    help = 'Print all errors')
parser.add_argument('--t', dest='timeerrors', action='store_true', default=False,
                    help = 'Print timestamp errors (timestamps not a multiple of 32')
parser.add_argument('--c', dest='chanerrors', action='store_true', default=False,
                    help = 'Print channel errors (Blocks of 16 channels not right)')


args = parser.parse_args()

BUFSIZE = 1024+64
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind(('0.0.0.0', args.port))

if args.single_packet:
    payload, addr = sock.recvfrom(BUFSIZE)
    time, chan, ant, data = decode_packet(payload)
    print 'TIME: %d (TIME%%32: %d), CHAN: %d, ANT: %d' % (time, time%32, chan, ant)
    for i in range(16):
        print '%3d:%3d : ' % (32*i, 32*(i+1)),
        for d in data[32*i:32*(i+1)]:
            print '%3d'%d,
        print ''
    exit()
    

n = 0
ant_counter = np.zeros(20)
chan_counter = np.zeros(2048)
data_chan_counter = np.zeros(2048)
while(True):
    try:
        payload, addr = sock.recvfrom(BUFSIZE)
        time, chan, ant, data = decode_packet(payload)
        print '%d: TIME: %d (TIME%%32: %d), CHAN: %4d, ANT: %3d, DATA0: %d' % (n, time, time%32, chan, ant, data[0])
        ant_counter[ant] += 1
        chan_counter[chan] += 1
        if args.errors or args.timeerrors:
            if time % 32:
                print 'ERROR: TIME not a multiple of 32!'
        if args.errors or args.chanerrors:
            for i in range(16):
                if not np.all(data[32*i:32*(i+1)] != data[32*i]):
                    print 'ERROR: not all chunks of 32 samples were the same!'
                    print data[32*i:32*(i+1)]
        for d in data:
            data_chan_counter[d] += 1
        n += 1
    except KeyboardInterrupt:
        break

print 'Packet count by antenna:'
for xn, x in enumerate(ant_counter):
    print 'ANT %3d: %d' % (xn, x)
print 'Packet count by channel: from headers (from data)'
for xn, x in enumerate(chan_counter):
    print 'CHAN %4d: %d (%d)' % (xn, x, data_chan_counter[xn])




    
