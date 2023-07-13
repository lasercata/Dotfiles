#!/bin/bash

#--------------------------
#
# Last update : 2023.07.13
# Author      : lasercata
# Version     : v1.2.1
#
#--------------------------

##-Init
CRITICAL=5
DANGER=10
WARN=15
change_time=20

SLEEP_TIME=5 #minutes

##-Function that show notification after checking battery level
function check_power {
    state=$(upower -i $(upower -e | grep 'BAT') | grep 'state' | awk '{print $2}')
    percentage=$(upower -i $(upower -e | grep 'BAT') | grep 'percentage' | awk '{print $2}' | sed s/%//)

    echo "state: $state"
    echo "percentage: $percentage%"

    if [[ "$state" == "discharging" ]]; then
        if (( $percentage <= $CRITICAL )); then
            i3lock -t -c 000000 -i ~/.wallpapers/lasercata_logo_fly_on_parrot_bk_modif_9.png &&
            systemctl suspend #lock screen and fell asleep

            notify-send "Critical battery !" "Current battery level : $percentage%"
            echo "Critical battery ! Current battery level : $percentage%"

            SLEEP_TIME=1;

        elif (( $percentage <= $DANGER )); then #same.
            notify-send "Low battery !" "Current battery level : $percentage%"
            echo "Low battery ! Current battery level : $percentage%"

            SLEEP_TIME=1;

        elif (( $percentage <= $WARN )); then #same.
            notify-send "Low battery" "Current battery level : $percentage%";
            echo "Low battery ! Current battery level : $percentage%"

            SLEEP_TIME=1;

        elif (( $percentage <= $change_time )); then
            SLEEP_TIME=1;

        fi

    else
        SLEEP_TIME=5;
    fi
}

##-Run
#---Init
# notify-send "Battery script" "The battery script has launched."
echo "The battery script has launched."

#---Loop
while [[ true ]]; do
    check_power
    sleep "$SLEEP_TIME"m
done

