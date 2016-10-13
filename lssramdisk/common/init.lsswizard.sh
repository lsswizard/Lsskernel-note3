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
# cpu governor
#
echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

#
# gpu governor
#
echo "msm-adreno-tz" > /sys/devices/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/governor
echo Y > /sys/module/adreno_idler/parameters/adreno_idler_active
echo 1 > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
#

# tcp congestion control algorithm
#

echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control

#
# internal memory io scheduler
#
echo "cfq" > /sys/block/mmcblk0/queue/scheduler

#
# external memory io scheduler
#

echo "cfq" > /sys/block/mmcblk1/queue/scheduler

#
# mmc crc
#

echo "Y" > /sys/module/mmc_core/parameters/use_spi_crc

echo > "0" /sys/module/msm_hotplug/msm_enabled
echo N > /sys/module/cpu_boost/parameters/cpuboost_enable

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
