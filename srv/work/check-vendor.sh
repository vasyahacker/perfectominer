#!/bin/bash

vendor="`lshw -C display | grep vendor: | sort | uniq`"

if [[ $vendor == *"NVIDIA"* ]]; then
  vendor="NVIDIA"
elif [[ $vendor == *"Advanced Micro Devices"* ]]; then
  vendor="AMD"
fi

echo "$vendor" > /mycfg/vendor
