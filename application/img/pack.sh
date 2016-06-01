#!/bin/bash
#
#
#  unpack()实现从boot.img -> kernel + ramdisk/
#  pack()实现从kernel + rmadisk/ -> boot.img
#  用于快速编辑boot.img里面的ramdisk文件，尤其是inti.*.rc文件

function unpack () {
    ##unmkbootimg /path/to/boot.img
    UNMKBOOTIMG=~/B/opensource/bootimg-tools/mkbootimg/unmkbootimg
    echo "${UNMKBOOTIMG} $1"
    ${UNMKBOOTIMG} --input $1

    ##gzip -d ramdisk.cpio.gz
    echo "gzip -d ramdisk.cpio.gz"
    gzip -d ramdisk.cpio.gz
    
    ##cpio -i ramdisk.cpio
    echo "cpio -i ../ramdisk.cpio"
    mkdir ramdisk
    cd ramdisk/
    cpio -i < ../ramdisk.cpio
    cd ..
    
    ##rm ramdisk.cpio
    echo "rm ramdisk.cpio"
    rm ramdisk.cpio
}

function pack () {
    MKBOOTIMG=~/B/opensource/bootimg-tools/mkbootimg/mkbootimg
    
    # rmadisk/ -> ramdisk.cpio
    cd ramdisk/
    find . | cpio -H newc -o > ../ramdisk.cpio
    cd ..
    
    # ramdisk.cpio -> ramdisk.cpio.gz
    gzip ramdisk.cpio
    
    # kernel + ramdisk.cpio.gz -> boot.img
    ${MKBOOTIMG} --kernel kernel --ramdisk ramdisk.cpio.gz --output boot.img
    
    # ramdisk.cpio.gz -> ramdisk.img
    #mv ramdisk.cpio.gz ramdisk.img
}
