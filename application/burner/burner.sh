#! /bin/bash
# 本脚本用于烧录XBurst M200/M200S芯片 android 4.3/5.1系统的局部固件
# 功能:
#    烧录floader_m200_with_mbr_gpt_sleeplib_and_uboot.bin
#    烧录u-boot-with-spl-mbr-gpt.bin
#    烧录recovery.img
#    烧录boot.img
#    烧录system.img
#    清零第一分区也就是uboot所在的分区
# 方法:
#    将相应的固件dd到对应的分区结点里面

function burn_recovery_image()
{
	adb remount &&
	adb push recovery.img /data/ &&
	adb shell dd if=/data/recovery.img of=/dev/block/mmcblk0p2 &&
	adb shell sync;
}

function burn_boot_image()
{
	adb remount &&
	adb push boot.img /data/ &&
	adb shell dd if=/data/boot.img of=/dev/block/mmcblk0p1 &&
	adb shell sync;
}

function burn_uboot_image()
{
	adb remount &&
	adb push u-boot-with-spl-mbr-gpt.bin /system/ &&
	adb shell dd if=/system/u-boot-with-spl-mbr-gpt.bin of=/dev/block/mmcblk0 &&
	adb shell sync;
}

function burn_floader_image()
{
	adb remount &&
	adb push floader_m200_with_mbr_gpt_sleeplib_and_uboot.bin /system/ &&
	adb shell dd if=/system/floader_m200_with_mbr_gpt_sleeplib_and_uboot.bin of=/dev/block/mmcblk0 &&
	adb shell sync;
}

function burn_system_image()
{
	adb shell;
}

# 将uboot分区部分烧录成/dev/zero, 开机会进入烧录模式
# uboot分区一共3M = 1024*3072 Bytes大小, 全部填充zero
function burn_zero_uboot()
{
	adb shell dd if=/dev/zero of=/dev/block/mmcblk0 bs=1024 count=3072
	adb shell sync
}

function reboot()
{
#	adb reboot;
	echo $#
}

