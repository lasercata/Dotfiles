#!/bin/bash

main_mon=$(xrandr --query | grep " primary" | cut -d' ' -f1)

for m in $(xrandr --query | grep " disconnected" | cut -d' ' -f1); do
    xrandr --output $m --off
done

left_mon=$main_mon
for m in $(xrandr --query | grep " connected" | cut -d' ' -f1); do
    if [[ $m != $main_mon ]]; then
        xrandr --output $m --auto --right-of $left_mon
        left_mon=$m
    fi
done
