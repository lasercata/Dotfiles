#!/bin/bash

killall -q polybar

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload parrot &
    done
else
    polybar --reload parrot &
fi

# polybar parrot
