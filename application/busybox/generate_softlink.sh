#!/bin/sh

busybox_utils_raw="
addgroup, adduser, ar, arping, ash, awk, basename, blkid,
bunzip2, bzcat, cat, catv, chattr, chgrp, chmod, chown, chroot, chrt,
chvt, cksum, clear, cmp, cp, cpio, crond, crontab, cut, date, dc, dd,
deallocvt, delgroup, deluser, devmem, df, dhcprelay, diff, dirname,
dmesg, dnsd, dnsdomainname, dos2unix, du, dumpkmap, dumpleases, echo,
egrep, eject, env, ether-wake, expr, false, fdflush, fdformat, fgrep,
find, fold, free, freeramdisk, fsck, fstrim, fuser, getopt, getty,
grep, gunzip, gzip, halt, hdparm, head, hexdump, hostid, hostname,
hwclock, id, ifconfig, ifdown, ifup, inetd, init, insmod, install, ip,
ipaddr, ipcrm, ipcs, iplink, iproute, iprule, iptunnel, kill, killall,
killall5, klogd, last, less, linux32, linux64, linuxrc, ln, loadfont,
loadkmap, logger, login, logname, losetup, ls, lsattr, lsmod, lsof,
lspci, lsusb, lzcat, lzma, makedevs, md5sum, mdev, mesg, microcom,
mkdir, mkfifo, mknod, mkswap, mktemp, modprobe, more, mount,
mountpoint, mt, mv, nameif, netstat, nice, nohup, nslookup, od, openvt,
passwd, patch, pidof, ping, pipe_progress, pivot_root, poweroff,
printenv, printf, ps, pwd, rdate, readlink, readprofile, realpath,
reboot, renice, reset, resize, rm, rmdir, rmmod, route, run-parts,
runlevel, sed, seq, setarch, setconsole, setkeycodes, setlogcons,
setserial, setsid, sh, sha1sum, sha256sum, sha3sum, sha512sum, sleep,
sort, start-stop-daemon, strings, stty, su, sulogin, swapoff, swapon,
switch_root, sync, sysctl, syslogd, tail, tar, tee, telnet, test, tftp,
time, top, touch, tr, traceroute, true, tty, udhcpc, udhcpc6, udhcpd,
umount, uname, uniq, unix2dos, unlzma, unxz, unzip, uptime, usleep,
uudecode, uuencode, vconfig, vi, vlock, watch, watchdog, wc, wget,
which, who, whoami, xargs, xz, xzcat, yes, zcat
"

# delete space char
busybox_utils=$(echo $busybox_utils_raw | sed -s "s/ //g")

# split to an array
arr=(${busybox_utils//,/ })
for i in ${arr[@]}
do
	echo "ln -s busybox $i"
	ln -s busybox $i
done
