#! /bin/bash

LOGFILE=~/snap_start.log

source ~/.bashrc
set -e

echo hera_feng_start.sh: Initializing F-Engines > $LOGFILE
date >> $LOGFILE
hera_snap_feng_init.py -p -i -d -s -e --max_eth_enabled=46 &>> $LOGFILE

echo >> $LOGFILE
echo >> $LOGFILE
echo hera_feng_start.sh: Synchronized and Started TX >> $LOGFILE

hera_snap_enable_monitors.py
