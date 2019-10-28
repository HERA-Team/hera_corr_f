#!/usr/bin/env python
# -*- mode: python; coding: utf-8 -*-
# Copyright 2017-2019 the HERA Collaboration
# Licensed under the 2-clause BSD license.

"""Loop through all FEM states for given SNAPs and antenna indices."""

import os
import sys
import numpy as np
import json
import redis
import copy
import argparse
import logging
from hera_corr_f import HeraCorrelator, SnapFengine, helpers

if sys.version_info[0] < 3:
    # py2
    from plotly import graph_objs as go, subplots, io as pio
else:
    # py3
    from plotly import graph_objects as go, subplots, io as pio

logger = helpers.add_default_log_handlers(logging.getLogger(__name__),
                                          fglevel=logging.NOTSET)


def main(redishost='redishost', hostname=None, antenna_input=None,
         integration_time=None, initilize=True, no_equalization=False):
    """Loop through input hostnames and collect spectra for all FEM switch states.

    Parameters
    ----------
    redishost : str
        The name of the redis host to connect to.
    hostname : str or list of str
        hostnames to collect spectra from of the form heraNode?Snap?
        if input is 'all' all snaps in the config file will be used
    antenna_input : int, list of int, or None
        Antenna number (ADC Port #) on the snap to collect spectra from.
        Can accept a single antenna, list, or None.
        If None all antennas on a snap will be returned with spectra.
    integration_time : float
        The desired integration time in s for a spectra.
    initilize : bool
        Flag used to initialize Snap boards even if they are already programmed.
        Defualts to True.
        Set to False to not initialize Snap boards on call; however this
        is not a common option and should only be done if observing is underway.
    no_equalization : bool
        Do not divide the spectra by the the equalization coefficients

    Returns
    -------
    correlations : dict of dict of dict
        Nested dicts of correlations indexed by keys in the order
        hostname, antenna index, and load_type
    snap_to_ant : dict
        dict defining the snap to antenna mapping for HERA.

    """
    if hostname is None:
        raise ValueError("Must specify a hostname or list of hostames. "
                         "To run on all Snaps set hostame='all'")
    # not actually using the connection
    # but will bw used tempo manipulate the monitoring state
    # and find all hosts if needed.
    c = HeraCorrelator(redishost=redishost,
                       passive=True)
    if hostname:
        if not isinstance(hostname, (list, tuple)):
            hostname = [hostname]

    hostname = sorted(hostname)

    if hostname == ['all'] and not antenna_input:
        logger.info("Using all SNAPs from redis configuration")
        SNAP_HOST = sorted(list(c.config['fengines'].keys()))
        ANTENNA_INPUT = np.arange(0, 6)
    elif hostname != ['all'] and not antenna_input:
        SNAP_HOST = hostname
        ANTENNA_INPUT = np.arange(0, 6)
    else:
        SNAP_HOST = hostname
        ANTENNA_INPUT = antenna_input

    correlations = {}
    for host in SNAP_HOST:
        # Disable the monitoring process for 5 minutes,
        # to stop it interfering with this script
        c.disable_monitoring(300, wait=True)

        snap = SnapFengine(host, redishost=redishost)

        if not snap.is_programmed():
            snap.fpga.transport.prog_user_image()
            snap.initialize()

        elif initilize:
            # programmed Snap may sill need to be initialized
            snap.initialize()
        else:
            # Snap is programmed and user does not want to initialize
            pass

        if integration_time is not None:
            acc_len = int(integration_time * 250e6
                          // (snap.corr.nchans * snap.corr.spec_per_acc)
                          )
            if not acc_len == snap.corr.get_acc_len():
                snap.corr.set_acc_len(acc_len)

        host_group = correlations.setdefault(host, {})

        for antenna_ind in ANTENNA_INPUT:
            logger.info("Running FEM switch loop "
                        "for {host} antenna {ant}".format(host=host,
                                                          ant=antenna_ind)
                        )

            c.disable_monitoring(60, wait=True)
            fem_ind = antenna_ind / 2
            fem_pol = antenna_ind % 2
            fem = snap.fems[fem_ind]
            current_state = fem.switch()

            ant_group = host_group.setdefault(antenna_ind, {})

            for state in ['noise', 'load', 'antenna']:
                fem.switch(name=state)
                autocorr = snap.corr.get_new_corr(antenna_ind, antenna_ind).real

                if not no_equalization:
                    eq_coeff = snap.eq.get_coeffs(antenna_ind)
                    ant_group[state] = autocorr / eq_coeff**2

            # restore this antenna to the state it started in
            fem.switch(name=current_state[0],
                       east=current_state[1],
                       north=current_state[2])

    # Re-enable monitoring.
    c.enable_monitoring()

    redis_connection = redis.ConnectionPool(host=redishost)
    with redis.Redis(connection_pool=redis_connection) as r:
        snap_to_ant = r.hget('corr:map', 'snap_to_ant')
        if snap_to_ant is not None:
            snap_to_ant = json.loads(snap_to_ant)

    return correlations, snap_to_ant


