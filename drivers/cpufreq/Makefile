# CPUfreq core
obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o cpu-boost.o
# CPUfreq stats
obj-$(CONFIG_CPU_FREQ_STAT)             += cpufreq_stats.o

# CPUfreq limit API
obj-$(CONFIG_CPU_FREQ_LIMIT)             += cpufreq_limit.o

# CPUfreq governors 
obj-$(CONFIG_CPU_FREQ_GOV_PERFORMANCE)	+= cpufreq_performance.o
obj-$(CONFIG_CPU_FREQ_GOV_POWERSAVE)	+= cpufreq_powersave.o
obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+= cpufreq_userspace.o
obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)		+= cpufreq_ondemand.o
obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
obj-$(CONFIG_CPU_FREQ_GOV_INTERACTIVE)	+= cpufreq_interactive.o
obj-$(CONFIG_CPU_FREQ_GOV_SMARTMAX)     += cpufreq_smartmax.o
obj-$(CONFIG_CPU_FREQ_GOV_SMARTMAX_EPS) += cpufreq_smartmax_eps.o
obj-$(CONFIG_CPU_FREQ_GOV_SLIM)			+= cpufreq_slim.o
obj-$(CONFIG_CPU_FREQ_GOV_YANKACTIVE)	+= cpufreq_yankactive.o
obj-$(CONFIG_CPU_FREQ_GOV_IMPULSE)		+= cpufreq_impulse.o
obj-$(CONFIG_CPU_FREQ_GOV_ARTERACTIVE)	+= cpufreq_arteractive.o
obj-$(CONFIG_CPU_FREQ_GOV_ALUCARD)		+= cpufreq_alucard.o
obj-$(CONFIG_CPU_FREQ_GOV_NIGHTMARE)	+= cpufreq_nightmare.o
obj-$(CONFIG_CPU_FREQ_GOV_DARKNESS)		+= cpufreq_darkness.o
# CPUfreq cross-arch helpers
obj-$(CONFIG_CPU_FREQ_TABLE)		+= freq_table.o

##################################################################################
# ARM SoC drivers
obj-$(CONFIG_UX500_SOC_DB8500)		+= db8500-cpufreq.o
obj-$(CONFIG_ARM_S3C2416_CPUFREQ)	+= s3c2416-cpufreq.o
obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
obj-$(CONFIG_ARM_EXYNOS4X12_CPUFREQ)	+= exynos4x12-cpufreq.o
obj-$(CONFIG_ARM_EXYNOS5250_CPUFREQ)	+= exynos5250-cpufreq.o
obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o

##################################################################################
# PowerPC platform drivers
obj-$(CONFIG_CPU_FREQ_MAPLE)		+= maple-cpufreq.o
obj-$(CONFIG_MSM_DCVS)			+= cpufreq_gov_msm.o
