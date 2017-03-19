#!/bin/sh

bhyve \
      -c 2 \
      -s 0,hostbridge \
      -s 3,ahci-hd,windows2016.img \
      -s 4,ahci-cd,install.iso\
      -s 10,virtio-net,tap5 \
      -s 31,lpc \
      -l com1,/dev/nmdm1A \
      -l com2,/dev/nmdm1B \
      -l bootrom,/usr/local/share/uefi-firmware/BHYVE_UEFI.fd \
      -m 1G -H -w \
      windows2016
