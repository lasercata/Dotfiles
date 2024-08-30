#!/bin/bash

#---Get the main monitor. It will be the central monitor.
main_mon=$(xrandr --query | grep " primary" | cut -d' ' -f1)

#---Turn off the disconnected monitors
for m in $(xrandr --query | grep " disconnected" | cut -d' ' -f1); do
    xrandr --output $m --off
done

#---Placing the connected monitors.
# The main is at the centre, and then each monitor is added alternatively to the right or the left.
# E.g for monitors 1 2 3 4 5, with 1 the main, the placement will be 5 3 1 2 4.
left_mon=$main_mon
right_mon=$main_mon
i=0

for m in $(xrandr --query | grep " connected" | cut -d' ' -f1); do
    if [[ $m != $main_mon ]]; then # Ignore the main monitor
        if [ $((i % 2)) -eq 0 ]; then # Add to right
            xrandr --output $m --auto --right-of $right_mon
            right_mon=$m
        else # Add to left
            xrandr --output $m --auto --left-of $left_mon
            left_mon=$m
        fi

        ((i++))
    fi
done
