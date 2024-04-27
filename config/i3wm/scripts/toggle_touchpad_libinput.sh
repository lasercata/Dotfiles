#!/bin/bash

#---------------------------------
#
# Last modification : 2023.05.28
# Author            : Lasercata
# Version           : v1.0
#
#---------------------------------

id=$(xinput list | grep -i touchpad | awk -F '\t' '{ print $2 }' | awk -F = '{print $2}')

enabled=$(xinput list-props $id | grep "Device Enabled" | awk '{print $4}')

if [[ $enabled -eq 1 ]]; then
    xinput set-prop $id "Device Enabled" 0;
    notify-send "Touchpad toggling" "Touchpad turned off";

elif [[ $enabled -eq 0 ]]; then
    xinput set-prop $id "Device Enabled" 1;
    notify-send "Touchpad toggling" "Touchpad turned on";

else
    exit 1;

fi
