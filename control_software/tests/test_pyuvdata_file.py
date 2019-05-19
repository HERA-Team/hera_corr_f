import unittest
import numpy as np
from pyuvdata import UVData
import sys

class TestFitsFile(unittest.TestCase):
    filename = ''

    def setUp(self):
        self.uvd = UVData()
        self.uvd.read_uvfits(self.filename)
        self.cycle_pols = {'XX': [(0,0),(0,2),(0,4),(2,2),(2,4),(4,4)],
                           'YY': [(1,1),(1,3),(1,5),(3,3),(3,5),(5,5)],
                           'XY': [(0,1),(0,3),(0,5),(2,3),(2,5),(4,5)],
                           'YX': [(1,0),(1,2),(1,4),(3,2),(3,4),(5,4)]}
        self.pol = self.filename.split('.')[-2]

    def signed_int(self,x):
        """Return two's complement interpretation 
           for 4bit integers"""
        if (x&0x8):
            return (x - 16)
        else:
            return x

    def gen_tvg_pol(self, pol, mode='ramp'):    
        if mode=='ramp':
            ramp = np.arange(2**13, dtype='>B')
            tv = ramp + pol
        if mode=='const':
            tv = np.zeros(NCHANS*4, dtype='>B')
            tv = tv + pol
        tv_imag = np.asarray([self.signed_int(x) for x in (tv&(0x0f))])
        tv_real = np.asarray([self.signed_int(x) for x in (tv>>4)])
        tv = tv_real + 1j*tv_imag

        return tv

    def test_real(self):
        bls = self.cycle_pols[self.pol]
        for i,(ant1,ant2) in enumerate(zip(self.uvd.ant_1_array,self.uvd.ant_2_array)):
            data = self.uvd.get_data(ant1,ant2)
            tspec = self.gen_tvg_pol(bls[i][0])*np.conj(self.gen_tvg_pol(bls[i][1]))
            tspec = np.sum(tspec.reshape(-1,8), axis=1)
            self.assertTrue(np.all(tspec.real == data.real))

if __name__ == '__main__':
   if len(sys.argv) > 1:
        TestFitsFile.filename = sys.argv.pop()
   else:
        print ('Need a pyuvdata file')

   unittest.main()
