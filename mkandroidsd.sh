#!/bin/bash
# taken from rowboat packaging script

EXPECTED_ARGS=1
if [ $# == $EXPECTED_ARGS ]; then
	echo "Assuming Default Locations for Prebuilt Images"
	$0 $1 MLO u-boot.bin uImage boot.scr rootfs.tar.bz2 Media 
	exit
fi

if [[ -z $1 || -z $2 || -z $3 || -z $4 ]]; then
	echo "$0 Usage:"
	echo "	$0 <device> <MLO> <u-boot.bin> <uImage> <boot.scr> <rootfs tar.bz2> [Media Folder]"
	echo "	Example: mkmmc-android /dev/mmcblk0 MLO u-boot.bin uImage boot.scr rootfs.tar.bz2 Media/"
	exit
fi

if ! [[ -e $2 ]]; then
	echo "No MLO found! Quitting..."
	exit
fi
if ! [[ -e $3 ]]; then
	echo "No u-boot.bin found! Quitting..."
	exit
fi
if ! [[ -e $4 ]]; then
	echo "No uImage found! Quitting..."
	exit
fi
if ! [[ -e $5 ]]; then
	echo "No boot.scr found! Quitting..."
	exit
fi
if ! [[ -e $6 ]]; then
	echo "No rootfs.tar.bz2 found! Quitting..."
	exit
fi

echo -n "All data on "$1" now will be destroyed! Continue? [y/n]: "
read ans
if ! [ $ans == 'y' ]; then
	exit
fi

echo "[Unmounting all existing partitions on the device ]"
umount $11 &> /dev/null
umount $12 &> /dev/null
umount $13 &> /dev/null
umount $1p1 &> /dev/null
umount $1p2 &> /dev/null
umount $1p3 &> /dev/null

echo "[Partitioning $1...]"
DRIVE=$1
dd if=/dev/zero of=$DRIVE bs=1024 count=1024 &>/dev/null
SIZE=`fdisk -l $DRIVE | grep Disk | awk '{print $5}'`
echo DISK SIZE - $SIZE bytes
CYLINDERS=`echo $SIZE/255/63/512 | bc`
echo CYLINDERS - $CYLINDERS
{
echo ,9,0x0C,*
echo ,$(expr $CYLINDERS / 2),,-
echo ,,0x0C,-
} | sfdisk -D -H 255 -S 63 -C $CYLINDERS $DRIVE &> /dev/null

echo "[Making boot partition...]"
if [ -b ${1}1 ]; then
    mkfs.vfat -F 32 -n boot "$1"1 &> /dev/null
    mount "$1"1 /mnt
else
    mkfs.vfat -F 32 -n boot "$1"p1 &> /dev/null
    mount "$1"p1 /mnt
fi
cp $2 /mnt/MLO
cp $3 /mnt/u-boot.bin
cp $4 /mnt/uImage
cp $5 /mnt/boot.scr
umount /mnt

echo "[Making rootfs partition...]"
if [ -b ${1}2 ]; then
    mkfs.ext3 -L rootfs "$1"2 &> /dev/null
    mount "$1"2 /mnt
else
    mkfs.ext3 -L rootfs "$1"p2 &> /dev/null
    mount "$1"p2 /mnt
fi
tar jxvf $6 -C /mnt &> /dev/null
umount /mnt

if [ "$7" ]; then
    echo "[Copying all media to data partition]"
    if [ -b ${1}3 ]; then
        mkfs.vfat -F 32 -n data "$1"3 &> /dev/null
        mount "$1"3 /mnt
    else
        mkfs.vfat -F 32 -n data "$1"p3 &> /dev/null
        mount "$1"p3 /mnt
    fi
    cp -r $7/* /mnt
    umount /mnt
fi
echo "[Done]"
