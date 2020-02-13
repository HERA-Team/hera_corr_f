# Add SNAPs to the correlator.
David DeBoer - February 12, 2020

The steps below relate to hera-snap-head.  You will need to sudo to make changes.
1. Verify that the SNAPs are in /etc/ethers (MAC address and SNAP name)
2. Add the SNAP hostname to /etc/hosts file
3. Add the SNAPs to the config file in the repo.  This should be done with GitHub etc/etc
   https://github.com/HERA-Team/hera_corr_f/blob/master/control_software/config/hera_feng_config.yaml
4. Upload the config file to redis
   https://github.com/HERA-Team/hera_corr_f/blob/master/control_software/scripts/hera_upload_config_to_redis.py
   (or I think there hera a hera_corr_cm method to do the same thing)
5. Reset dnsmasq via the script reset_dnsmasq.sh

At the point you've loaded the config to redis and it should be active when you run e.g.
hera_snap_feng_init.py or other F-engine scripts. Things like the SNAP monitor should pick up
the new config automatically.

Note that the RFI testing write-up has some helpful stuff (since SNAPs get added there):
https://docs.google.com/document/d/1kMEwdN1F9zylfThGX56OnC0vd-AzWmBqsY3oLVmqKFU/edit?us
