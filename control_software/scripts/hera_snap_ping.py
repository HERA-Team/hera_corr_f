from hera_corr_f.hera_corr import HeraCorrelator
import os
hera = HeraCorrelator()
hosts = [s.host for s in hera.fengs]
for h in hosts:
    os.system("ping -c 1 "+h)
