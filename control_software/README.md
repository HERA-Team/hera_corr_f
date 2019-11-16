Control software for SNAP-based HERA F-engines

# Controlling a single board with SnapFengine

```python
# Create a connection to a SNAP and program it.

from hera_corr_f import SnapFengine

s = SnapFengine('heraNode0Snap0', redishost=None)

s.fpga.is_connected()
# Returns: True

# Upload firmware. The first time you run this it will take about 5 minutes
# to burn the SNAP flash.
s.fpga.upload_to_ram_and_program('hera_corr_f/snap_fengine/outputs/snap_fengine_2019-08-29_1717.fpg')

# If a board is already programmed you can simply run:
# s.fpga.transport.prog_user_image()

# Initialize all the blocks in the firmware design.
# You should have a 10MHz reference plugged into the SNAP, as well as an external PPS
s.initialize()

# Arm the SNAP's sync generator. Requires an external PPS to trigger
# (unless you later call a software trigger)
# You *must* sync a board before using FFT outputs
s.sync.arm_sync() # Takes about 5 seconds to arm

# Set FFT shift to maximum value
s.pfb.set_fft_shift(0xffff)

# Some basic checks
s.fpga.estimate_fpga_clock() # Should return ~250 (MHz)

s.sync.period() # FPGA clocks between PPS pulses (should return 250x10^6)
```

# Basic Data Inspection

Once you’ve done the above initialization, you’re ready to play. You do not need to reinitialize unless you reprogram the board.

`SnapFengine.Input` provides methods for interrogating raw ADC samples.
`SnapFengine.Corr` provides methods for dealing with on-board correlations. The following are useful methods.

## ADC Sample methods

Print stats for all 12 ADC cores (2 cores per ADC stream):

```python
s.input.print_status()
mean: -0.261475 -0.608231 -0.757507 -0.712189 -0.252167 -0.780624 -0.435150 -0.507614 -0.291031 -0.790634 -0.262146 -0.217178 
power: 0.261475 0.608231 0.757507 0.712189 0.252167 0.780624 0.435150 0.507614 0.291031 0.790634 0.262146 0.217178 
rms: 0.511346 0.779891 0.870349 0.843913 0.502162 0.883530 0.659659 0.712470 0.539473 0.889176 0.512002 0.466024 
```

Or, capture stats, with the option to sum cores together so you get per-pol rather than per-core statistics:

```
s.input.get_stats?
Signature: s.input.get_stats(sum_cores=False)
Docstring:
Get the mean, RMS, and powers of
all 12 ADC cores.
Inputs:
    sum_cores (Boolean): If True, combine interleaved samples. If False, return stats for each of 12 ADC cores.
Returns:
    means, powers, rmss. Each is a numpy array with one entry per input. (Or 12 entries if sum_cores=False)
```

Get some ADC samples (dual-pol : you can choose 0,1, or 2):

```python
x, y = s.input.get_adc_snapshot(0)
```

Get power spectra from raw ADC snapshots, accumulating 100 times (dual-pol : you can choose 0,1, or 2):

```python
X, Y = s.input.get_power_spectra(0, 100)
```

## F-Engine spectral output methods

Rhe default gains applied by the global initialization are hopefully reasonable, but you can change them per inputs (0 through 5) with

```python
s.eq.set_coeffs(0, np.ones(s.eq.ncoeffs)*400) # Set all of input 0's coefficients to 400
```

Getting a correlation from a pair of SNAP inputs:

```
In [4]: s.corr.get_new_corr?
Signature: s.corr.get_new_corr(pol1, pol2, flush_vacc=True)
Docstring:
Get a new correlation with the given inputs.
Flushes a correlation after setting inputs, to prevent any contaminated results.
Input Pol Mapping: [1a, 1b, 2a, 2b, 3a, 3b] : [0, 1, 2, 3, 4, 5, 6, 7]
Returns: complex nump array of shape(1024,), containing cross-correlation spectra
         with accumulation length divided out.
```

Or just charge in and plot (needs X tunneling and some appropriate matplotlib install):

```
s.corr.plot_corr(0,0,show=True)
```

# Controlling multiple boards and/or using the F-engine 10GbE output

Create a configuration file for your instrument setup. See `config/hera_feng_config.yaml` for an example.

Probably the only parameters you'll need to worry about for a simple system are:

```yaml
# FFT shift. One bit per FFT stage, the first stage is the LSB
# If the FFT uses bit growth, some or all of the stages may be ignored
fft_shift: 0b0110111111111111
```

```yaml
# F-Engine hosts. These are keyed by hostname. Walsh pattern IDs should be provided for the six inputs of each SNAP board, but by default these are not activated.
# `ants` specifies the correlator antenna numbers which ultimately are written into the headers of 10 Gb Ethernet output packets.
fengines:
    my-feng-host0:
        phase_switch_index: [1, 2, 3, 4, 5, 6]
        ants: [0, 1, 2]
    my-feng-host1:
        phase_switch_index: [1, 2, 3, 4, 5, 6]
        ants: [3, 4, 5]
    ...
```

F-Engine hostnames should be resolvable to IP addresses by any server talking to them using this config file.

```yaml
# X-engines to which packets should be sent specificed with explicit IP and MAC addresses.
# A feature of the HERA system is that alternate packets for consecutive pairs of time samples can be sent to different addresses.
xengines:
    0:
        even: # Where time samples 4*t and 4*t+1 should go
           ip: "10.80.40.197"
           mac: 0x02020a5028c5
        odd:  # Where time samples 4*t+2 and 4*t+3 should go
           ip: "10.80.40.206"
           mac: 0x02020a5028ce
        # chan_range *must* correspond to 384 channels
        chan_range: [1536, 1920] # Channels 1536 through 1919 will be sent here.
    1:
        even:
           ip: "10.80.40.229"
           mac: 0x02020a5028e5
        odd:
           ip: "10.80.40.238"
           mac: 0x02020a5028ee
        chan_range: [1920, 2304]
    ...
```

Once you have a config file, you can configure multiple SNAPs with the command:

```python
# Flags:
# -p : Program SNAPs
# -i : Initialize SNAPs
# -s : Re-sync SNAPs from PPS
# -e : Enable Ethernet output
hera_snap_fengine_init.py -p -i -s -e --config_file my_config_file.yaml
```

This command will store various parameters, such as sync time, in a redis database, which is expected to be found being server from the host names `redishost`.

Various simulation modes exist to both replace data streams with known test vectors, and also tweak Ethernet headers to make one SNAP board look like many. This latter feature is particularly useful for (eg) benchmarking an X-engine at full data rate but without a full complement of SNAP boards.
   

