MAKEPATH:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.DEFAULT_GOAL:=benchmark

benchmark:
	cd $(MAKEPATH); phoronix-test-suite benchmark build-linux-kernel
.PHONY: benchmark

run:
	cd $(MAKEPATH); phoronix-test-suite run build-linux-kernel
.PHONY: all

monitor-cpu-speed:
	watch cat /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_freq
.PHONY: monitor-cpu-speed

tune:
	@cd $(MAKEPATH); ./scripts/tune.sh
.PHONY: tune

install:
	@cd $(MAKEPATH); ./scripts/install.sh
.PHONY: install
