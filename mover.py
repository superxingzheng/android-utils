#!/usr/bin/env python
import datetime
import tempfile
import os
import shutil
import grp

date = datetime.date.today().isoformat() + '-'
dest_dir = tempfile.mkdtemp(prefix=date, dir="/var/www/Android")
os.chmod(dest_dir, 0775)
gid = grp.getgrnam("web").gr_gid
os.chown(dest_dir, -1, gid)

src_dir = os.path.join(os.getcwd(), "out/target/product/overo")
shutil.copy(os.path.join(src_dir, "uImage"), dest_dir)
shutil.copy(os.path.join(src_dir, "MLO"), dest_dir)
shutil.copy(os.path.join(src_dir, "u-boot.bin"), dest_dir)
shutil.copy(os.path.join(src_dir, "boot.scr"), dest_dir)
shutil.copy(os.path.join(src_dir, "rootfs.tar.bz2"), dest_dir)

