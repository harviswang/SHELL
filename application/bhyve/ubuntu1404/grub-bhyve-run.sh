#!/bin/sh

grub-bhyve -m device.map \
           -r hd0 \
           -M 512 \
           ubuntu1404-ceph-admin-node \
           < run.cfg > /dev/null
