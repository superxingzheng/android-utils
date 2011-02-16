#!/bin/bash
SERVER="cumulus.gumstix.org/Android/"
SOURCE=$SERVER$1

wget $SOURCE/MLO
wget $SOURCE/u-boot.bin
wget $SOURCE/uImage
wget $SOURCE/boot.scr
wget $SOURCE/rootfs.tar.bz2

cp MLO /media/boot
cp u-boot.bin /media/boot
cp uImage /media/boot
cp boot.scr /media/boot
fakeroot rm -rf /media/rootfs
fakeroot tar xaf rootfs.tar.bz2 -C /media/rootfs/


