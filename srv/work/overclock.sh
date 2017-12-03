#!/bin/bash

vendor="`cat /mycfg/vendor`"
[ "$vendor" == "AMD" ] && /work/amd-overclock.sh || /work/nv-overclock.sh

