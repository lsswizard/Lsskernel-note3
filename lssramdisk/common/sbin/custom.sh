#!/system/bin/sh
PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

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

if [ ! -d /data/.lsskernel ]; then
	mkdir /data/.lsskernel
fi

sync

# Allow untrusted apps to read from debugfs (mitigate SELinux denials)
/system/xbin/supolicy --live \
	"allow untrusted_app debugfs file { open read getattr }" \
	"allow untrusted_app sysfs_lowmemorykiller file { open read getattr }" \
	"allow untrusted_app sysfs_devices_system_iosched file { open read getattr }" \
	"allow untrusted_app persist_file dir { open read getattr }" \
	"allow debuggerd gpu_device chr_file { open read getattr }" \
	"allow netd netd capability fsetid" \
	"allow netd { hostapd dnsmasq } process fork" \
	"allow { system_app shell } dalvikcache_data_file file write" \
	"allow { zygote mediaserver bootanim appdomain }  theme_data_file dir { search r_file_perms r_dir_perms }" \
	"allow { zygote mediaserver bootanim appdomain }  theme_data_file file { r_file_perms r_dir_perms }" \
	"allow system_server { rootfs resourcecache_data_file } dir { open read write getattr add_name setattr create remove_name rmdir unlink link }" \
	"allow system_server resourcecache_data_file file { open read write getattr add_name setattr create remove_name unlink link }" \
	"allow system_server dex2oat_exec file rx_file_perms" \
	"allow mediaserver mediaserver_tmpfs file execute" \
	"allow drmserver theme_data_file file r_file_perms" \
	"allow zygote system_file file write" \
	"allow atfwd property_socket sock_file write" \
	"allow untrusted_app sysfs_display file { open read write getattr add_name setattr remove_name }" \
	"allow debuggerd app_data_file dir search"

#Voltage Control
if [ ! -f /data/.lsskernel/volt_prof ]; then
	echo "0" > /data/.lsskernel/volt_prof
fi

# Make internal storage directory for synapse hotplug profile

if [ ! -f /data/.lsskernel/hotplug_prof ]; then
	cp -f /res/synapse/files/hotplug_prof /data/.lsskernel/hotplug_prof
fi
		
# Init.d
busybox run-parts /system/etc/init.d

sync

/sbin/busybox mount -t rootfs -o remount,ro rootfs
/sbin/busybox mount -o remount,rw /data
