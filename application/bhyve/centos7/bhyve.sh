#!/bin/sh

bhyve -A -H -P \
      -s 0:0,hostbridge \
      -s 1:0,lpc \
      -s 2:0,virtio-net,tap98 \
      -s 3:0,virtio-blk,/usr/home/harvis/VirtualMachine/Centos7/centos7.img \
      -s 4:0,ahci-cd,/usr/home/harvis/VirtualMachine/Centos7/CentOS-7-x86_64-Minimal-1503.iso \
      -l com1,stdio \
      -m 512M \
      centos7 
