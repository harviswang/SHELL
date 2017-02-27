#!/bin/sh

bhyve -A -H -P \
      -s 0:0,hostbridge \
      -s 1:0,lpc \
      -s 2:0,virtio-net,tap0 \
      -s 3:0,virtio-blk,/usr/home/harvis/VirtualMachine/ubuntu1404-ceph-admin-node/ubuntu1404.img\
      -s 4:0,ahci-cd,/usr/home/harvis/VirtualMachine/ubuntu1404-ceph-admin-node/ubuntu-14.04.5-server-amd64.iso\
      -l com1,stdio \
      -m 512M \
      ubuntu1404-ceph-admin-node 
