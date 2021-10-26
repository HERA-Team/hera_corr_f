#! /bin/bash

LOGFILE=~/snap_start.log
ERRFILE=~/snap_start.err

echo hera_start_feng.sh: Initializing F-Engines > $LOGFILE
hera_snap_feng_init.py -p -i -d >> $LOGFILE 2> $ERRFILE

echo >> $LOGFILE
echo >> $LOGFILE
echo >> $ERRFILE
echo >> $ERRFILE
echo hera_start_feng.sh: Synchronizing and Starting TX
hera_snap_feng_init.py -s -e >> $LOGFILE 2>> $ERRFILE
