#! /bin/bash

LOGFILE=~/snap_start.log

source ~/.bashrc
set -e

Help()
{
    echo "Options:"
    echo "m     Maximum SNAP ethernets to enable. Default 44"
    echo
}

# Default values
maxeth="440"

# Process input arguments
while getopts "hm:" option; do
    case $option in
        h) # display Help
            Help
            exit;;
        m) # maxeth
            maxeth="$OPTARG"
            ;;
        \?) # Invalid option
            Help
            exit;;
    esac
done

echo hera_feng_start.sh: Initializing up to ${maxeth} F-Engines > $LOGFILE
date >> $LOGFILE
hera_snap_feng_init.py -p -i -d -s -e --max_eth_enabled=${maxeth} &>> $LOGFILE

echo >> $LOGFILE
echo >> $LOGFILE
echo hera_feng_start.sh: Synchronized and Started TX >> $LOGFILE

hera_snap_enable_monitors.py
