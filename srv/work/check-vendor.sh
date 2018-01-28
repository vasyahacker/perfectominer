#!/bin/bash

lshw_lines="`lshw -C display | grep vendor: | sort | uniq`"

[[ $lshw_lines == *"NVIDIA"* ]] && vendor="NVIDIA"


[[ $lshw_lines =~ "Advanced Micro Devices" ]] && {
  [[ "$vendor" == "NVIDIA" ]] && vendor="AMD & NVIDIA" || vendor="AMD"
}

echo "$vendor" > /mycfg/vendor
