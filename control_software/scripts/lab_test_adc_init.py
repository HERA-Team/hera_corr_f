from hera_corr_f import SnapFengine
import time

IP = '10.10.10.236' # SNAP in digital lab
NTEST = 300
#NTEST = 2
NRAMPS = 1000
#NRAMPS = 500

s = SnapFengine(IP)
for i in range(NTEST):
    t = time.time()
    s.initialize_adc() # wipe out previous config
    s.adc.alignLineClock()
    s.adc.alignFrameClock()
    failed = s.adc.rampTest(retry=True)
    print('Initialized in', time.time() - t)
    if len(failed) == 0:
        print('Doing full test...')
        failed = s.adc.rampTest(NRAMPS)
    if len(failed) > 0:
        print(i, 'Full test FAILED', failed)
    else:
        print(i, 'Full test PASSED')

#import IPython; IPython.embed()
