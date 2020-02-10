#!/usr/bin/env python
import redis
import time
import json
import argparse
import os
import datetime
import socket
from subprocess import Popen, PIPE
from hera_corr_f import HeraCorrelator, __version__, __package__

def send_response(r, command, time, **kwargs):
    message_dict = {"command":command, "time":time, "args":kwargs}
    n = r.publish("corr:response", json.dumps(message_dict))

def cmd_handler(corr, r, message, testmode=False):
    d = json.loads(message)
    corr.logger.info("Got command: %s" % d)
    command = d["command"]
    time = d["time"]
    args = d["args"]
    if testmode:
        print "Got command:", command
        print "       args:", args
        return
    if command == "phase_switch":
        corr.reestablish_dead_connections(programmed_only=True)
        if args["activate"]:
            corr.phase_switch_enable()
        else:
            corr.phase_switch_disable()
        send_response(r, command, time)
        return
    elif command == "rf_switch":
        if args["input_sel"] not in ["antenna", "noise", "load"]:
            send_response(r, command, time, err="Unrecognized switch input")
            return
        if args["ant"] is not None:
            try:
                feng_e = corr.ant_to_snap[str(args["ant"])]['e']
                feng_n = corr.ant_to_snap[str(args["ant"])]['n']
                feng_e_host = feng_e['host']
                feng_n_host = feng_n['host']
                feng_e_chan = feng_e['channel']//2
                feng_n_chan = feng_n['channel']//2
            except KeyError:
                send_response(r, command, time, err="Can't find F-engine for selected antenna")
                return
            if (feng_e_host != feng_n_host):
                send_response(r, command, time, err="E/N pols not on matching SNAP")
                return
            if (isinstance(feng_e_host, basestring)):
                send_response(r, command, time, err="Required F-engine is not connected")
                return
            if (feng_e_chan != feng_n_chan):
                send_response(r, command, time, err="E/N pols not on matching I2C channel")
                return
            # If we made it to here, hopefully we're good
            # initialize the I2C if necessary
            if not feng.i2c_initialized:
                feng_e_host._add_i2c()
            # Try the write 5 times
            for i in range(5):
                feng_e_host.fems[feng_e_chan].switch(name=args["input_sel"])
                switch_pos = feng_e_host.fems[feng_e_chan].switch()
                if switch_pos == args["input_sel"]:
                    send_response(r, command, time)
                    return
            # Retries exceeded
            send_response(r, command, time, err="Retries exceeded")
            return
        else:
            corr.reestablish_dead_connections(programmed_only=True)
            if args["input_sel"] == "noise":
                corr.noise_diode_enable()
            elif args["input_sel"] == 'load':
                corr.load_enable()
            elif args["input_sel"] == "antenna":
                corr.antenna_enable()
            send_response(r, command, time)
            return
    elif command == "snap_eq":
        if "coeffs" not in args.keys():
            send_response(r, command, time, err="No `coeffs` argument provided!")
            return
        if "ant" not in args.keys():
            send_response(r, command, time, err="No `ant` argument provided!")
            return
        if "pol" not in args.keys():
            send_response(r, command, time, err="No `pol` argument provided!")
            return
        try:
            coeffs = args['coeffs']
        except:
            corr.logger.exception("Failed to cast coeffs to numpy array")
            send_response(r, command, time, err="Provided coefficients couldn't be coerced into a numpy array")
            return
        try:
            corr.set_eq(str(args["ant"]), args["pol"], eq=coeffs)
            send_response(r, command, time)
        except:
            corr.logger.exception("snap_eq command failed!")
            send_response(r, command, time, err="Command failed! Check server logs")
    elif command == "pam_atten":
        corr.disable_monitoring(30, wait=True)
        if "rw" not in args.keys():
            send_response(r, command, time, err="No `rw` argument provided!")
            return
        if args["rw"] == "w" and "val" not in args.keys():
            send_response(r, command, time, err="No `val` argument provided!")
            return
        if "ant" not in args.keys():
            send_response(r, command, time, err="No `ant` argument provided!")
            return
        if "pol" not in args.keys():
            send_response(r, command, time, err="No `pol` argument provided!")
            return
        try:
            feng = corr.ant_to_snap[str(args["ant"])][args["pol"]]
            feng_host = feng['host']
            feng_chan = feng['channel']//2
        except KeyError:
            send_response(r, command, time, err="Can't find F-engine for selected antenna")
            return
        if (isinstance(feng_host, basestring)):
            send_response(r, command, time, err="Required F-engine is not connected")
            return
        # If we made it to here, hopefully we're good
        # initialize the I2C if necessary
        if not feng_host.i2c_initialized:
            feng._add_i2c()
        if args["rw"] == "w":
            # Try the write 3 times
            for i in range(3):
                if args["pol"] == "e":
                    feng_host.pams[feng_chan].set_attenuation(args["val"], None)
                    atten_e_rb, atten_n_rb = feng_host.pams[feng_chan].get_attenuation()
                    if atten_e_rb == args["val"]:
                        send_response(r, command, time)
                        return
                if args["pol"] == "n":
                    feng_host.pams[feng_chan].set_attenuation(None, args["val"])
                    atten_e_rb, atten_n_rb = feng_host.pams[feng_chan].get_attenuation()
                    if atten_n_rb == args["val"]:
                        send_response(r, command, time)
                        return
            # Retries exceeded
            send_response(r, command, time, err="Retries exceeded")
            return
        if args["rw"] == "r":
            atten_e_rb, atten_n_rb = feng_host.pams[feng_chan].get_attenuation()
            if args["pol"] == "e":
                send_response(r, command, time, val=atten_e_rb)
                return
            if args["pol"] == "n":
                send_response(r, command, time, val=atten_n_rb)
                return
            
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

    # load this module's version into redis
    corr.r.hmset('version:%s:%s' % (__package__, os.path.basename(__file__)), {'version':__version__, 'timestamp':datetime.datetime.now().isoformat()})
    # Create key for this module's status
    hostname = socket.gethostname()
    script_redis_key = "status:script:%s:%s" % (hostname, __file__)

    
    retry_tick = 0
    # Seconds between SNAP reconnection attempts
    RETRY_TIME = 300
    while(True):
        message = cmd_chan.get_message(timeout=5)
        if message is not None:
            cmd_handler(corr, r, message["data"], testmode=args.testmode)
        corr.r.set(script_redis_key, "alive", ex=120)
