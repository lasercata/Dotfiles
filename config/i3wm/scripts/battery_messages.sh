#!/bin/bash

#--------------------------
#
# Last update : 2023.07.24
# Author      : lasercata
# Version     : v1.3.1
#
#--------------------------

##-Init
CRITICAL=5
DANGER=10
WARN=30
change_time=35

SLEEP_TIME=5 #minutes

SOUND="/usr/share/sounds/Oxygen-Sys-App-Message.ogg"


##-Function that show notification after checking battery level
function check_power {
    state=$(upower -i $(upower -e | grep 'BAT') | grep 'state' | awk '{print $2}')
    percentage=$(upower -i $(upower -e | grep 'BAT') | grep 'percentage' | awk '{print $2}' | sed s/%//)

    echo "state: $state"
    echo "percentage: $percentage%"

    if [[ "$state" == "discharging" ]]; then
        if (( $percentage <= $change_time )); then
            SLEEP_TIME=1;
        fi

        if (( $percentage <= $CRITICAL )); then
            notify-send "Critical battery !" "Current battery level : $percentage%\nThe computer will fall asleep." &
            play $SOUND
            echo "Critical battery ! Current battery level : $percentage%"

            sleep 1

            i3lock -t -c 000000 -i ~/.wallpapers/lasercata_logo_fly_on_parrot_bk_modif_9.png &&
            systemctl suspend #lock screen and fell asleep

        elif (( $percentage <= $DANGER )); then
            notify-send "Low battery !" "Current battery level : $percentage%" &
            play $SOUND
            echo "Low battery ! Current battery level : $percentage%"

        elif (( $percentage <= $WARN )); then
            notify-send "Low battery" "Current battery level : $percentage%" &
            play $SOUND
            echo "Low battery ! Current battery level : $percentage%"

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