def make_plot(correlations=None, snap_to_ant=None):
    """Make a plotly plot from input correlation dict and snap_to_ant dict.

    Parameters
    ----------
    correlations : dict of dict of dict
        Nested dicts of correlations indexed by keys in the order
        hostname, antenna index, and load_type
    snap_to_ant : dict (optional)
        dict defining the snap to antenna mapping for HERA.
        If no mapping dictionary is provided, plot names will only use ADC Port numbers

    Returns
    -------
    plotly figure


    """
    hostnames = sorted(list(correlations.keys()))

    n_plots = len(list(correlations.values())[0].keys())
    colors = {"antenna": "blue",
              "load": "orange",
              "noise": "red"
              }
    cols = np.int(np.ceil(np.sqrt(n_plots)))
    rows = np.int(np.ceil(n_plots / np.float(cols)))

    subplot_titles = []
    for n in sorted(correlations.values()[0].keys()):
        if snap_to_ant is not None:
            antpol = snap_to_ant[hostnames[0]][int(n)]
            if antpol is None:
                antpol = 'N/C'
            subplot_titles.append('ADC PORT {port}<br>{antpol}'
                                  .format(port=n, antpol=antpol)
                                  )
        else:
            subplot_titles.append('ADC PORT {port}'.format(port=n))

    fig = subplots.make_subplots(rows=rows, cols=cols,
                                 subplot_titles=subplot_titles
                                 )
    gridcolor = 'rgba(0,0,0,.125)'
    for row in range(rows + 1):
        for col in range(cols + 1):
            fig.update_xaxes(title="Frequency [MHz]", row=row, col=col,
                             gridcolor=gridcolor,
                             zerolinecolor=gridcolor
                             )
            fig.update_yaxes(title="Power [dB]", row=row, col=col,
                             gridcolor=gridcolor,
                             zerolinecolor=gridcolor
                             )

    # lost of nasty plotly code to make stuff
    freqs = np.linspace(0, 250e6, 1024)
    freqs /= 1e6
    scatters = []
    for host in hostnames:
        visible = True if host == hostnames[0] else False
        for ant in sorted(correlations[host].keys()):
            if ant == 0:
                showlegend = True
            else:
                showlegend = False
            row = ant // cols + 1
            col = ant % cols + 1
            for state in correlations[host][ant]:
                name = "{state}".format(state=state)
                autocorr = correlations[host][ant][state]
                autocorr = 10 * np.log10(np.ma.masked_invalid(autocorr)
                                         )
                autocorr = autocorr.filled(-50)
                _scatter = go.Scatter(x=freqs,
                                      y=autocorr,
                                      name=name,
                                      marker={"color": colors[state],
                                              },
                                      hovertemplate="%{x:.1f}\tMHz<br>%{y:.3f}\t[dB]",
                                      visible=visible,
                                      showlegend=showlegend
                                      )
                scatters.append(_scatter)
                fig.add_trace(_scatter, row=row, col=col)

    buttons = []
    for host_cnt, host in enumerate(hostnames):
        visibility = [h2 == host for h2 in sorted(correlations.keys())
                      for ant in correlations[h2]
                      for stat in correlations[h2][ant]
                      ]
        annos = [an for an in copy.deepcopy(fig.layout.annotations)]

        for port, _an in zip(sorted(correlations[host].keys()), annos):
            if snap_to_ant is not None:
                antpol = snap_to_ant[host][int(port)]
                if antpol is None:
                    antpol = 'N/C'
                _an.text = 'ADC PORT {port}<br>{antpol}'.format(port=port,
                                                                antpol=antpol)
            else:
                _an.text = 'ADC PORT {port}'.format(port=port)

        _button = {"args": [{"visible": visibility},
                            {"annotations": annos
                             }
                            ],
                   "label": host,
                   "method": "update"
                   }
        buttons.append(_button)

    updatemenu = go.layout.Updatemenu(
        buttons=buttons,
        direction='down',
        showactive=True,
    )

    # Finish plot
    layout = go.Layout(showlegend=True,
                       title='Antenna Fem switch states',
                       updatemenus=[updatemenu],
                       paper_bgcolor='rgba(0,0,0,0)',
                       plot_bgcolor='rgba(0,0,0,0)',
                       )
    fig.update_layout(layout)

    return fig


