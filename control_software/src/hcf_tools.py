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
        self.N_antpols = len(self.antpols)
        self.outcome = Namespace()

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
        chkap = {'pam_atten': self.hc.get_pam_attenuation,
                 'fem_switch': self__hc__get_fem_switch}
        self.outcome.get_state = Namespace()
        self.outcome.get_state.not_fully_successful = set()
        self.outcome.get_state.did_not_agree = set()
        for ant, pol in self.antpols:
            outkey = '{}{}'.format(ant, pol)

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
                self.outcome.get_state.not_fully_successful.add(outkey)

            # Stuff from HeraCorrelator
            for cval, func in chkap.items():
                comm_stat_key = "{}_comm_stat".format(cval)
                try:
                    self.antpols[ant, pol][cval] = func(ant, pol)
                    self.antpols[ant, pol][comm_stat_key] = True
                except:  # noqa
                    self.outcome.get_state.not_fully_successful.add(outkey)
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
                    self.outcome.get_state.did_not_agree.add(outkey)
                    print("{:>3s}{} {} states disagree:".format(str(ant), pol, cval), end='  ')
                    print("<redis = {}>".format(antpol_redis[cval]), end='  ')
                    print("<corr = {}>".format(self.antpols[ant, pol][cval]))
        print("{} out of {} were not fully successful."
              .format(len(self.outcome.get_state.not_fully_successful), self.N_antpols))
        print("{} out of {} did not fully agree."
              .format(len(self.outcome.get_state.did_not_agree), self.N_antpols))

    def calc_equalization(self, cf=168.0, bw=8.0, target_pwr=75.0, default_atten=5.0, verbose=True):
        """
        Calculates all of the equalization attenuations.

        Parameters
        ----------
        cf : float
            Center frequency in MHz
        bw : float
            Bandwidth in MHz
        target_power : float
            Target_power in linear units
        default_atten : float
            Default attenuation to use in dB
        verbose : bool
            Flag for verbose mode
        """
        if self.state_time is None:
            print('Skipping - must get_current_state first')
            return
        self.atten_set_options.append('calc')
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

        self.outcome.calc_eq = Namespace()
        self.outcome.calc_eq.success = []
        for (ant, pol), state in self.antpols.items():
            if state['pam_atten'] is None or state['auto'] is None:
                if verbose:
                    vstr = "No current attenuation value" if state['pam_atten'] is None \
                           else "No auto values"
                    print("{:>3s}{}:  {}:".format(str(ant), pol, vstr), end='  ')
                    print("set to default value {}".format(default_atten))
                set_val = default_atten
            else:
                self.outcome.calc_eq.success.append("{}{}".format(ant, pol))
                pwr = np.median(state['auto'][ch0:ch1])
                gain_dB = np.around(10*np.log10(target_pwr / pwr)).astype(int)
                set_val = np.array(state['pam_atten'] - gain_dB).clip(0, 15)
            self.antpols[ant, pol]['calc'] = set_val
            if verbose:
                print("{:>3s}{}:  {}  {} -> {}"
                      .format(str(ant), pol, state['fem_switch'], state['pam_atten'], set_val))
        print("{} out of {} successful".format(len(self.outcome.calc_eq.success), self.N_antpols))

    def set_pam_attenuation(self, retries=3, set_to='calc'):
        """
        Tries to set the pam attenuation based on 'set_to' value.
        """
        if set_to not in self.atten_set_options:
            print("Skipping - {} attenuation values not available.".format(set_to))
            return
        self.outcome.set_pam = Namespace()
        self.outcome.set_pam.failed = []
        self.outcome.set_pam.skipped = []
        self.outcome.set_pam.same = []
        for (ant, pol), state in self.antpols.items():
            if state[set_to] is None:
                self.outcome.set_pam.skipped.append((ant, pol))
            elif state[set_to] == state['pam_atten']:
                self.outcome.set_pam.same.append("{}{}".format(ant, pol))
            else:
                for i in range(retries):
                    try:
                        self__hc__set_pam_attenuation(ant, pol, state[set_to])
                    except (RuntimeError, IOError, AssertionError):
                        print('Failure {} / {}, trying again'.format((i+1), retries))
                        continue
                    break
                else:
                    self.outcome.set_pam.failed.append((ant, pol))
        print("Total antpols to set: {}  ({} were same)."
              .format(self.N_antpols, len(self.outcome.set_pam.same)))
        print("\t{} failed.".format(len(self.outcome.set_pam.failed)))
        print("\t{} skipped.".format(len(self.outcome.set_pam.skipped)))

    def get_state_atten_values(self, switch='antenna'):
        """
        Pull eq values from redis, and pull them here as 'set_to' options.

        Parameter
        ---------
        switch : str
            One of the allowed Parameters.switch_states
        """
        if switch not in Parameters.switch_states:
            print("Skipping - {} not available.".format(switch))
            return
        self.outcome.get_redis = Namespace()
        self.outcome.get_redis.found = []
        self.atten_set_options.append(switch)
        for (ant, pol), state in self.antpols.items():
            rkey = "atten:set:{}{}".format(ant, pol)
            try:
                self.antpols[ant, pol][switch] = float(self.hc.r.hget(rkey, switch))
                self.outcome.get_redis.found.append("{}{}".format(ant, pol))
            except ValueError:
                continue
        print("Found {} of {} for switch {}"
              .format(len(self.outcome.get_redis.found), self.N_antpols, switch))

    def log_state_atten_values(self, switch='all'):
        """
        Put atten values into redis.

        This will put attenuation values into redis for various switch values:
            'all':  all known values
            'antenna', 'load', 'noise':  only that switch state

        Parameter
        ---------
        switch : str
            One of the allowed Parameters.switch_states or 'all'
        """
        if self.state_time is None:
            print('Skipping - must get_current_state first')
            return
        self.outcome.log = Namespace()
        self.outcome.log.updated = []
        self.outcome.log.unknown = []
        for (ant, pol), state in self.antpols.items():
            rkey = "atten:set:{}{}".format(ant, pol)
            this_switch_state = state['fem_switch']
            if not this_switch_state:
                this_switch_state = 'Unknown'
                self.outcome.log.unknown.append('{}{}'.format(ant, pol))
            if state['pam_atten'] and (switch == 'all' or switch == this_switch_state):
                self.hc.r.hset(rkey, this_switch_state, state['pam_atten'])
                self.outcome.log.updated.append("{}{}".format(ant, pol))
        print("Updated {} of {} values for {}.  {} were unknown."
              .format(len(self.outcome.log.updated), self.N_antpols,
                      switch, self.outcome.log.unknown))
