#!/bin/sh
unzip *.zip
DISK_IMG=$(basename *.img)
echo ${DISK_IMG}
OFFSET=$(fdisk -lu $DISK_IMG | sed -n "s/\(^[^ ]*img2\)\s*\([0-9]*\)\s*\([0-9]*\)\s*\([0-9]*\).*/\2/p")
echo ${OFFSET}
mkdir rootfs
sudo  mount -o loop,offset=$(($OFFSET*512)) $DISK_IMG rootfs

# Disable preloaded shared library to get everything including networking to work on x86

sudo mv rootfs/etc/ld.so.preload rootfs/etc/ld.so.preload.bak

sudo tar cf rootfs.tar -C rootfs/ .
sudo chown ${USER}.${USER} rootfs.tar
sudo umount rootfs
sudo rmdir rootfs
rm *.img
