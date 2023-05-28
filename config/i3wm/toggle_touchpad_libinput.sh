#!/bin/bash

#---------------------------------
#
# Last modification : 2023.05.28
# Author            : Lasercata
# Version           : v1.0
#
#---------------------------------

id=$(xinput list | grep -i touchpad | awk '{ print $5 }' | awk -F = '{print $2}')

enabled=$(xinput list-props $id | grep "Device Enabled" | awk '{print $4}')

if [ $enabled = 1 ]; then
    xinput set-prop $id "Device Enabled" 0;

elif [ $enabled = 0 ]; then
    xinput set-prop $id "Device Enabled" 1;

else
    exit 1;

fi
