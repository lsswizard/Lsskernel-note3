#!/sbin/sh

rm -f /system/etc/init.d/*realpac*
if [ -d /data/data/com.kerneladiutor.mod ];
    then
        rm -rf /data/data/com.kerneladiutor.mod
fi

chmod 755 /system/bin/lpm
