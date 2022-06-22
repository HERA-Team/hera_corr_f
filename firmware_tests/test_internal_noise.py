#! /usr/bin/env python

import os
import sys
import argparse
import yaml
import logging
import numpy as np
from hera_corr_f import snap_fengine

N_ANTS_PER_BOARD = 3
N_NOISE = 6

FAIL = -1
SUCCESS = 0

logger = logging.getLogger(__file__)
handler = logging.StreamHandler(sys.stdout)
logger.setLevel(logging.INFO)
handler.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)

def test_identical_noise(f, rng_int):
    """
    Set all inputs to point to the same noise source and verify that
    power, RMS, mean, and autocorrelations (among groups of 16 inputs)
    are identical.

    inputs:
        f: SnapFengine instance
        rng_int: random integer generator like numpy's randint
    """
    # Point all inputs to same noise
    noise_seed = rng_int(0, 256)
    n_outputs = f.noise.nstreams
    for i in range(n_outputs):
        logger.info("Setting noise seed of generator %d to %d" % (i, noise_seed))
        f.noise.set_seed(i, noise_seed)
    f.input.use_noise()
    f.sync.arm_sync()
    f.sync.arm_noise()
    f.sync.sw_sync()
    f.sync.sw_sync()
    f.sync.sw_sync()
    f.sync.sw_sync()

    ok = True
    try:
        means, rmss, powers = f.input.get_stats()
        do_bitstats = True
    except:
        logger.info("Not checking bit stats because this module doesn't seem to be present in firmware")
        do_bitstats = False

    if do_bitstats:
        if not np.all(means != 0):
            logger.error("Means were not all non-zero!")
            ok = False
        else:
            logger.debug("Means all non-zero")

        if not np.all(rmss != 0):
            logger.error("RMSs were not all non-zero!")
            ok = False
        else:
            logger.debug("RMSs all non-zero")

        if not np.all(powers != 0):
            logger.error("Powers were not all non-zero!")
            ok = False
        else:
            logger.debug("Powers all non-zero")

        for i in range(f.input.n_streams):
            if not np.all(means[i] == means[0]):
                logger.error("Mean mismatch on input %d" % i)
                ok = False
            else:
                logger.debug("Means match between input %d and input 0" % i)
            if not np.all(rmss[i] == rmss[0]):
                logger.error("RMS mismatch on input %d" % i)
                ok = False
            else:
                logger.debug("RMSs match between input %d and input 0" % i)
            if not np.all(powers[i] == powers[0]):
                logger.error("Power mismatch on input %d" % i)
                ok = False
            else:
                logger.debug("Powers match between input %d and input 0" % i)

    for i in range(2*N_ANTS_PER_BOARD):
        for j in range(2*N_ANTS_PER_BOARD):
            spectrum = f.corr.get_new_corr(i, j, flush_vacc=True)
            spectrum_r = spectrum.real
            spectrum_i = spectrum.imag
            nchans = spectrum.shape
            if not spectrum_i.sum() == 0:
                logger.error("Cross-corr not pure-real for input %d and input %d" % (i, j))
                ok = False
            else:
                logger.debug("Cross-corr between input %d and input %d was real as expected" % (i, j))
            ## Check DC spike is in zero bin
            #if not np.max(spectrum_r) == spectrum_r[0]:
            #    logger.error("Maximum power of spectrum for cross corr of inputs %d and %d was not DC bin" % (i, j))
            #    ok = False
            #mean = np.mean(spectrum_r[1:])
            #sigma = np.sqrt(np.var(spectrum_r[1:]))
            #dc_peak = (spectrum_r[0] - mean) / sigma
            #if not dc_peak > 100:
            #    logger.error("DC bin for cross corr of inputs %d and %d less than 100 sigma above mean (only %.2f sigma)" % (i, j, dc_peak))
            #    ok = False
            #    noise_peak = np.max(np.abs((spectrum_r[1:] - mean) / sigma))
            #    if not noise_peak < 10:
            #        logger.error("Highest noise peak for cross corr of inputs %d and %d >10 sigma above mean (%.2f sigma)" % (i, j, noise_peak))
            #        ok = False

    if ok:
        return SUCCESS
    else:
        return FAIL

