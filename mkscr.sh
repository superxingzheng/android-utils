#!/bin/sh
mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "Android Boot" -d androidboot.cmd boot.scr
