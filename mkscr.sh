#!/bin/sh
SOURCE=${PWD}/utils/androidboot.cmd
DEST=${PWD}/out/target/product/overo/boot.scr
mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "Android Boot" -d ${SOURCE} $DEST
