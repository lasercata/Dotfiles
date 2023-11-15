#!/bin/bash

main_mon=$(xrandr --query | grep " primary" | cut -d' ' -f1)

for m in $(xrandr --query | grep " disconnected" | cut -d' ' -f1); do
    xrandr --output $m --off
done

for m in $(xrandr --query | grep " connected" | cut -d' ' -f1); do
    if [[ $m != $main_mon ]]; then
        xrandr --output $m --auto --right-of $main_mon #Only works for 2 monitors.
    fi
done
