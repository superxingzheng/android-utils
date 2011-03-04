#!/bin/bash
SERVER="http://cumulus.gumstix.org/images/android"
SOURCE="${SERVER}/current"

# We need curl.  Use curl as it allows for restarting downloads.
command -v curl > /dev/null
if [[ ! ($?) ]]; then
   echo "'curl' utility not found. On Ubuntu, install with"
   echo "    sudo apt-get install curl"
fi

# If no argument given, grab latest build.
if [[ -z $1 ]]; then
    echo "[ Downloading latest images from ${SERVER} ]"
else
    SOURCE=${SERVER}/$1
    echo "[ Downloading images from ${SOURCE} ]"
fi

curl -O -# -C - ${SOURCE}/MLO
curl -O -# -C - ${SOURCE}/u-boot.bin
curl -O -# -C - ${SOURCE}/uImage
curl -O -# -C - ${SOURCE}/boot.scr
curl -O -# -C - ${SOURCE}/rootfs.tar.bz2
curl -O -# -C - ${SOURCE}/md5sums.txt

echo "[ Verifying downloads ]"
md5sum -c md5sums.txt
