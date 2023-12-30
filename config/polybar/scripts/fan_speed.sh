#!/bin/bash

#--------------------------------
#
# Last modification : 2023.12.17
# Author            : Lasercata
# Version           : v1.1
#
#--------------------------------

# Inspired from https://github.com/polybar/polybar-scripts/blob/master/polybar-scripts/system-fan-speed/system-fan-speed.sh


speed=$(sensors | grep cpu_fan | awk '{print $2}')

if [ "$speed" != "" ]; then
    echo "$speed/100" | bc -l | LANG=C xargs printf "%.0f\n"
    # echo $speed rpm
else
    echo ""
fi
