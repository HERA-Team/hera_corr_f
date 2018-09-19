#!/usr/bin/env python
import redis
import time
import json
import argparse
from subprocess import Popen, PIPE
from hera_corr_f import HeraCorrelator

def send_response(r, command, time, **kwargs):
    message_dict = {"command":command, "time":time, "args":kwargs}
    n = r.publish("corr:response", json.dumps(message_dict))

def cmd_handler(corr, r, message, testmode=False):
    d = json.loads(message)
    command = d["command"]
    time = d["time"]
    args = d["args"]
    if testmode:
        print "Got command:", command
        print "       args:", args
        return
    if command == "phase_switch":
        if args["activate"]:
            corr.phase_switch_enable()
        else:
            corr.phase_switch_disable()
        send_response(r, command, time)

    elif command == "noise_diode":
        if args["activate"]:
            corr.noise_diode_enable()
        else:
            corr.noise_diode_disable()
        send_response(r, command, time)
            
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Process commands from the corr:message redis channel.',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                        help ='Hostname of redis server')
    parser.add_argument('-t', dest='testmode', action='store_true', default=False,
                        help ='Use this flag to run in test mode, where no commands are executed')
    args = parser.parse_args()
    
    r = redis.Redis(args.redishost)
    
    cmd_chan = r.pubsub()
    cmd_chan.subscribe("corr:message")
    cmd_chan.get_message(timeout=0.1)

    corr = HeraCorrelator()
    
    while(True):
        message = cmd_chan.get_message(timeout=5)
        if message is not None:
            cmd_handler(corr, r, message["data"], testmode=args.testmode)
