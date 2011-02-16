#!/bin/bash
export OUTPUTDIR=${PWD}/out/target/product/overo/

# add busybox
cp busybox ${OUTPUTDIR}/system/bin/
#./busybox --install will overwrite
# edit init.rc to point console service to this shell

# add vim
tar -zxf ${PWD}/utils/vim-android.tar.gz -C ${OUTPUTDIR}
