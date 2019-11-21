# hera_corr_f
A repository for HERA SNAP F-engine firmware and control software.

## Software Versions:
- Ubuntu 16.04
- Xilinx Vivado System Edition 2016.4
- MATLAB/Simulink 2016b

## To open/modify/compile:

1. Clone this repository
2. Clone submodules:
```
git submodule init
git submodule update
```

## To modify SNAP firmware
1. Create a local environment specification file `startsg.local`.
2. From the top level of this repository, run `startsg` (if your environment file is called `startsg.local`) or `startsg <my_local_environment_file.local>`.

### Source Files
`snap_fengine.slx -- A 6-input, 500 Msps, 8192 channel F-engine, capable of outputting 6144 channels at 4-bit resolution.

## To install and run control software`
1. Install a redis server on a server on your local network. Life will be easier if this server is accessible via the hostname `redishost`. On Ubuntu:
```
apt install redis-server
```

2. Install casperfpga and its dependencies. These require python 2.7
```
cd control_software/casperfpga
pip install -r requirements.txt
python setup.py install
```

3. Install the control software
```
cd .. # Go to the control_software directory
python setup.py install
```

4. See further software documentation in the control_software directory.
