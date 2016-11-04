#!/system/bin/sh

# Synapse
busybox mount -t rootfs -o remount,rw rootfs
busybox chmod -R 755 /res/synapse
busybox ln -fs /res/synapse/uci /sbin/uci
/sbin/uci
busybox mount -t rootfs -o remount,ro rootfs

# kernel custom test

if [ -e /data/Kerneltest.log ]; then
rm /data/Kerneltest.log
fi

echo  Kernel script is working !!! >> /data/Kerneltest.log
echo "excecuted on $(date +"%d-%m-%Y %r" )" >> /data/Kerneltest.log

# Init.d
busybox run-parts /system/etc/init.d

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,rw /data
