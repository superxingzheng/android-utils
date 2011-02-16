#!/bin/bash

# rather fragile but...
export PATH=${PWD}/prebuilt/linux-x86/toolchain/arm-eabi-4.4.0/bin:$PATH
export ARCH=arm
export CROSS_COMPILE=arm-eabi-
export OUTPUTDIR=${PWD}/out/target/product/overo

# Build u-boot
cd uboot
make distclean
make omap3_overo_config
make -j4
cp u-boot.bin ${OUTPUTDIR}
cd ..

# Build kernel
cd kernel
make mrproper
make overo_android_defconfig
make -j4 uImage
cp arch/arm/boot/uImage ${OUTPUTDIR}
cd ..

# Build MLO
cd mlo
make distclean
make overo_config
make -j4
gcc scripts/signGP.c -o signGP
./signGP x-load.bin 0x40200800
cp x-load.bin.ift ${OUTPUTDIR}/MLO
cd ..

