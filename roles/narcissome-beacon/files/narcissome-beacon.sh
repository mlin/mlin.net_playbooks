#!/bin/bash -e
cd /home/mlin/beacon
zcat mlin_narcissome.beacondata.gz | ./beacon_server --localhost --id=narcissome.mlin.net --organization=mlin.net --description="Mike Lin's Genome" --reference=GRCh37 --catchall="https://www.mlin.net/" --qps 1 --backlog 10 --bucket 4000 >> /var/log/beacon/beacon.log
