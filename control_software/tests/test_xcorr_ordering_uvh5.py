import numpy as np
import matplotlib.pyplot as plt
from pyuvdata import UVData

NANTS = 192
NCHANS = 8192 / 4 * 3 / 4
NXENG = 16
NWORDS = 2 * NANTS * (NANTS+1) / 2 * 4 * NCHANS
NBL = (NANTS * (NANTS+1)) / 2
INT_TIME = 262144

def signed_int(x):
    """Return two's complement interpretation for 4bit integers"""
    if (x&0x8):
        return (x - 16)
    else:
        return x

def gen_tvg(ant, pol, mode='ramp'):
    """
    """
    if mode=='ramp':
        ramp = np.arange(2**13, dtype='>B')
        tv = ramp + 2*(ant%3) + pol
    if mode=='const':
        tv = np.zeros(NCHANS*4, dtype='>B')
        tv = tv + 2*(ant%3) + pol
    tv_real = np.asarray([signed_int(x) for x in (tv&(0x0f))])
    tv_imag = np.asarray([signed_int(x) for x in (tv>>4)])
    tv = tv_real + 1j*tv_imag

    return tv

ant1 = 0
ant2 = 1

uvd = UVData()
#uvd.read_uvh5('/home/jackh/zen.2458422.49724.uvh5', run_check=False)
uvd.read_uvh5('zen.2458437.41969.uvh5', run_check=False)

for ant1 in range(3):
    for ant2 in range(3):
        data = uvd.get_data(ant1,ant2)
        for i in range(4):
            tspec = gen_tvg(ant1, i%2)*np.conj(gen_tvg(ant2, ((i//2 + i%2)%2)))
            tspec = INT_TIME*np.sum(tspec.reshape(-1,4), axis=1)[0:NCHANS]
            print np.all(tspec == data[0,:,i])
            #plt.plot(tspec.real, '-', label='Test %d'%i, alpha=0.5)

