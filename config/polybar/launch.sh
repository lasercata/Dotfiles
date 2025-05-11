#!/bin/bash

# Launch a bar for every connected screen.
# It puts the main_bar on the main screen, and the second_bar on all the other connected screens.

killall -q polybar

main_mon=$(xrandr --query | grep " primary" | cut -d' ' -f1)

if type "xrandr"; then
    /bin/bash ~/.config/polybar/scripts/hot_pluggable_screens.sh;

    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        if [[ $m == $main_mon ]]; then
            MONITOR=$m polybar --reload main_bar &
        else
            MONITOR=$m polybar --reload second_bar &
        fi
    done

else
    polybar --reload main_bar &
fi

