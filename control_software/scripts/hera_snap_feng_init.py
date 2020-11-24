#!/home/hera/anaconda2/envs/venv/bin/python

import argparse
from hera_corr_f import HeraCorrelator, __version__
from hera_corr_cm import handlers
import redis
import time
import yaml
import logging
import json

TIMEOUT = 10
NTRIES = 3

def main():
    parser = argparse.ArgumentParser(description='Interact with a programmed SNAP board for'
                                     'testing and networking. FLAGS OVERRIDE CONFIG FILE!',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--config_file', type=str, default=None,
                        help='YAML configuration file with hosts and channels list')
    parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                        help='Host servicing redis requests')
    parser.add_argument('-s', dest='sync', action='store_true', default=False,
                        help='Use this flag to sync the F-engine(s) and Noise generators from PPS')
    #parser.add_argument('-m', dest='mansync', action='store_true', default=False,
    #                    help='Use this flag to manually sync the F-engines with an asynchronous software trigger')  # noqa
    group_init = parser.add_mutually_exclusive_group()
    group_init.add_argument('-i', dest='initialize', action='store_true', default=None,
                            help='Use this flag to initialize the uninitialized F-engine(s)')
    group_init.add_argument('-I', dest='forceinitialize', action='store_true', default=None,
                            help='Use this flag to initialize all F-engine(s)')
    #parser.add_argument('-t', dest='tvg', action='store_true', default=False,
    #                    help='Use this flag to switch to EQ TVG outputs')
    #parser.add_argument('-n', dest='noise', action='store_true', default=False,
    #                    help='Use this flag to switch to Noise inputs')
    parser.add_argument('-d', dest='dest', action='store_true', default=False,
                        help='Configure Ethernet destinations.')
    parser.add_argument('-e', dest='eth', action='store_true', default=False,
                        help='Use this flag to switch on the Ethernet outputs')
    group_prog = parser.add_mutually_exclusive_group()
    group_prog.add_argument('-p', '--program', action='store_true', default=False,
                        help='Program FPGAs with the fpgfile specified in the config file'
                             'if not programmed already')
    group_prog.add_argument('-P', '--forceprogram', action='store_true', default=False,
                        help='Program FPGAs with the fpgfile specified in the config file'
                             'irrespective of whether they are programmed already')
    parser.add_argument('--multithread', action='store_true', default=False,
                        help='Multithread initialization (not recommended for a high number of SNAPs)')
    parser.add_argument('--allsnaps', action='store_true', default=False,
                        help='Require communication with all snaps (exit if any are put in dead_fengs")')
    args = parser.parse_args()

    logger = handlers.add_default_log_handlers(logging.getLogger(__file__))
    handlers.log_notify(logger)  # send a NOTIFY level message that this script has started

    corr = HeraCorrelator(redishost=args.redishost, config=args.config_file, use_redis=False)
    if args.allsnaps:
        t = time.time()
        while len(corr._unconnected) != 0 and time.time() - t < TIMEOUT:
            corr.connect_fengs(corr._unconnected)
        if len(corr._unconnected) != 0:
            logger.error("Requiring all SNAPS, but %d were dead." % len(corr._unconnected))
            exit()
    if len(corr.fengs) == 0:
        logger.error("No F-Engines are connected. Is the power off?")
        exit()


    # Write the parameters this script used to redis
    init_time = time.time()
    corr.r.hmset('init_configuration', {
        'hera_corr_f_version': __version__,
        'init_args': json.dumps(vars(args)),
        'init_time': init_time,
        'init_time_str': time.ctime(init_time),
        'config': corr.config_str,
        'config_time': corr.config_time,
        'config_time_str': corr.config_time_str,
        'config_name': corr.config_name,
        'md5': corr.config_hash,
        }
    )

    # Before we start manipulating boards, prevent monitoing scripts from
    # sending TFTP traffic. Expire the key after 5 minutes to lazily account for
    # issues with this script crashing.
    corr.disable_monitoring(expiry=600)

    if args.program or args.forceprogram:
        kwargs = {
            'multithread': True,
            'verify': True,
            'timeout': 300.,
        }
        failed = corr.program_fengs(force=args.forceprogram)
        assert(len(failed) == 0)

    if args.initialize or args.forceinitialize:
        kwargs = {
            'multithread': True,
            'verify': True,
            'timeout': 300.,
        }
        corr.disable_eths() # shut off 10GbE if reinitializing

        # Initialize ADC and FPGA; this cannot be allowed to fail
        failed = corr.align_adcs(**kwargs)
        for cnt in range(NTRIES):
            if len(failed) == 0:
                break
            logger.warn('Reinitializing because ADC alignment failed: %s' % (','.join(failed)))
            failed = corr.align_adcs(hosts=failed, reinit=True, **kwargs)
        assert(len(failed) == 0)
        failed = corr.initialize_dsps(**kwargs)
        assert(len(failed) == 0)
        failed = corr.fft_shift_pfbs(**kwargs)
        assert(len(failed) == 0)
        failed = corr.initialize_eqs(**kwargs)
        assert(len(failed) == 0)
        failed = corr.disable_phase_switches(**kwargs)
        assert(len(failed) == 0)
        
        # Initialize FEM and PAM but accept failure
        fem_failed = corr.switch_fems('antenna', **kwargs)
        pam_failed = corr.initialize_pams(**kwargs)
        if len(fem_failed) > 0:
            logger.warn('FEM initialization failed: %s' % (','.join(fem_failed)))
        if len(pam_failed) > 0:
            logger.warn('PAM initialization failed: %s' % (','.join(pam_failed)))

    if args.dest:
        kwargs = {
            'multithread': True,
            'verify': True,
            'timeout': 300.,
        }
        corr.disable_eths() # shut off 10GbE if reinitializing

        # Now assign frequency slots to different X-engines as
        # per the config file. A total of 32 Xengs are assumed for
        # assigning slots- 16 for the even bank, 16 for the odd.
        # Channels not assigned to Xengs in the config file are
        # ignored. Following are the assumed globals:
        failed = corr.config_dest_eths(**kwargs)
        assert(len(failed) == 0)

    #if args.tvg:
    #    logger.info('Enabling EQ TVGs...')
    #    corr.do_for_all_f("write_freq_ramp", block="eq_tvg")
    #    corr.do_for_all_f("tvg_enable", block="eq_tvg")

    #if args.noise:
    #    logger.info('Setting noise TVGs...')
    #    seed = 23
    #    for stream in range(3):
    #        corr.do_for_all_f("set_seed", block="noise", args=[stream, seed])
    #    corr.do_for_all_f("use_noise", block="input")

    # Sync logic. Do global sync first, and then noise generators
    # wait for a PPS to pass then arm all the boards
    if args.sync:
        corr.disable_eths()
        #corr.do_for_all_f("change_period", block="sync", args=[0])
        corr.sync()
        #corr.sync_noise(manual=args.mansync)

    if args.eth:
        corr.enable_eths()
    else:
        corr.disable_eths()

    # Re-enable the monitoring process
    corr.enable_monitoring()

    logger.info('Initialization complete')
    import IPython; IPython.embed()


if __name__ == "__main__":
    main()
