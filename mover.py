#!/usr/bin/env python
import datetime
import tempfile
import os
import shutil
import grp

date = datetime.date.today().isoformat() + '-'
dir = tempfile.mkdtemp(prefix=date, dir="/var/www/Android")
os.chmod(dir, 0775)
gid = grp.getgrnam("web").gr_gid
os.chown(dir, -1, gid)

shutil.copy(os.path.join(os.getcwd(), "uImage"), dir)
shutil.copy(os.path.join(os.getcwd(), "MLO"), dir)
shutil.copy(os.path.join(os.getcwd(), "u-boot.bin"), dir)
shutil.copy(os.path.join(os.getcwd(), "boot.scr"), dir)
shutil.copy(os.path.join(os.getcwd(), "rootfs.tar.bz2"), dir)