def test_zeros(f, zero_chans, rng_int):
    """
    Set a subset of inputs to zero.
    Ensure bit stats and autocorrelations are zero only in
    the expected channels.
    inputs:
        f: SnapFengine instance
        zero_chans: List of input channels which should be zero
        rng_int: random integer generator like numpy's randint
    """
    ok = True
    # Point all inputs to same noise
    noise_seed = rng_int(0, 256)
    n_outputs = f.noise.nstreams
    for i in range(n_outputs):
        logger.info("Setting noise seed of generator %d to %d" % (i, noise_seed))
        f.noise.set_seed(i, noise_seed)
    f.input.use_noise()
    f.sync.arm_sync()
    f.sync.arm_noise()
    f.sync.sw_sync()
    f.sync.sw_sync()
    f.sync.sw_sync()
    f.sync.sw_sync()
    f.input.use_noise()

    for chan in zero_chans:
        logger.info("Setting channel %d to zeros" % (chan))
        f.input.use_zero(chan)

    try:
        means, rmss, powers = f.input.get_stats()
        do_bitstats = True
    except:
        logger.info("Not checking bit stats because this module doesn't seem to be present in firmware")
        do_bitstats = False

    if do_bitstats:
        for chan in zero_chans:
            if not means[chan] == 0:
                logger.error("Channel %d had non-zero mean" % chan)
                ok = False
            if not rmss[chan] == 0:
                logger.error("Channel %d had non-zero rms" % chan)
                ok = False
            if not powers[chan] == 0:
                logger.error("Channel %d had non-zero power" % chan)
                ok = False

    for i in range(2*N_ANTS_PER_BOARD):
        for j in range(2*N_ANTS_PER_BOARD):
            spectrum = f.corr.get_new_corr(i, j, flush_vacc=True)
            if (i in zero_chans) or (j in zero_chans):
                if not np.all(spectrum == 0):
                    logger.error("Non-zero spectra for corr %d,%d" % (i,j))
                    ok = False
            else:
                if not np.all(spectrum != 0):
                    logger.error("Unexpected zero bin for corr %d,%d" % (i,j))
                    ok = False
    if ok:
        return SUCCESS
    else:
        return FAIL


