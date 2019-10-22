#!/usr/bin/env python
# -*- mode: python; coding: utf-8 -*-
# Copyright 2017-2019 the HERA Collaboration
# Licensed under the 2-clause BSD license.

"""Loop through all FEM states for given SNAPs and antenna indices."""

import os
import sys
import numpy as np
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
         integration_time=None, do_not_initialize=False):

    # not actually using the connection
    # but will bw used tempo manipulate the monitoring state
    # and find all hosts if needed.
    c = HeraCorrelator(redishost=redishost,
                       passive=True)
    if hostname:
        if not isinstance(hostname, (list, tuple)):
            hostname = [hostname]

    hostname = sorted(hostname)

    if not hostname and not antenna_input:
        logger.info("Using all SNAPs from redis configuration")
        SNAP_HOST = sorted(list(c.config['fengines'].keys()))
        ANTENNA_INPUT = np.arange(0, 6)
    elif hostname and not antenna_input:
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
        if not do_not_initialize:
            snap.initialize()

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

                eq_coeff = snap.eq.get_coeffs(antenna_ind)
                ant_group[state] = autocorr / eq_coeff**2

            # restore this antenna to the state it started in
            fem.switch(name=current_state[0],
                       east=current_state[1],
                       north=current_state[2])

    # Re-enable monitoring.
    c.enable_monitoring()
    return correlations


def make_plot(correlations=None):
    n_plots = len(list(correlations.values())[0].keys())
    colors = {"antenna": "blue",
              "load": "orange",
              "noise": "red"
              }
    cols = np.int(np.ceil(np.sqrt(n_plots)))
    rows = np.int(np.ceil(n_plots / np.float(cols)))
    subplot_titles = ["ADC PORT {}".format(n)
                      for n in sorted(correlations.values()[0].keys())
                      ]
    fig = subplots.make_subplots(rows=rows, cols=cols,
                                 subplot_titles=subplot_titles
                                 )
    for row in range(rows + 1):
        for col in range(cols + 1):
            fig.update_xaxes(title="Frequency [MHz]", row=row, col=col)
            fig.update_yaxes(title="Power [dB]", row=row, col=col)

    # lost of nasty plotly code to make stuff
    freqs = np.linspace(0, 250e6, 1024)
    freqs /= 1e6
    scatters = []
    hostnames = sorted(list(correlations.keys()))
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
                                      host=host,
                                      marker={"color": colors[state],
                                              },
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
        _button = {"args": [{"visible": visibility},
                            {  # "title": '',
                            "annotations": {}
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
                       updatemenus=[updatemenu]
                       )
    fig.update_layout(layout)

    return fig


if __name__ == "__main__":
    desc = ('Loop through all FEM switch states ["noise", "load", "antenna"]. '
            'Record a auto-correlation spectra from the SNAP for each state. '
            'Can run on a single antenna when both "hostname" and "antenna_input" '
            'are set. If "hostname" is set with no "ANTENNA_INPUT" will run on all '
            'antennas in that SNAP. If both inputs "hostname" '
            'and "antenna_input" are not provides, will loop through all SNAPS '
            'and all antennas.')
    parser = argparse.ArgumentParser(description=desc,
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument(dest='hostname', type=str, nargs='*',
                        help='Host board to collect data from.')
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
    parser.add_argument('--do_not_initialize', action='store_true',
                        help="Do not initialize the SNAP(s). "
                        "This is uncommon and should only be done "
                        "if observation is currently underway.")
    parser.add_argument('--show', dest='show', action='store_true',
                        help='Show plot.')

    args = parser.parse_args()

    correlations = main(
        redishost=args.redishost, hostname=args.hostname,
        antenna_input=args.antenna_input,
        integration_time=args.integration_time,
        do_not_initialize=args.do_not_initialize
    )

    fig = make_plot(correlations=correlations)

    if args.filename is not None:
        filename = os.path.join(args.output, args.filename)
        pio.write_html(fig, auto_open=False,
                       file=filename,
                       )
    if args.show:
        pio.show(fig)
