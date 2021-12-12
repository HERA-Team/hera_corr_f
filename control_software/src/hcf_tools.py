from __future__ import print_function
from hera_corr_f import HeraCorrelator
import numpy as np
from astropy.time import Time
from argparse import Namespace


Parameters = Namespace(fq0=46.9,  # low cut-off in MHz
                       fq1=234.3,  # high cut-off in MHz
                       nchan=6144,  # number of channels
                       switch_states=['antenna', 'load', 'noise']
                       )
DY2SC = 24 * 60 * 60


def self__hc__get_fem_switch(a, b):
    return 'Fake'


def self__hc__set_pam_attenuation(a, b, c):
    return


class Attenuator:
    def __init__(self):
        self.hc = HeraCorrelator()
        self.antpols = {}
        for ant, val in self.hc.ant_to_snap.items():
            for pol, hookup in val.items():
                if hookup['host'] in self.hc.fengs:
                    self.antpols[int(ant), str(pol)] = {'host': hookup['host'],
                                                        'channel': hookup['channel']}
        self.state_time = None
        self.atten_set_options = []

    def get_current_state(self, update_from_redis=False):
        """
        Get the PAM attenuators and FEM switch state from redis and correlator.

        Parameter
        ---------
        update_from_redis : bool
            If error getting from correlator, use redis value.  Otherwise use None.
        """
        self.state_time = Time.now()
        self.auto_timestamp_jd = np.frombuffer(self.hc.r_bytes.get('auto:timestamp'), np.float64)[0]
        chkap = {'pam_atten': self.hc.get_pam_attenuation, 'fem_switch': self__hc__get_fem_switch}
        not_fully_successful = set()
        did_not_agree = set()
        for ant, pol in self.antpols:
            nfskey = '{}{}'.format(ant, pol)
            # Stuff from redis (use to check)
            antpol_redis = {}
            rkey = 'status:ant:{}:{}'.format(ant, pol)
            for cval in chkap:
                this_val = self.hc.r.hget(rkey, cval)
                if not this_val or this_val == 'null':
                    this_val = None
                antpol_redis[cval] = this_val
            rkey = 'auto:{}{}'.format(ant, pol)
            try:
                self.antpols[ant, pol]['auto'] = np.frombuffer(self.hc.r_bytes.get(rkey), np.float32)  # noqa
            except AttributeError:
                self.antpols[ant, pol]['auto'] = None
                not_fully_successful.add(nfskey)

            # Stuff from HeraCorrelator
            for cval, func in chkap.items():
                comm_stat_key = "{}_comm_stat".format(cval)
                try:
                    self.antpols[ant, pol][cval] = func(ant, pol)
                    self.antpols[ant, pol][comm_stat_key] = True
                except:  # noqa
                    not_fully_successful.add(nfskey)
                    self.antpols[ant, pol][comm_stat_key] = False
                    print("{:>3s}{} {} not found:".format(str(ant), pol, cval), end='  ')
                    if update_from_redis:
                        print('set to redis value:  {}'.format(antpol_redis[cval]))
                        self.antpols[ant, pol][cval] = antpol_redis[cval]
                    else:
                        print('set to None.')
                        self.antpols[ant, pol][cval] = None
                if not self.antpols[ant, pol][cval] and not antpol_redis[cval]:
                    agree = True
                elif self.antpols[ant, pol][cval] is None or antpol_redis[cval] is None:
                    agree = False
                elif cval == 'fem_switch':
                    agree = self.antpols[ant, pol][cval] in ['Fake', antpol_redis[cval]]
                elif cval == 'pam_atten':
                    agree = int(self.antpols[ant, pol][cval]) == int(antpol_redis[cval])
                else:
                    print("{} not allowed.".format(cval))
                    agree = False
                if not agree:
                    did_not_agree.add(nfskey)
                    print("{:>3s}{} {} states disagree:".format(str(ant), pol, cval), end='  ')
                    print("<redis = {}>".format(antpol_redis[cval]), end='  ')
                    print("<corr = {}>".format(self.antpols[ant, pol][cval]))
        print("{} out of {} were not fully successful."
              .format(len(not_fully_successful), len(self.antpols)))
        print("{} out of {} did not fully agree."
              .format(len(did_not_agree), len(self.antpols)))

    def calc_equalization(self, cf=168.0, bw=8.0, target_pwr=75.0, default_atten=5.0, verbose=True):
        """
        Calculates all of the equalization attenuations.
        """
        if self.state_time is None:
            print('Skipping - must get_current_state first')
            return
        self.atten_set_options.append('calc_pam_atten')
        self.calc_time = Time.now()
        ctjd = self.calc_time.jd
        dchan = (Parameters.fq1 - Parameters.fq0) / Parameters.nchan
        ch0 = np.around((cf-bw/2) / dchan).astype(int)
        ch1 = np.around((cf+bw/2) / dchan).astype(int)
        print('Calculating equalization using {:.1f} - {:.1f} MHz  ({} - {})'.
              format((cf-bw/2.0), (cf+bw/2.0), ch0, ch1))
        print('Target power {}'.format(target_pwr))
        print('Auto timestamp {:.2f} s ago'.format((ctjd - self.auto_timestamp_jd) * DY2SC))
        print('State loaded {:.2f} s ago'.format((ctjd - self.state_time.jd) * DY2SC))

        success = []
        for (ant, pol), state in self.antpols.items():
            if state['pam_atten'] is None:
                if verbose:
                    print("No current attenuation value for {}{}".format(ant, pol))
                    print("Set to default value {}".format(default_atten))
                set_val = default_atten
            elif state['auto'] is None:
                if verbose:
                    print("No auto values for {}{}".format(ant, pol))
                    print("Set to default value {}".format(default_atten))
                set_val = default_atten
            else:
                success.append("{}{}".format(ant, pol))
                pwr = np.median(state['auto'][ch0:ch1])
                gain_dB = np.around(10*np.log10(target_pwr / pwr)).astype(int)
                set_val = np.array(state['pam_atten'] - gain_dB).clip(0, 15)
            self.antpols[ant, pol]['calc_pam_atten'] = set_val
            if verbose:
                print("{}{}:  {}  {} -> {}"
                      .format(ant, pol, state['fem_switch'], state['pam_atten'], set_val))
        print("{} out of {} were successful".format(len(success), len(self.antpols)))

    def set_pam_attenuation(self, retries=3, set_to='calc_pam_atten'):
        """
        Tries to set the pam attenuation based on 'set_to' value.
        """
        if set_to not in self.atten_set_options:
            print("{} attenuation values not available.".format(set_to))
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
                        self__hc__set_pam_attenuation(ant, pol, state[set_to])
                    except (RuntimeError, IOError, AssertionError):
                        print('Failure {} / {}, trying again'.format((i+1), retries))
                        continue
                    break
                else:
                    self.failed.append((ant, pol))

    def get_state_atten_values(self, switch='antenna'):
        print("Pull eq values in redis, and pull them in here as 'set_to' options")
        if switch not in Parameters.switch_states:
            print("{} not available.".format(switch))
            return
        set_name = "{}_pam_atten".format(switch)
        self.atten_set_options.append(set_name)
        for (ant, pol), state in self.antpols.items():
            rkey = "atten:set:{}{}".format(ant, pol)
            self.antpols[ant, pol][set_name] = self.hc.r.hget(rkey, switch)

    def log_state_atten_values(self):
        if self.state_time is None:
            print('Skipping - must get_current_state first')
            return
        for (ant, pol), state in self.antpols.items():
            rkey = "atten:set:{}{}".format(ant, pol)
            switch_state = state['fem_switch']
            if not switch_state:
                switch_state = 'Unknown'
            if state['pam_atten']:
                self.hc.r.hset(rkey, switch_state, state['pam_atten'])