if __name__ == "__main__":
    desc = ('Loop through all FEM switch states ["noise", "load", "antenna"]. '
            'Record a auto-correlation spectra from the SNAP for each state. '
            'Can run on a single antenna when both "hostname" and "antenna_input" '
            'are set. If "hostname" is set with no "ANTENNA_INPUT" will run on all '
            'antennas in that SNAP. To run on all Snaps and antennas set '
            '"hostname" to all.')
    parser = argparse.ArgumentParser(description=desc,
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument(dest='hostname', type=str, nargs='+',
                        help=('Host board to collect data from. '
                              'Formatted as heraNode?Snap? or '
                              '"all" for all Snaps.')
                        )
    parser.add_argument('-r', dest='redishost', type=str, default='redishost',
                        help='Host servicing redis requests')
    parser.add_argument('-a', '--antenna_input', dest='antenna_input',
                        type=int, nargs='*',
                        help="Antenna number on the SNAP to take spectra.")
    parser.add_argument('-t', '--integration_time', type=int, default=1,
                        help='Integration time in seconds for each spectra')
    parser.add_argument('-o', '--output', type=str, default='.',
                        help='Path to destination folder')
    parser.add_argument('-f', '--filename', dest='filename',
                        default='fem_status_plot.html',
                        help='Filename to save the plot.')
    parser.add_argument('--do_not_initialize', action='store_false',
                        dest='initilize',
                        help="Do not initialize the SNAP(s). "
                        "This is uncommon and should only be done "
                        "if observation is currently underway.")
    parser.add_argument('--no_equalization', action='store_true',
                        help=("Do not divide out the equalization "
                              "coefficients when taking spectra.")
                        )
    parser.add_argument('--show', dest='show', action='store_true',
                        help='Show plot.')

    args = parser.parse_args()

    correlations, snap_to_ant = main(
        redishost=args.redishost, hostname=args.hostname,
        antenna_input=args.antenna_input,
        integration_time=args.integration_time,
        initilize=args.initilize,
        no_equalization=args.no_equalization
    )

    fig = make_plot(correlations=correlations, snap_to_ant=snap_to_ant)

    if args.filename is not None:
        filename = os.path.join(args.output, args.filename)
        pio.write_html(fig, auto_open=False,
                       file=filename,
                       )
    if args.show:
        pio.show(fig)
