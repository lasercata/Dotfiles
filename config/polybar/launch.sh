#!/bin/bash

killall -q polybar

if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        if [[ $m == "eDP-1" ]]; then
            MONITOR=$m polybar --reload main_bar &
        else
            MONITOR=$m polybar --reload second_bar &
        fi
    done

else
    polybar --reload main_bar &
fi

# polybar parrot
