#!/bin/bash

#---------------------------------
#
# Last modification : 2025.01.04
# Author            : lasercata
# Version           : v1.0.0
#
#---------------------------------

# Run xinput list --short to see keyboard list

KEYBOARD_LIST=$(
    xinput list --short |
        grep -v "Consumer" |
        grep -v "Control" |
        grep -v "Bus" |
        grep -v "Virtual" |
        grep -v "Button" |
        grep -v "hotkeys" |
        grep -v "Intel HID events" |
        grep -v "Clevo" |
        grep "keyboard"
)

# echo $KEYBOARD_LIST

if [[ -z $(echo "$KEYBOARD_LIST" | grep "ZSA") ]]; then
    # If the moonlander is not connected, then change the layout.

    setxkbmap -I ~/.config/xkb fc
fi
