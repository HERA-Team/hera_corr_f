from __future__ import print_function
from hera_corr_f import HeraCorrelator
import numpy as np
from astropy.time import Time
from argparse import Namespace


Parameters = Namespace(fq0=46.9,  # low cut-off in MHz
                       fq1=234.3,  # high cut-off in MHz
                       nchan=6144  # number of channels
                       )
DY2SC = 24 * 60 * 60


class Attenuator:
    def __init__(self):
        self.hc = HeraCorrelator()
        self.antpols = {}
        for ant, val in self.hc.ant_to_snap.items():
            for pol, hookup in val.items():
                if hookup['host'] in self.hc.fengs:
                    self.antpols[ant, pol] = {'host': hookup['host'],
                                              'channel': hookup['channel']}
        self.state_time = None
        self.eq_calc_done = False

    def get_current_state(self, update_from_redis=False):
        """
        Get the PAM attenuators and FEM switch state from redis and correlator.

        Parameter
        ---------
        update_from_redis : bool
            If error getting from correlator, use redis value.  Otherwise use None.
        """
        self.state_time = Time.now()
        self.timestamp_jd = np.frombuffer(self.hc.r_bytes.get('auto:timestamp'), np.float64)[0]
        chkap = {'pam_atten': self.hc.get_pam_attenuation, 'fem_switch': self.hc.get_fem_switch}
        for ant, pol in self.antpols:
            # Stuff from redis (use to check)
            antpol_redis = {}
            rkey = 'status:ant:{}:{}'.format(ant, pol)
            for cval in chkap:
                antpol_redis[cval] = self.hc.r.hget(rkey, cval)
            rkey = 'auto:{}{}'.format(ant, pol)
            try:
                self.antpols[ant, pol]['auto'] = np.frombuffer(self.hc.r_bytes.get(rkey), np.float32)  # noqa
            except AttributeError:
                self.antpols[ant, pol]['auto'] = None

            # Stuff from HeraCorrelator
            for cval, func in chkap.items():
                comm_stat_key = "{}_comm_stat".format(cval)
                try:
                    self.antpols[ant, pol][cval] = func(ant, pol)
                    self.antpols[ant, pol][comm_stat_key] = True
                except:  # noqa
                    self.antpols[ant, pol][comm_stat_key] = False
                    print("{} not found for {} {}".format(cval, ant, pol))
                    if update_from_redis:
                        print('\tset to redis value:  {}'.format(antpol_redis[cval]))
                        self.antpols[ant, pol][cval] = antpol_redis[cval]
                    else:
                        print('\tset to None.')
                        self.antpols[ant, pol][cval] = None
                if self.antpols[ant, pol][cval] != antpol_redis[cval]:
                    print("{} states don't agree:".format(cval))
                    print("\tredis:  {}".format(antpol_redis[cval]))
                    print("\tcorr:  {}".format(self.antpols[ant, pol][cval]))

    def calc_equalization(self, cf=168.0, bw=8.0, target_pwr=75.0, default=5.0, verbose=True):
        """
        Calculates all of the equalization attenuations.
        """
        if self.state_time is None:
            print('Skipping - must get_current_state first')
            return
        self.eq_calc_done = True
        self.calc_time = Time.now()
        ctjd = self.calc_time.jd
        dchan = (Parameters.fq1 - Parameters.fq0) / Parameters.nchan
        ch0 = np.around((cf-bw/2) / dchan).astype(int)
        ch1 = np.around((cf+bw/2) / dchan).astype(int)
        if verbose:
            print('Calculating equalization using {:.1f} - {:.1f} MHz  ({} - {})'.
                  format((cf-bw/2.0), (cf+bw/2.0), ch0, ch1))
            print('Target power {}'.format(target_pwr))
            print('Auto timestamp {:.2f} s ago'.format((ctjd - self.timestamp_jd) * DY2SC))
            print('State loaded {:.2f} s ago'.format((ctjd - self.state_time.jd) * DY2SC))

        for (ant, pol), state in self.antpols.items():

            if state['pam_atten'] is None:
                print("No current attenuation value for {}{}".format(ant, pol))
                print("Set to default value {}".format(default))
                set_val = default
            elif state['auto'] is None:
                print("No auto values for {}{}".format(ant, pol))
                print("Set to default value {}".format(default))
                set_val = default
            else:
                pwr = np.median(state['auto'][ch0:ch1])
                gain_dB = np.around(10*np.log10(target_pwr / pwr)).astype(int)
                set_val = np.array(state['pam_atten'] - gain_dB).clip(0, 15)
            self.antpols[ant, pol]['calc_pam_atten'] = set_val
            if verbose:
                print("{}{}:  {}  {} -> {}"
                      .format(ant, pol, state['fem_switch'], state['pam_atten'], set_val))

    def set_pam_attenuation(self, retries=3, set_to='calc_pam_atten'):
        """
        Actually tries to set the pam attenuation based on 'set_to' value.
        """
        self.failed = []
        self.skipped = []
        self.same = []
        for (ant, pol), state in self.antpols.items():
            if state[set_to] is None:
                self.skipped.append((ant, pol))
            elif state[set_to] == state['pam_atten']:
                self.same.append((ant, pol))
            else:
                for i in range(retries):
                    try:
                        self.hc.set_pam_attenuation(ant, pol, state[set_to])
                    except (RuntimeError, IOError, AssertionError):
                        print('Failure {} / {}, trying again'.format((i+1), retries))
                        continue
                    break
                else:
                    self.failed.append((ant, pol))
#
#     no_comms = [antpol for antpol, (cur, new) in pam_settings.items() if cur == -1]
#     big = [antpol for antpol, (cur, new) in pam_settings.items() if np.abs(cur - new) >= 3]
#     if verbose:
#         print('No Communication')
#         for ant, pol in no_comms:
#             hookup = hc.ant_to_snap[ant][pol]
#             print('   ', ant, pol, hookup['host'], hookup['channel'])
#         print('Trouble Setting Attenuation?')
#         for ant, pol in big:
#             hookup = hc.ant_to_snap[ant][pol]
#             print('   ', ant, pol, hookup['host'], hookup['channel'])
#         print('Finished loading at', cur_jd)
#
#     def log_pam_atten(self):
#         with open(outfile, 'w') as fp:
#             csv_out = csv.writer(fp, delimiter=',')
#             csv_out.writerow(['ANT', 'POL', 'SNAP', 'CH', 'OLD_ATTEN', 'NEW_ATTEN'])
#             for (ant, pol), (snap, ch) in antpols.items():
#                 # pam_num = ch // 2
#                 try:
#                     cur_atten = hc.get_pam_attenuation(ant, pol)
#                 except IOError:
#                     cur_atten = -1
#                     new_atten = -1
#
#                 pam_settings[ant, pol] = (cur_atten, new_atten)
#                 csv_out.writerow([str(val) for val in (ant, pol, snap, ch, cur_atten, new_atten)])
