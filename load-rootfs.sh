#!/bin/bash

#MNTROOTFS=/media/rootfs
TARDIR=${PWD}/out/target/product/overo/

#echo "Clean old rootfs on SD"
#sudo rm -rf ${MNTROOTFS}/*
cd ${TARDIR}
echo "remove dir"
rm -rf android_rootfs
echo "make dir"
mkdir android_rootfs
echo "move root"
cp -r root/* android_rootfs
echo "move system"
cp -r system android_rootfs
cd ${TARDIR}
echo "make tarball"
../../../../build/tools/mktarball.sh ../../../host/linux-x86/bin/fs_get_stats android_rootfs . rootfs rootfs.tar.bz2
#echo "untar"
#sudo tar xaf rootfs.tar.bz2 --numeric-owner -C ${MNTROOTFS}
#echo "sync"
#sync
#sync
cd ${PWD}
echo "DONE!"
