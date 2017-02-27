#!/bin/sh

bhyve -A -H -P \
      -s 0:0,hostbridge \
      -s 1:0,lpc \
      -s 2:0,virtio-net,tap99 \
      -s 3:0,virtio-blk,/home/harvis/VirtualMachine/centos6/centos6.img\
      -s 4:0,ahci-cd,/home/harvis/VirtualMachine/centos6/CentOS-6.8-x86_64-minimal.iso\
      -l com1,stdio \
      -m 256M \
      centos6 
