if test ${bootdelay} -ne 1; then
  echo "Setting boot delay to 1"
  setenv bootdelay 1
  saveenv
fi

setenv anddisplay 'vram=12M omapfb.mode=dvi:1024x768MR-16@60 omapdss.def_disp=dvi'
setenv andconsole 'console=ttyO2,115200n8 androidboot.console=ttyO2'
setenv androot 'root=/dev/ram0 rootwait init=/init'
setenv andbootargs 'setenv bootargs mpurate=600 ${andconsole} ${androot} ${anddisplay}'
setenv loadaddr 0x82000000
setenv loadaddr_ramdisk 0x81600000
setenv mmcdev 0
setenv bootcmd 'mmc rescan ${mmcdev}; fatload mmc 0 ${loadaddr} uImage; fatload mmc 0 ${loadaddr_ramdisk} uInitrd; run andbootargs; bootm ${loadaddr} ${loadaddr_ramdisk}'
boot
