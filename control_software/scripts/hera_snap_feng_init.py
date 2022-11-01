#!/home/hera/anaconda2/envs/venv/bin/python

import argparse
from hera_corr_f import HeraCorrelator, __version__
from hera_corr_cm import handlers
import time
import logging
import json
import sys

TIMEOUT = 10
NTRIES = 6

def warn_failed(logger, failed, who, all_snaps=False):
    if len(failed) == 0:
        return
    logger.warning('Stage %s failed on: %s' % (who, ','.join(failed)))
    if all_snaps:
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description='Interact with a programmed SNAP board for'
                                     'testing and networking. FLAGS OVERRIDE CONFIG FILE!',
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--hosts', type=str, nargs='+', default=None,
                        help='Specific SNAPs to run on')
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
    parser.add_argument('--fem_state', choices=['antenna','noise','load'], default='antenna',
                        help='Target FEM switch state (antenna, noise, or load). Default: antenna')
    parser.add_argument('--snap_source',choices=['adc','noise'], default='adc')
    parser.add_argument('--snap_seed', choices=['diff','same'], default='diff')

    group_dest = parser.add_mutually_exclusive_group()
    group_dest.add_argument('-d', dest='dest', action='store_true', default=False,
                        help='Configure Ethernet destinations.')
    group_dest.add_argument('-D', dest='forcedest', action='store_true', default=False,
                        help='Configure Ethernet destinations.')
    parser.add_argument('-e', dest='eth', action='store_true', default=False,
                        help='Use this flag to switch on the Ethernet outputs')
    parser.add_argument('--max_eth_enabled', dest='max_eth_enabled', type=int, default=None,
                        help='Maximum number of snaps to enable. Default None = no limit')

    group_prog = parser.add_mutually_exclusive_group()
    group_prog.add_argument('-p', '--program', action='store_true', default=False,
                        help='Program FPGAs with the fpgfile specified in the config file'
                             'if not programmed already')
    group_prog.add_argument('-P', '--forceprogram', action='store_true', default=False,
                        help='Program FPGAs with the fpgfile specified in the config file'
                             'irrespective of whether they are programmed already')

    parser.add_argument('--nomultithread', action='store_true', default=False,
                        help='Disable multithread ADC initialization.')
    parser.add_argument('--allsnaps', action='store_true', default=False,
                        help='Require communication with all snaps (exit if any are put in dead_fengs")')
    parser.add_argument('--ipython', action='store_true', default=False,
                        help='Drop into IPython prompt at end of script')

    args = parser.parse_args()

    logger = handlers.add_default_log_handlers(logging.getLogger(__file__))
    handlers.log_notify(logger)  # send a NOTIFY level message that this script has started

    corr = HeraCorrelator(hosts=args.hosts, redishost=args.redishost, config=args.config_file)

    try:
        if args.allsnaps:
            t = time.time()
            while len(corr._unconnected) != 0 and time.time() - t < TIMEOUT:
                corr.connect_fengs(corr._unconnected)
            if len(corr._unconnected) != 0:
                logger.error("Requiring all SNAPS, but %d were dead." % len(corr._unconnected))
                return
        if len(corr.fengs) == 0:
            logger.error("No F-Engines are connected. Is the power off?")
            return


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
        corr.disable_monitoring(__file__, expiry=600)

        if args.program or args.forceprogram:
            kwargs = {
                'multithread': True,
                'verify': True,
                'timeout': 300.,
            }
            failed = corr.program_fengs(force=args.forceprogram)
            warn_failed(logger, failed, 'program_fengs', all_snaps=args.allsnaps)

        #failed = corr.check_version_fengs()
        #assert(len(failed) == 0) # end session if bitfile is incompatible with this software

        if args.initialize or args.forceinitialize:
            # XXX forceinitialize not treated properly
            kwargs = {
                'multithread': not args.nomultithread,
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
            warn_failed(logger, failed, 'align_adcs', all_snaps=args.allsnaps)

            failed = corr.initialize_dsps(**kwargs)
            warn_failed(logger, failed, 'initialize_dsps', all_snaps=args.allsnaps)

            failed = corr.fft_shift_pfbs(**kwargs)
            warn_failed(logger, failed, 'fft_shift_pfbs', all_snaps=args.allsnaps)

            failed = corr.initialize_eqs(**kwargs)
            warn_failed(logger, failed, 'initialize_eqs', all_snaps=args.allsnaps)

            failed = corr.disable_phase_switches(**kwargs)
            warn_failed(logger, failed, 'disable_phase_switches', all_snaps=args.allsnaps)

            # Initialize FEM and PAM but accept failure
            init_time = time.time()
            fem_failed = corr.switch_fems(args.fem_state, **kwargs)
            if len(fem_failed) > 0:
                logger.warn('FEM initialization failed: %s' % (','.join(fem_failed)))

            pam_failed = corr.initialize_pams(**kwargs)
            if len(pam_failed) > 0:
                logger.warn('PAM initialization failed: %s' % (','.join(pam_failed)))

        if args.dest or args.forcedest:
            kwargs = {
                'multithread': True,
                'force': args.forcedest,
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
            warn_failed(logger, failed, 'config_dest_eths', all_snaps=args.allsnaps)

        #if args.tvg:
        #    logger.info('Enabling EQ TVGs...')
        #    corr.do_for_all_f("write_freq_ramp", block="eq_tvg")
        #    corr.do_for_all_f("tvg_enable", block="eq_tvg")

        # Select SNAP F-Engine input to be adc or digital noise
        init_time = time.time()
        failed = corr.set_input_fengs(source=args.snap_source, seed=args.snap_seed)
        warn_failed(logger, failed, 'set_input_fengs', all_snaps=args.allsnaps)

        # Sync logic. Do global sync first, and then noise generators
        # wait for a PPS to pass then arm all the boards
        if args.sync:
            #corr.disable_eths() # ARP: no need to disable, and keeping them enabled reduces risk of them going incommunicado
            corr.sync()

        if args.eth:
            failed = corr.enable_eths(max_enabled=args.max_eth_enabled)
            warn_failed(logger, failed, 'enable_eths', all_snaps=args.allsnaps)
        else:
            failed = corr.disable_eths()
            warn_failed(logger, failed, 'disable_eths', all_snaps=args.allsnaps)

        # Re-enable the monitoring process
        corr.enable_monitoring()

        logger.info('Initialization complete')

    except(AssertionError) as e:
        logger.error('FAILURE!\n' + e.message)
    finally:
        if args.ipython:
            import IPython
            IPython.embed()


if __name__ == "__main__":
    main()
