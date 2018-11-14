import unittest
import numpy as np
from hera_corr_f import SnapFengine
import sys
import casperfpga

class TestCorrBlock(unittest.TestCase):
    host = ''

    def setUp(self):
        self.feng = SnapFengine(self.host)
        self.feng.eq_tvg.write_freq_ramp()
        self.feng.eq_tvg.tvg_enable()
        self.cycle_pols = [(0,0),(1,1),(0,1),(0,2),(1,3),(0,3),(1,2),
                           (0,4),(1,5),(0,5),(1,4),(2,2),(3,3),(2,3),
                           (2,4),(3,5),(2,5),(3,4),(4,4),(5,5),(4,5)]
        self.cycle_auto = [(0,0), (1,1), (2,2), (3,3), (4,4), (5,5)]

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

    def test_real_output(self): 
        for (p1,p2) in self.cycle_pols:
            corr = self.feng.corr.get_new_corr(p1,p2)
            tspec = self.gen_tvg_pol(p1)*np.conj(self.gen_tvg_pol(p2))
            tspec = np.sum(tspec.reshape(-1,8), axis=1)
            self.assertTrue(np.all(tspec.real == corr.real))

    def test_imag_output(self):
        for (p1,p2) in self.cycle_pols:
            corr = self.feng.corr.get_new_corr(p1,p2)
            tspec = self.gen_tvg_pol(p1)*np.conj(self.gen_tvg_pol(p2))
            tspec = np.sum(tspec.reshape(-1,8), axis=1)
            self.assertTrue(np.all(tspec.imag == corr.imag))

    def test_max_hold(self):
        for (p1,p2) in self.cycle_auto:
            mxhld = self.feng.corr.get_max_hold(p1)
            tspec = self.gen_tvg_pol(p1)*np.conj(self.gen_tvg_pol(p2))
            tspec = np.sum(tspec.reshape(-1,8), axis=1)
            self.assertTrue(np.all(tspec.real == mxhld))
 
    

if __name__ == '__main__':
   if len(sys.argv) > 1:
        TestCorrBlock.host = sys.argv.pop()
   else:
        print ('Need a host board to test on')

   unittest.main()
