#! /usr/bin/env python

import sys
import time
import datetime
import redis
from hera_corr_f import SnapFengine

LOOPDELAY = 10 #seconds between polling

r = redis.Redis("redishost")

fengines = []
for host in sys.argv[1:]:
    try:
        fengines += [SnapFengine(host)]
    except:
        pass
print fengines
while(True):
    tick = time.time()
    for fengine in fengines:
        stat = {}
        stat['temp'] = fengine.fpga.transport.get_temp()
        stat['timestamp'] = datetime.datetime.now().isoformat()
        r.hmset("status:snap:%s" % fengine.fpga.host, stat)
    while (time.time() < (tick + LOOPDELAY)):
        time.sleep(0.5)
    
    
    
