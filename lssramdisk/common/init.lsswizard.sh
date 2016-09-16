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

# Settings Min - Max CPU frequency 
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 288000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo 288000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo 288000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
echo 288000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
chmod 644 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 2265600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo 2265600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 2265600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
chmod 644 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
echo 2265600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
chmod 444 /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq

#Adreno Idler 
echo Y > /sys/module/adreno_idler/parameters/adreno_idler_active

#Simple GPU Algorithm 
echo 1 > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate

#Power 
echo 3 > /sys/kernel/power_suspend/power_suspend_mode

LS=0 
while [ $LS -lt 3 ]; do
	echo 1 > /sys/module/msm_pm/modes/cpu$CT/power_collapse/suspend_enabled
	echo 1 > /sys/module/msm_pm/modes/cpu$CT/power_collapse/idle_enabled
	echo 1 > /sys/module/msm_pm/modes/cpu$CT/standalone_power_collapse/suspend_enabled
	echo 1 > /sys/module/msm_pm/modes/cpu$CT/standalone_power_collapse/idle_enabled
	echo 1 > /sys/module/msm_pm/modes/cpu$CT/retention/idle_enabled
	echo 1 > /sys/devices/system/cpu/cpu$CT/online
	((LS++))
done

# Hotplug
echo > "1" /sys/kernel/msm_mpdecision/conf/enabled
stop mpdecision
echo > "0" /sys/module/msm_hotplug/msm_enabled
echo N > /sys/module/cpu_boost/parameters/cpuboost_enable

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
