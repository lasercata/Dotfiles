#!/bin/bash

#--------------------------
#
# Last update : 2023.07.12
# Author      : lasercata
<<<<<<< Updated upstream
# Version     : v1.1
=======
# Version     : v1.2.0
>>>>>>> Stashed changes
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

<<<<<<< Updated upstream
    echo "critical: $CRITICAL%"

    # if (( $percent<=$CRITICAL )); then
    #     echo crit;
    # else
    #     echo norm;
    # fi

    if [[ "$state" == "discharging" ]]; then
        if (( $percent<=$CRITICAL )); then
            # i3lock -t -c 000000 -i ~/.wallpapers/lasercata_logo_fly_on_parrot_bk_modif_9.png &&
            # systemctl suspend #lock screen and fell asleep
            notify-send "Critical battery !" "Current battery level : $percent%"
            SLEEP_TIME=1;

        elif (( $percent<=$DANGER )); then #same.
            notify-send "Low battery !" "Current battery level : $percent%"
            SLEEP_TIME=1;

        elif (( $percent<=$WARN )); then #same.
            notify-send "Low battery" "Current battery level : $percent%";
            SLEEP_TIME=1;

        elif (( $percent<=$change_time )); then
=======
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
>>>>>>> Stashed changes
            SLEEP_TIME=1;

        fi

    else
        SLEEP_TIME=5;
    fi
}

##-Main loop
while [[ true ]]; do
    check_power
    sleep "$SLEEP_TIME"m
done

