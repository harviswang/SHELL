#!/bin/sh

grub-bhyve -m device.map \
           -r cd0 \
           -M 1024 \
           ubuntu1404-ceph-admin-node 
