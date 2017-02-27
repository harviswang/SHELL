#!/bin/sh

grub-bhyve -m device.map \
           -r cd0 \
           -M 256 \
           centos6 \
           < install.cfg > /dev/null
