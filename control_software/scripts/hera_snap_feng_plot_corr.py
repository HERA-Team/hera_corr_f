from hera_corr_f import SnapFengine
from matplotlib import pyplot as plt
import numpy as np
import sys

host = sys.argv[1] # Snap hostname

f = SnapFengine(host)

for i in range(6):
    for j in range(i,6):
        anti = i // 2
        antj = i // 2
        poli = i % 2
        polj = j % 2
        print "Plotting baseline (%d,%d) (Ant %d Pol %d, Ant %d Pol %d)" % (i, j, anti, poli, antj, polj)
        c = f.corr.get_new_corr(i,j)
        plt.subplot(6,6,6*i+j)
        plt.semilogy(np.abs(c))

plt.show()
