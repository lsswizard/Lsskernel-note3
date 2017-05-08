#!/system/bin/sh
# Copyright (c) 2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

#!/system/bin/sh

# selinux fixups
/system/xbin/supolicy --live "allow mediaserver mediaserver_tmpfs file execute"

#
# panel temperature setting
#
echo 0 > /sys/class/lcd/panel/temperature

# panel color control
#
echo 2 > /sys/class/lcd/panel/panel_colors

#
# screen_off_maxfreq
#
echo "1267200" > /sys/devices/system/cpu/cpufreq

#
# scaling_max_freq
#
echo "2265600" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

#
# scaling_min_freq
#
echo "287000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

#
# cpu governor
#
echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
sleep 1
sync

#INTERACTIVE BALANCED BATTRY TWEAKS - Govtunner project code.
 
echo "0" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
echo "0" > /sys/devices/system/cpu/cpufreq/interactive/boost
echo "0" > /sys/devices/system/cpu/cpufreq/interactive/boostpulse
echo "0" > /sys/devices/system/cpu/cpufreq/interactive/boostpulse_duration
echo "300" > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
echo "287000" > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
echo "0" > /sys/devices/system/cpu/cpufreq/interactive/max_freq_hysteresis
echo "0" > /sys/devices/system/cpu/cpufreq/interactive/align_windows
echo "80000" > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
echo "1 287000:32 400000:34 600000:40 700000:44 800000:49 900000:55 1100000:64 1400000:79 1700000:90 1900000:99" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
echo "60000" > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
echo "-1" > /sys/devices/system/cpu/cpufreq/interactive/timer_slack
sleep 1
sync

#
# gpu governor
#
echo "msm-adreno-tz" > /sys/devices/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/governor
echo "Y" > /sys/module/adreno_idler/parameters/adreno_idler_active
echo "0" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
#

# tcp congestion control algorithm
#

echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control

#
# internal memory io scheduler
#
echo "sio" > /sys/block/mmcblk0/queue/scheduler

#
# external memory io scheduler
#

echo "sio" > /sys/block/mmcblk1/queue/scheduler

#
# mmc crc
#

echo "Y" > /sys/module/mmc_core/parameters/use_spi_crc

echo "0" > /sys/module/msm_hotplug/msm_enabled
echo "N" > /sys/module/cpu_boost/parameters/cpuboost_enable


# Ghost's Battery optimizations
#
echo "2" > /sys/kernel/power_suspend/power_suspend_mode
echo "0" > /sys/kernel/fast_charge/force_fast_charge
echo "1" > /sys/kernel/sched/arch_power
echo "66" > /proc/sys/vm/swappiness
echo "1" > /proc/sys/vm/laptop_mode
echo "500" > /proc/sys/vm/dirty_expire_centisecs
echo "1000" > /proc/sys/vm/dirty_writeback_centisecs
sleep 1
sync
#
setprop pm.sleep_mode 1
setprop ro.ril.disable.power.collapse 0
setprop persist.sys.use_dithering 0
setprop wifi.supplicant_scan_interval 180
setprop power_supply.wakeup enable
setprop power.saving.mode 1
setprop ro.config.hw_power_saving 1
setprop persist.radio.add_power_save 1
#
# Kernel panic off
sysctl -w vm.panic_on_oom=0
sysctl -w kernel.panic_on_oops=0
sysctl -w kernel.panic=0
 
#
# Disable logging
setprop logcat.live disable
setprop profiler.force_disable_ulog 1
setprop debugtool.anrhistory 0
setprop profiler.debugmonitor false
setprop profiler.launch false
setprop profiler.hung.dumpdobugreport false
setprop persist.sys.strictmode.disable 1

# Dalvik VM debug monitor
setprop dalvik.vm.debug.alloc 0

# CheckJni disabled
setprop dalvik.vm.checkjni false

# Disabling different types of system logging
setprop logcat.live disable
setprop profiler.force_disable_ulog 1
setprop debugtool.anrhistory 0
setprop profiler.debugmonitor false
setprop profiler.launch false
setprop profiler.hung.dumpdobugreport false
setprop persist.sys.strictmode.disable 1

if [ -e /sys/module/lowmemorykiller/parameters/debug_level ]; then
    chmod 644 /sys/module/lowmemorykiller/parameters/debug_level
    echo "0" > /sys/module/lowmemorykiller/parameters/debug_level
fi

for parameter in /sys/module/*
    do
    if [ -f $parameter/parameters/debug_mask ]; then
        chmod 644 $parameter/parameters/debug_mask
        echo "0" > $parameter/parameters/debug_mask
    fi
done

#
#
# RIL teweaks
#
setprop ro.ril.hsxpa 2
setprop ro.ril.gprsclass 12
setprop ro.ril.hep 1
setprop ro.ril.hsdpa.category 8
setprop ro.ril.hsupa.category 6
setprop ro.ril.enable.sdr 1
setprop ro.ril.enable.gea3 1
setprop ro.ril.enable.a52 0
setprop ro.ril.enable.a53 1
#

# Posible fix
sync
sleep 2
echo "0" > /sys/kernel/dyn_fsync/Dyn_fsync_active
sync

stop thermal-engine
sleep 2
start thermal-engine

stop mpdecision
sleep 2
start mpdecision

# Init.d
mount -o remount,rw /system
if [ ! -d /system/etc/init.d ]; then
    mkdir /system/etc/init.d
fi

chmod 777 /system/etc/init.d/*
busybox run-parts /system/etc/init.d

# Pemissive
setenforce 0

mount -o remount,ro /system
