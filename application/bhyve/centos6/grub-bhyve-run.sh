#!/bin/sh

grub-bhyve -m device.map \
           -r hd0 \
           -M 256 \
           centos6 < run.cfg > /dev/null
