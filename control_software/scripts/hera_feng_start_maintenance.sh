#! /bin/bash

LOGFILE=~/snap_start.log

source ~/.bashrc
set -e

Help()
{
   echo "Options:"
   echo "d     Digital input: adc (default), noise"
   echo "f     FEM switch: antenna (default), load, noise"
   echo "h     This help"
   echo "s     Digital noise seed: same (default), diff"
   echo "m     Maximum SNAP ethernets to enable. Default 44"
   echo
}

# Default values
input="adc"
fem="antenna"
seed="same"
maxeth="44"

# Process input arguments
while getopts "hf:d:s:m:" option; do
    case $option in
      h) # display Help
         Help
         exit;;
      f) # fem switch state
         fem="$OPTARG"
         ;;
      d) # adc switch state
         input="$OPTARG"
         ;;
      s) # seed state
         seed="$OPTARG"
         ;;
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
echo hera_snap_feng_init.py -p -i -d --fem_state=${fem} --snap_source=${input} --snap_seed=${seed} -s -e --max_eth_enabled=${maxeth} >> $LOGFILE
hera_snap_feng_init.py -p -i -d --fem_state=${fem} --snap_source=${input} --snap_seed=${seed} -s -e --max_eth_enabled=${maxeth} &>> $LOGFILE
echo hera_feng_start.sh: Synchronized and Started TX >> $LOGFILE

hera_snap_enable_monitors.py
