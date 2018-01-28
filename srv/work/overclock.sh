#!/bin/bash

vendor="`cat /mycfg/vendor`"
[ "$vendor" == "AMD" ] && /work/amd-overclock.sh
[ "$vendor" == "NVIDIA" ] && /work/nv-overclock.sh
[ "$vendor" == "AMD & NVIDIA" ] && {
	/work/amd-overclock.sh 
	/work/nv-overclock.sh
}

