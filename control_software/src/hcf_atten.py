from __future__ import print_function
from hera_corr_f import HeraCorrelator
import numpy as np
from astropy.time import Time
from argparse import Namespace
import json

# XXX why namespace
Parameters = Namespace(fq0=46.9,  # low cut-off in MHz
                       fq1=234.3,  # high cut-off in MHz
                       nchan=6144,  # number of channels
                       switch_states=['antenna', 'load', 'noise']
                       )


def descriptor(**kwargs):
    """
    Generate an attenuation set description string.
    """
    slist = []
    for key, val in kwargs.items():
        if val is not None and len(val):
            slist.append(val if key == 'description' else "{}: {}".format(key, val))
    if len(slist):
        return " | ".join(slist)
    return ""


# XXX could this be stand-alone?
# XXX could this object be a "patset"
class Attenuator(HeraCorrelator):
    """
    This adds methods on top of HeraCorrelator to get and set pam attenuators.

    Defines pam attenuation sets or "patsets" as pam attenuation settings per antpol
    and stored in redis.
    """
    # XXX if inheritance, not passing anything to children
    def __init__(self):
        super(Attenuator, self).__init__()
        # XXX does HeraCorrelator have this already?
        self.antpols = {}
        for ant, val in self.ant_to_snap.items():
            for pol, hookup in val.items():
                if hookup['host'] in self.fengs:
                    self.antpols[int(ant), str(pol)] = {'host': hookup['host'],
                                                        'channel': hookup['channel']}
        self.state_time = None
        self.calc_time = None
        self.N_antpols = len(self.antpols) # XXX redundant w/ antpols
        # XXX what is this metadata
        self.patset_metadata = json.loads(self.r.hget('atten:set', 'metadata'))
        self.patsets_in_redis = list(self.patset_metadata['sets'].keys())
        self.loaded_patsets = []
        self.outcome = Namespace()

    def show_set_metadata(self):
        print(json.dumps(self.patset_metadata, indent=4))

    # XXX scope of this method nebulous, sprawling
    def get_current_state(self, update_bad_from_redis=False, verbose=False):
        """
        Get the PAM attenuators and FEM switch state from redis and correlator.

        This reads the information from both the SNAPs and redis and provides information
        on how well they agree in the dict self.outcome.get_state, which has other warning info.

        It puts the information in self.antpols[ant, pol][*].   * = ['pam_atten', 'fem_switch']
        gives the attenuation and the FEM setting and is used as the current valid data.  If there
        is no valid data from the SNAP and if update_bad_from_redis is True, then the pam_atten and
        fem_switch states from redis are used.  If no valid SNAP info and update_bad_from_redis is
        False, then those states are marked as None.

        Parameter
        ---------
        update_bad_from_redis : bool
            If error getting from correlator, use redis value.  Otherwise use None.
        """
        self.state_time = Time.now()
        self.auto_timestamp_jd = np.frombuffer(self.r_bytes.get('auto:timestamp'), np.float64)[0]
        chkap = {'pam_atten': self.get_pam_attenuation,
                 'fem_switch': self.get_fem_switch}
        self.outcome.get_state = {'redis_auto_err': set(),
                                  'snap_pam_atten_err': set(),
                                  'snap_fem_switch_err': set(),
                                  'disagree': set()}
        for ant, pol in self.antpols:
            outkey = '{}{}'.format(ant, pol)

            # Status from redis (use to check)
            antpol_redis = {}
            rkey = 'status:ant:{}:{}'.format(ant, pol)
            for cval in chkap:
                this_val = self.r.hget(rkey, cval)
                if not this_val or this_val == 'null':
                    this_val = None
                antpol_redis[cval] = this_val
            rkey = 'auto:{}{}'.format(ant, pol)
            try:
                self.antpols[ant, pol]['auto'] = np.frombuffer(self.r_bytes.get(rkey), np.float32)
            # XXX bare except
            except:  # noqa
                self.antpols[ant, pol]['auto'] = None
                self.outcome.get_state['redis_auto_err'].add(outkey)

            # Stuff from HeraCorrelator
            for cval, func in chkap.items():
                err_type = 'snap_{}_err'.format(cval)
                try:
                    self.antpols[ant, pol][cval] = func(ant, pol)
                # XXX bare except
                except:  # noqa
                    self.outcome.get_state[err_type].add(outkey)
                    # XXX use loggers
                    if verbose:
                        print("{:>3s}{} {} not found:".format(str(ant), pol, cval), end='  ')
                    if update_bad_from_redis:
                        if verbose:
                            print('set to redis value:  {}'.format(antpol_redis[cval]))
                        self.antpols[ant, pol][cval] = antpol_redis[cval]
                    else:
                        if verbose:
                            print('set to None.')
                        self.antpols[ant, pol][cval] = None
                if not self.antpols[ant, pol][cval] and not antpol_redis[cval]:
                    agree = True
                elif self.antpols[ant, pol][cval] is None or antpol_redis[cval] is None:
                    agree = False
                elif cval == 'fem_switch':
                    agree = self.antpols[ant, pol][cval] == antpol_redis[cval]
                elif cval == 'pam_atten':
                    agree = int(self.antpols[ant, pol][cval]) == int(antpol_redis[cval])
                if not agree:
                    self.outcome.get_state['disagree'].add(outkey)
                    if verbose:
                        print("{:>3s}{} {} states disagree:".format(str(ant), pol, cval), end='  ')
                        print("<redis = {}>".format(antpol_redis[cval]), end='  ')
                        print("<corr = {}>".format(self.antpols[ant, pol][cval]))
        self.loaded_patsets.append('pam_atten')
        age = float(self.state_time.jd - self.auto_timestamp_jd)
        print("Age of autos are {:.1f} sec  =  {:.2f} hours  =  {:.2f} days."
              .format(age * 3600.0 * 24.0, age * 24.0, age))
        print("Out of {} antpols:".format(self.N_antpols))
        for key, val in self.outcome.get_state.items():
            print("\t{}:  {}".format(key, len(val)))

    # XXX separate stand-alone function
    def calc_leveling(self, cf=168.0, bw=8.0,
                          target_power=75.0, default_atten=8.0, verbose=False):
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
        self.calc_time = Time.now()
        ctjd = self.calc_time.jd
        dchan = (Parameters.fq1 - Parameters.fq0) / Parameters.nchan
        ch0 = np.around((cf-bw/2) / dchan).astype(int)
        ch1 = np.around((cf+bw/2) / dchan).astype(int)
        print('Calculating equalization using {:.1f} - {:.1f} MHz  ({} - {})'.
              format((cf-bw/2.0), (cf+bw/2.0), ch0, ch1))
        print('\tTarget power {}'.format(target_power))
        print('\tAuto timestamp {:.2f} s ago'.format((ctjd - self.auto_timestamp_jd) * 24.0 * 3600))
        print('\tState loaded {:.2f} s ago'.format((ctjd - self.state_time.jd) * 24.0 * 3600))

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
                gain_dB = np.around(10*np.log10(target_power / pwr)).astype(int)
                set_val = np.array(state['pam_atten'] - gain_dB).clip(0, 15)
            self.antpols[ant, pol]['calc'] = set_val
            if verbose:
                print("{:>3s}{}:  {}  {} -> {}"
                      .format(str(ant), pol, state['fem_switch'], state['pam_atten'], set_val))
        self.loaded_patsets.append('calc')
        print("Out of {} antpols:".format(self.N_antpols))
        for key, val in self.outcome.calc_eq.items():
            print("\t{}:  {}".format(key, len(val)))

    # XXX repeats HeraCorrelator functionality
    def set_pam_attenuation(self, patset_to='calc', retries=3):
        """
        Tries to set the pam attenuation to self.antpols[ant, pol][patset_to].

        Results are in dict self.outcome.set_pam.

        Parameters
        ----------
        patset_to : str
            Values to use.
        retries : int
            Number of times to try before moving on to next antpol.
        """
        if patset_to not in self.loaded_patsets:
            print("Skipping - {} attenuation set not available.".format(patset_to))
            print("Should be one of {}".format(', '.join(self.loaded_patsets)))
            return
        self.outcome.set_pam = {'failed': set(), 'skipped': set(), 'same': set()}
        for (ant, pol), state in self.antpols.items():
            if patset_to not in state or state[patset_to] is None:
                self.outcome.set_pam['skipped'].add("{}{}".format(ant, pol))
            elif state[patset_to] == state['pam_atten']:
                self.outcome.set_pam['same'].add("{}{}".format(ant, pol))
            else:
                for i in range(retries):
                    try:
                        self.set_pam_attenuation(ant, pol, state[patset_to])
                    except (RuntimeError, IOError, AssertionError):
                        print('Failure {} / {}, trying again'.format((i+1), retries))
                        continue
                    break
                else:
                    self.outcome.set_pam['failed'].add("{}{}".format(ant, pol))
        print("Out of {} antpols:".format(self.N_antpols))
        for key, val in self.outcome.set_pam.items():
            print("\t{}:  {}".format(key, len(val)))

    # XXX worried about proliferation of sets within redis
    def load_patset(self, patset_to='calc:antenna'):
        """
        Pull attenuation values from redis as set.antpols[ant, pol][patset_to] options.

        These sets are generally put into redis via the handle_patsets method.

        Parameter
        ---------
        patset_to : str
            One of the valis sets in redis to use.
        """
        if patset_to not in self.patsets_in_redis:
            print("Skipping - {} attenuation set not available.".format(patset_to))
            print("Should be one of {}".format(', '.join(self.patsets_in_redis)))
            return
        print("Loading from redis:  {} - {}"
              .format(patset_to, self.patset_metadata['sets'][patset_to]))
        self.outcome.get_redis = {'found': set()}
        for (ant, pol) in self.antpols:
            rkey = "atten:set:{}{}".format(ant, pol)
            try:
                self.antpols[ant, pol][patset_to] = float(self.r.hget(rkey, patset_to))
                self.outcome.get_redis['found'].add("{}{}".format(ant, pol))
            except ValueError:
                self.antpols[ant, pol][patset_to] = None
        self.loaded_patsets.append(patset_to)
        print("Found {} of {} for set {}"
              .format(len(self.outcome.get_redis['found']), self.N_antpols, patset_to))

    def test_recent_settings(self):
        """
        allow for a loop back test to check success rate.
        """
        pass

    # XXX worried about proliferation of sets within redis
    def purge_patset_in_redis(self, keys):
        """
        Purge all of an atten set in redis.
        """
        for (ant, pol) in self.antpols:
            rkey = "atten:set:{}{}".format(ant, pol)
            for patset in keys:
                self.r.hdel(rkey, patset)

    # XXX worried about proliferation of sets within redis
    def read_patset_file(self, fname):
        """Read csv file for atten set."""
        fdata = {fname: {}}
        try:
            with open(fname, 'r') as fp:
                fdesc = fp.readline().strip('"')
                for line in fp:
                    ldata = line.split(',')
                    if len(ldata) == 3:
                        fdata[int(ldata[0]), ldata[1]][fname] = float(ldata[2])
        except IOError:
            return None, None
        return fdesc, fdata

    # XXX scope of this method too broad, sprawling.
    # XXX how do we ensure settings aren't lost?
    def handle_patsets(self, patset_type, patset_name=None, purge=False, description=None):
        """
        Put atten values into redis and self.antpols[ant, pol][<key>]

        This will put attenuation values into redis AND self.antpols (so you don't also
        have to self.load_atten_values_from_redis) with various options based on
        patset_type/patset_name:
            If patset_type == 'current':  use values from 'self.get_current_state'
                If patset_name is None: load to current fem_switch per antpol with "current:" prefix
                If patset_name in ['antenna', 'load', 'noise']: load that fem_switch with "current:"
                 -> for both options above, <key> will be one of "current:"[antenna, load, noise]
                Else: load values to patset_name (include description)
                 -> for option above, <key> will be patset_name
                 ->                   metadata will contain description and switch settings
            If patset_type == 'calc':  use values as calculated in 'self.calc_equalization'
                If patset_name is None:  load to current fem_switch per antpol with "calc:" prefix
                If patset_name in [...]: load that fem_switch with "calc:" prefix
                 -> for both options above, <key> will be one of calc:[...]
                Else: load values to patset_name (include description)
                 -> for option above, <key> will be patset_name
                 ->                   metadata will contain description and switch settings
                 -> Note to override antenna, load, noise, use one of those as the patset_name.
            If patset_type == 'file':  use values from csv file.
                 patset_name: name of file and used as <key>.  First line is description.

        Will purge old values of <key> in redis if purge==True.

        These sets may be read from redis via the load_patset method.

        Parameters
        ----------

        """
        patset_par = {'current':  # patset_type
                      {'key': 'pam_atten', 'time': self.state_time, 'method': 'get_current_state'},
                      'calc':     # patset_type
                      {'key': 'calc', 'time': self.calc_time, 'method': 'calc_equalization'},
                      'file':     # patset_type
                      {'key': patset_name, 'time': None, 'method': 'read_patset_file'}
                      }
        self.outcome.handle = {'updated': set(), 'float_err': set(), 'unknown_switch': set()}
        handle_time = Time.now()
        filedesc = None

        # Get set info ([patset_name], use_switch_state, the_data, filedesc)
        if patset_type in ['current', 'calc']:
            if patset_par[patset_type]['time'] is None:
                print('Skipping - must {} first'.format(patset_par[patset_type]['method']))
                return
            if patset_name is None:
                patset_name = ["{}:{}".format(patset_type, x) for x in Parameters.switch_states]
                use_switch_state = True
            elif patset_name in Parameters.switch_states:
                patset_name = ["{}:{}".format(patset_type, patset_name)]
                use_switch_state = True
            else:
                patset_name = [patset_name]
                use_switch_state = False
            the_data = self.antpols
        elif patset_type == 'file':
            filedesc, the_data = self.read_patset_file(patset_name)
            if the_data is None:
                print("Skipping - {} not found".format(patset_name))
                return
            patset_name = [patset_name]
            use_switch_state = False
        else:
            print("Skipping - {} is invalid patset_type.".format(patset_type))
            return

        if purge:  # Purge if desired
            self.purge_patset_in_redis(patset_name)

        # Copy to self.antpols and redis.
        for this_patset in patset_name:
            self.loaded_patsets.append(this_patset)
            this_switch_set = this_patset.split(':')[-1] if use_switch_state else 'useit'
            for (ant, pol), state in the_data.items():
                if use_switch_state:
                    update = "{}{}-{}".format(ant, pol, this_switch_set)
                    this_switch_state = state['fem_switch']
                    if not this_switch_state or this_switch_state == 'null':
                        self.outcome.log['unknown_switch'].add(update)
                        continue
                else:
                    update = "{}{}".format(ant, pol)
                    this_switch_state = 'useit'
                try:
                    this_value = float(state[patset_par[patset_type]['key']])
                except (ValueError, TypeError):
                    self.outcome.handle['float_err'].add(update)
                    continue
                if this_switch_set == this_switch_state:
                    self.antpols[ant, pol][this_patset] = this_value
                    rkey = "atten:set:{}{}".format(ant, pol)
                    self.r.hset(rkey, this_patset, this_value)
                    self.outcome.handle['updated'].add(update)

        # Write metadata
        description = descriptor(description=description, file_description=filedesc,
                                 patset_type=patset_type, patset_name=', '.join(patset_name),
                                 purge=str(purge), time=handle_time.isot)
        for this_set in patset_name:
            self.patset_metadata['sets'][this_set] = description
        self.r.hset('atten:set', 'metadata', json.dumps(self.patset_metadata))
        self.patsets_in_redis = list(self.patset_metadata['sets'].keys())
        print("Out of {} antpols:".format(self.N_antpols))
        for key, val in self.outcome.handle.items():
            print("\t{}:  {}".format(key, len(val)))
