import hera_corr_f

snaps = ['10.0.10.110','10.0.10.111','10.0.10.109','10.0.10.113','10.0.10.114','10.0.10.201']

for snap in snaps:
    print snap
    f = hera_corr_f.snap_fengine.SnapFengine(snap)
    f.eth.disable_tx()
