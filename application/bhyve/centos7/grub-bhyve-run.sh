#!/bin/sh

grub-bhyve -m device.map \
           -r hd0 \
           -M 512 \
           centos7  < run.cfg > /dev/null 
