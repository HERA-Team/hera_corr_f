#! /bin/bash

LOGFILE=~/snap_start.log

source ~/.bashrc
set -e

echo hera_feng_start.sh: Initializing F-Engines > $LOGFILE
date >> $LOGFILE
hera_snap_feng_init.py -p -i -d &>> $LOGFILE
#fem_control options are noise,load,antenna
echo hera_fem_control.py: Setting FEMs to ANTENNA >> $LOGFILE
hera_fem_control.py --state=antenna &>> $LOGFILE
#echo hera_snap_enable_digital_noise.py --source=adc --seed=diff >> $LOGFILE
#hera_snap_enable_digital_noise.py --source=adc --seed=diff &>> $LOGFILE
echo >> $LOGFILE
echo >> $LOGFILE
echo hera_feng_start.sh: Synchronizing and Starting TX >> $LOGFILE
hera_snap_feng_init.py -s -e &>> $LOGFILE
