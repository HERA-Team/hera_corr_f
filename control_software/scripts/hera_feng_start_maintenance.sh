#! /bin/bash

LOGFILE=~/snap_start.log

source ~/.bashrc
set -e

echo hera_feng_start.sh: Initializing F-Engines > $LOGFILE
date >> $LOGFILE
hera_snap_feng_init.py -p -i -d &>> $LOGFILE
echo hera_fem_control.py: Setting FEMs to LOAD >> $LOGFILE
hera_fem_control.py --state=load &>> $LOGFILE
echo >> $LOGFILE
echo >> $LOGFILE
echo hera_feng_start.sh: Synchronizing and Starting TX
hera_snap_feng_init.py -s -e &>> $LOGFILE
