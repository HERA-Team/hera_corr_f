from __future__ import print_function
from hera_corr_f import HeraCorrelator
import numpy as np
from astropy.time import Time
from argparse import Namespace
import json


Parameters = Namespace(fq0=46.9,  # low cut-off in MHz
                       fq1=234.3,  # high cut-off in MHz
                       nchan=6144,  # number of channels
                       switch_states=['antenna', 'load', 'noise']
                       )


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
        self.atten_metadata = json.loads(self.hc.r.hget('atten:set', 'metadata'))
        self.valid_sets = list(self.atten_metadata['sets'].keys())
        self.outcome = Namespace()

    def show_metadata(self):
        print(json.dumps(self.atten_metadata, indent=4))

    def get_current_state(self, update_from_redis=False):
        """
        Get the PAM attenuators and FEM switch state from redis and correlator.

        This reads the information from both the SNAPs and redis and provides information
        on how well they agree in the dict self.outcome.get_state, which has other warning info.

        It puts the information in self.antpols[ant, pol][*].   * = ['pam_atten', 'fem_switch']
        gives the attenuation and the FEM setting and is used as the current valid data.  If there
        is no valid data from the SNAP and if update_from_redis is True, then the pam_atten and
        fem_switch states from redis are used.  If no valid SNAP info and update_from_redis is
        False, then those states are marked as None.

        Parameter
        ---------
        update_from_redis : bool
            If error getting from correlator, use redis value.  Otherwise use None.
        """
        self.state_time = Time.now()
        self.auto_timestamp_jd = np.frombuffer(self.hc.r_bytes.get('auto:timestamp'), np.float64)[0]
        chkap = {'pam_atten': self.hc.get_pam_attenuation,
                 'fem_switch': self__hc__get_fem_switch}
        self.outcome.get_state = {'redis_auto_err': set(),
                                  'snap_pam_atten_err': set(),
                                  'snap_fem_switch_err': set(),
                                  'disagree': set()}
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
            except:  # noqa
                self.antpols[ant, pol]['auto'] = None
                self.outcome.get_state['redis_auto_err'].add(outkey)

            # Stuff from HeraCorrelator
            for cval, func in chkap.items():
                comm_stat_key = "{}_comm_stat".format(cval)
                err_type = 'snap_{}_err'.format(cval)
                try:
                    self.antpols[ant, pol][cval] = func(ant, pol)
                    self.antpols[ant, pol][comm_stat_key] = True
                except:  # noqa
                    self.outcome.get_state[err_type].add(outkey)
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
                    self.outcome.get_state['disagree'].add(outkey)
                    print("{:>3s}{} {} states disagree:".format(str(ant), pol, cval), end='  ')
                    print("<redis = {}>".format(antpol_redis[cval]), end='  ')
                    print("<corr = {}>".format(self.antpols[ant, pol][cval]))
        print("Out of {} antpols:".format(self.N_antpols))
        for key, val in self.outcome.get_state.items():
            print("\t{}:  {}".format(key, len(val)))

    def calc_equalization(self, cf=168.0, bw=8.0, target_pwr=75.0, default_atten=5.0, verbose=True):
        """
        Calculates all of the equalization attenuations.

        Warnings are stored in dict self.outcome.cal_eq.

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
        print('\tTarget power {}'.format(target_pwr))
        print('\tAuto timestamp {:.2f} s ago'.format((ctjd - self.auto_timestamp_jd) * 24 * 3600))
        print('\tState loaded {:.2f} s ago'.format((ctjd - self.state_time.jd) * 24 * 3600))

        self.outcome.calc_eq = {'no_atten': set(), 'no_auto': set()}
        for (ant, pol), state in self.antpols.items():
            if state['pam_atten'] is None or state['auto'] is None:
                err_type = "no_atten" if state['pam_atten'] is None else "no_auto"
                self.outcome.calc_eq[err_type].add("{}{}".format(ant, pol))
                if verbose:
                    print("{:>3s}{}:  {} value:".format(str(ant), pol, err_type), end='  ')
                    print("set to default value {}".format(default_atten))
                set_val = default_atten
            else:
                pwr = np.median(state['auto'][ch0:ch1])
                gain_dB = np.around(10*np.log10(target_pwr / pwr)).astype(int)
                set_val = np.array(state['pam_atten'] - gain_dB).clip(0, 15)
            self.antpols[ant, pol]['calc'] = set_val
            if verbose:
                print("{:>3s}{}:  {}  {} -> {}"
                      .format(str(ant), pol, state['fem_switch'], state['pam_atten'], set_val))
        print("Out of {} antpols:".format(self.N_antpols))
        for key, val in self.outcome.calc_eq.items():
            print("\t{}:  {}".format(key, len(val)))

    def set_pam_attenuation(self, set_to='calc', retries=3):
        """
        Tries to set the pam attenuation to self.antpols[ant, pol][set_to].

        Results are in dict self.outcome.set_pam.

        Parameters
        ----------
        set_to : str
            Values to use.
        retries : int
            Number of times to try before moving on to next antpol.
        """
        if set_to not in self.valid_sets:
            print("Skipping - {} attenuation values not available.".format(set_to))
            print("Should be one of {}".format(', '.join(self.valid_sets)))
            return
        self.outcome.set_pam = {'failed': set(), 'skipped': set(), 'same': set()}
        for (ant, pol), state in self.antpols.items():
            if state[set_to] is None:
                self.outcome.set_pam['skipped'].add("{}{}".format(ant, pol))
            elif state[set_to] == state['pam_atten']:
                self.outcome.set_pam['same'].add("{}{}".format(ant, pol))
            else:
                for i in range(retries):
                    try:
                        self__hc__set_pam_attenuation(ant, pol, state[set_to])
                    except (RuntimeError, IOError, AssertionError):
                        print('Failure {} / {}, trying again'.format((i+1), retries))
                        continue
                    break
                else:
                    self.outcome.set_pam['failed'].add("{}{}".format(ant, pol))
        print("Out of {} antpols:".format(self.N_antpols))
        for key, val in self.outcome.set_pam.items():
            print("\t{}:  {}".format(key, len(val)))

    def get_state_atten_values(self, set_to='antenna'):
        """
        Pull attenuation values from redis as set.antpols[ant, pol][set_to] options.

        Parameter
        ---------
        set_to : str
            One of the valis sets in redis to use.
        """
        if set_to not in self.valid_sets:
            print("Skipping - {} attenuation values not available.".format(set_to))
            print("Should be one of {}".format(', '.join(self.valid_sets)))
            return
        self.outcome.get_redis = {'found': set()}
        for (ant, pol) in self.antpols:
            rkey = "atten:set:{}{}".format(ant, pol)
            try:
                self.antpols[ant, pol][set_to] = float(self.hc.r.hget(rkey, set_to))
                self.outcome.get_redis['found'].add("{}{}".format(ant, pol))
            except ValueError:
                continue
        print("Found {} of {} for set {}"
              .format(len(self.outcome.get_redis['found']), self.N_antpols, set_to))

    def test_recent_settings(self):
        """
        allow for a loop back test to check success rate.
        """

    def log_atten_values_to_redis(self, set_class, set_name=None, purge=False,
                                  description=None):
        """
        Put atten values into redis - purge old values of same key if purge==True.

        This will put attenuation values into redis with various options based on
        set_class/set_name:
            If set_class == 'current':  use values from 'self.get_current_state'
                If set_name is None:  load to current fem_switch state per antpol.
                If set_name in ['antenna', 'load', 'noise']:  load only that fem_switch state
                 -> for 2 options above, redis key will be one of antenna, load, noise
                Else: load values to set_name (include description)
                 -> for option above, redis key will be set_name
                 ->                   metadata will contain the switch settings
            If set_class == 'calc':  use values as calculated in 'self.calc_equalization'
                Must have a set name.  Include a description.  Note to override antenna,
                load, noise, use one of those as the set_name.
            If set_class == 'file':  use values from csv file.
                 set_name: name of file and used as redis key.  First line is description (in "")

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
            this_switch_state = state['fem_switch']
            if not this_switch_state:
                this_switch_state = 'Unknown'
                self.outcome.log.unknown.append('{}{}'.format(ant, pol))
            if state['pam_atten'] and (switch == 'all' or switch == this_switch_state):
                rkey = "atten:set:{}{}".format(ant, pol)
                self.hc.r.hset(rkey, this_switch_state, state['pam_atten'])
                self.outcome.log.updated.append("{}{}".format(ant, pol))
        print("Updated {} of {} values for {}.  {} were unknown."
              .format(len(self.outcome.log.updated), self.N_antpols,
                      switch, len(self.outcome.log.unknown)))
