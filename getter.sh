#!/bin/bash
SERVER="cumulus.gumstix.org/Android/"
SOURCE=$SERVER$1

if [[ -z $1 ]];then
    echo "Usage: $0 <build name>"
fi

wget $SOURCE/MLO
wget $SOURCE/u-boot.bin
wget $SOURCE/uImage
wget $SOURCE/boot.scr
wget $SOURCE/rootfs.tar.bz2
