#!/bin/bash

#---------------------------------
#
# Last modification : 2024.04.29
# Author            : Lasercata
# Version           : v1.0.1
#
#---------------------------------

id=$(xinput list | grep -i touchpad | awk -F '\t' '{ print $2 }' | awk -F = '{print $2}')

enabled=$(xinput list-props $id | grep "Device Enabled" | awk '{print $4}')

if [[ $enabled -eq 1 ]]; then
    xinput set-prop $id "Device Enabled" 0;
    notify-send "Touchpad off" "Touchpad turned off";

elif [[ $enabled -eq 0 ]]; then
    xinput set-prop $id "Device Enabled" 1;
    notify-send "Touchpad on" "Touchpad turned on";

else
    exit 1;

fi
