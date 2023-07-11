#!/bin/bash

#--------------------------
#
# Last update : 2023.07.11
# Author      : lasercata
# Version     : v1.0
#
#--------------------------

CRITICAL=5
DANGER=10
WARN=15

SLEEP_TIME=5 #minutes


function check_power {
    state=$(upower -i $(upower -e | grep 'BAT') | grep 'state' | awk '{print $2}')
    percentage=$(upower -i $(upower -e | grep 'BAT') | grep 'percentage' | awk '{print $2}' | sed s/%//)

    echo "state: $state"
    echo "percentage: $percentage%"

    echo "critical: $CRITICAL"

    # if (( $percent <= $CRITICAL )); then
    #     echo crit;
    # else
    #     echo norm;
    # fi

    if [[ "$state" == "discharging" ]]; then
        if (( $percent <= $CRITICAL )); then #This condition does not work as expected.
            # i3lock -t -c 000000 -i ~/.wallpapers/lasercata_logo_fly_on_parrot_bk_modif_9.png &&
            # systemctl suspend #lock screen and fell asleep
            notify-send "Critical battery !" "Current battery level : $percent%"
            SLEEP_TIME=1;
            # echo "Critical !!!";

        elif (( $percent <= $DANGER )); then #same.
            notify-send "Low battery !" "Current battery level : $percent%"
            SLEEP_TIME=1;

        elif (( $percent <= $WARN )); then #same.
            notify-send "Low battery" "Current battery level : $percent%";

        fi
    else
        SLEEP_TIME=5;
    fi
}

while [[ true ]]; do
    check_power
    sleep "$SLEEP_TIME"m
done

#TODO: test this script ...
