#! /bin/bash

echo hera_start_feng.sh: Initializing F-Engines
hera_snap_feng_init.py -p -i -d

echo
echo
echo hera_start_feng.sh: Synchronizing and Starting TX
hera_snap_feng_init.py -s -e