#def test_different_noise(f, noise_sources):
#    """
#    Set different inputs to one of several uncorrelated noise sources.
#    Verify that bit stats and autocorrelation spectra are the same,
#    or different, between different inputs, as expected.
#    """
#    ok = True
#    # Point all inputs to the appropriate noise generator
#    for output, noisegen in enumerate(noise_sources):
#        f.noise.assign_output(output, noisegen)
#    logger.info("Assigning outputs %s to noise generator %s" % (range(len(noise_sources)), noise_sources))
#
#    means, rmss, powers = f.input.get_bit_stats()
#
#    if not np.all(means != 0):
#        logger.error("Means were not all non-zero!")
#        ok = False
#    else:
#        logger.debug("Means all non-zero")
#
#    if not np.all(rmss != 0):
#        logger.error("RMSs were not all non-zero!")
#        ok = False
#    else:
#        logger.debug("RMSs all non-zero")
#
#    if not np.all(powers != 0):
#        logger.error("Powers were not all non-zero!")
#        ok = False
#    else:
#        logger.debug("Powers all non-zero")
#
#    for i in range(f.input.n_streams):
#        for j in range(i, f.input.n_streams):
#            if (noise_sources[i] == noise_sources[j]):
#                if not np.all(means[i] == means[j]):
#                    logger.error("Mean mismatch between inputs %d and %d" % (i, j))
#                    ok = False
#                else:
#                    logger.debug("Means match between inputs %d and %d" % (i, j))
#                if not np.all(rmss[i] == rmss[j]):
#                    logger.error("RMS mismatch between inputs %d and %d" % (i, j))
#                    ok = False
#                else:
#                    logger.debug("RMSs match between inputs %d and %d" % (i, j))
#                if not np.all(powers[i] == powers[j]):
#                    logger.error("Power mismatch between inputs %d and %d" % (i, j))
#                    ok = False
#                else:
#                    logger.debug("Powers match between inputs %d and %d" % (i, j))
#            else:
#                if not np.all(means[i] != means[j]):
#                    logger.error("Unexpected Mean match between inputs %d and %d" % (i, j))
#                    ok = False
#                else:
#                    logger.debug("Means differ between inputs %d and %d" % (i, j))
#                if not np.all(rmss[i] != rmss[j]):
#                    logger.error("Unexpected RMS match between inputs %d and %d" % (i, j))
#                    ok = False
#                else:
#                    logger.debug("RMSs differ between inputs %d and %d" % (i, j))
#                if not np.all(powers[i] != powers[j]):
#                    logger.error("Unexpected Power match between inputs %d and %d" % (i, j))
#                    ok = False
#                else:
#                    logger.debug("Powers differ between inputs %d and %d" % (i, j))
#
#    spectra = f.autocorr.get_new_spectra(0) # dummy capture to flush vacc
#    for block in range(f.autocorr._n_cores):
#        spectra = f.autocorr.get_new_spectra(block)
#        n_spectra, nchans = spectra.shape
#        for i in range(n_spectra):
#            for j in range(i, n_spectra):
#                if (noise_sources[n_spectra*block + i] == noise_sources[n_spectra*block + j]):
#                    if not np.all(spectra[i] == spectra[j]):
#                        logger.error("Spectra mismatch between autocorr block %d input %d and input %d" % (block, i, j))
#                        ok = False
#                    else:
#                        logger.debug("Spectra between autocorr block %d input %d and input %d differ" % (block, i, j))
#                else:
#                    # Allow some random matches
#                    if np.sum(spectra[i] == spectra[j]) > 3:
#                        logger.error("Unexpected match between autocorr block %d input %d and input %d" % (block, i, j))
#                        ok = False
#                    else:
#                        logger.debug("Spectra between autocorr block %d input %d and input %d differ" % (block, i, j))
#
#    if ok:
#        return SUCCESS
#    else:
#        return FAIL

def test_delays(f, delays, rng_int):
    """
    Set all inputs to use the same noise source.
    Apply random delays to inputs.
    Using the corr block, check a subset of baselines
    to ensure correlations have expected phase slopes.
    inputs:
        f: SnapFengine instance
        delays: List of input delays. delays[i] is delay applied to input i
        rng_int: random integer generator like numpy's randint
    """
    ok = True
    # Point all inputs to same noise
    noise_seed = rng_int(0, 256)
    n_outputs = f.noise.nstreams
    for i in range(n_outputs):
        logger.info("Setting noise seed of generator %d to %d" % (i, noise_seed))
        f.noise.set_seed(i, noise_seed)
    f.input.use_noise()
    f.sync.arm_sync()
    f.sync.arm_noise()
    f.sync.sw_sync()
    f.sync.sw_sync()
    f.sync.sw_sync()
    f.sync.sw_sync()
    f.input.use_noise()

    for dn, delay in enumerate(delays):
        logger.info("Setting delay of input %d to %d" % (dn, delay))
        f.delay.set_delay(dn, delay)

    CORR_SUM_FACTOR = 8
    for dn0, delay0 in enumerate(delays):
        for dn1, delay1 in enumerate(delays):
            rel_delay = (delay1 - delay0) * 2 # x2 because delays are in FPGA clocks = 2xADC clocks
            corr = f.corr.get_new_corr(dn0, dn1, flush_vacc=True)
            if np.all(corr == 0):
                logger.error("Correlations were all zero between inputs %d and %d" % (dn0, dn1))
                ok = False
            expected_phase = np.linspace(0, np.pi*rel_delay, corr.shape[0]*CORR_SUM_FACTOR, endpoint=False)
            expected_complex = np.exp(1j*expected_phase)
            expected_complex = expected_complex.reshape(corr.shape[0], CORR_SUM_FACTOR).mean(axis=1)
            phase_diff = np.angle(expected_complex / corr)
            max_phase_diff = np.abs(phase_diff[corr != 0]).max()
            logger.info("Checking phase of input %d vs %d (relative delay %d). Max phase diff %.3f" %
                    (dn0, dn1, rel_delay, max_phase_diff))
            if max_phase_diff > (np.pi/50):
                ok = False
                logger.error("Phase mismatch between inputs %d (delay %d) and %d (delay %d)" % (dn0, delay0, dn1, delay1))
                print("Expected phase (bins [300:310]):", np.angle(expected_complex[300:310]))
                print("Observed phase (bins [300:310]):", np.angle(corr[300:310]))
                #import pylab
                #pylab.figure()
                #pylab.plot(expected_phase)
                #pylab.plot(obs_phase)
                #pylab.figure()
                #pylab.plot(np.abs(phase_diff[corr != 0]), label=0)
                #pylab.legend()
                #pylab.show()
                #exit()
    if ok:
        return SUCCESS
    else:
        return FAIL


