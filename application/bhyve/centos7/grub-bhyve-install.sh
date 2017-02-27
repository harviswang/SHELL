#!/bin/sh

grub-bhyve -m device.map \
           -r cd0 \
           -M 512M \
           centos7 \
           < install.cfg > /dev/null 