def main(args):
    # Later numpys
    #rng = np.random.default_rng(args.seed)
    #rng_int = rng.integers
    # Earlier numpys (not sure what version the change happens in)
    np.random.seed(args.seed)
    rng_int = np.random.randint
    f = snap_fengine.SnapFengine(args.host, redishost=None)
    if args.initialize:
        f.initialize_adc()
        #f.align_adc()
        f.initialize()

    # Reset blocks being used even in the absense of an initialize arg
    for block in [f.sync, f.noise, f.input, f.delay, f.pfb, f.corr]:
        logger.info("Initializing block %s" % block.name)
        block.initialize()

    # Set EQ to empirically possibly reasonable value for noise generators and default FFT shift
    for i in range(2*N_ANTS_PER_BOARD):
        f.eq.set_coeffs(i, 10*np.ones(f.eq.ncoeffs))


    if args.samenoise:
        logger.info("Checking input stats and autocorrs make sense with all inputs using identical noise")
        if test_identical_noise(f, rng_int) == SUCCESS:
            logger.info("PASS")
        else:
            logger.error("FAIL")
            exit()

    if args.diffnoise:
        raise NotImplementedError("diffnoise test not implemented")
        noise_allocation = rng_int(0, 2*n_noise, 2*N_ANTS_PER_BOARD)
        if test_different_noise(f, noise_allocation) == SUCCESS:
            logger.info("PASS")
        else:
            logger.error("FAIL")
            exit()

    if args.zero:
        logger.info("Checking input stats and autocorrs with some channels zeroed")
        zero_chans = rng_int(0, N_ANTS_PER_BOARD*2, N_ANTS_PER_BOARD)
        if test_zeros(f, zero_chans, rng_int) == SUCCESS:
            logger.info("PASS")
        else:
            logger.error("FAIL")
            exit()

    if args.delay:
        logger.info("Checking phase between delayed noise sources")
        delays = rng_int(1, 7, 2*N_ANTS_PER_BOARD)
        if test_delays(f, delays, rng_int) == SUCCESS:
            logger.info("PASS")
        else:
            logger.error("FAIL")
            exit()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Check internal test modes',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('-i', dest='initialize', action='store_true',
                        help ='Use this flag to initialize an F-engine')
    parser.add_argument('-s', dest='seed', type=int, default=0xabcdabcd,
                        help ='Random number seed for this test')
    parser.add_argument('--samenoise', action='store_true',
                        help='Skip "Same noise" tests')
    parser.add_argument('--diffnoise', action='store_true',
                        help='Skip "Different noise" tests')
    parser.add_argument('--zero', action='store_true',
                        help='Skip "Zeroing out" tests')
    parser.add_argument('--delay', action='store_true',
                        help='Skip "Delay phase" tests')
    parser.add_argument('host', type=str,
                        help='SNAP2 hostname (or IP address) to initialize')
    args = parser.parse_args()
    main(args)
