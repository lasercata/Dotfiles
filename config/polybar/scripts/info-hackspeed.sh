#!/bin/bash
# shellcheck disable=SC2016,SC2059

#---------------------------------
#
# Last modification : 2024.05.21
# Author            : https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/info-hackspeed, then lasercata
# Version           : v2.1.1
#
#---------------------------------

# Run xinput list --short to see keyboard list
# KEYBOARD_ID="AT Translated Set 2 keyboard"
# KEYBOARD_ID="SONiX DIERYA DK61"
# KEYBOARD_ID="ZSA Technology Labs Moonlander Mark I Keyboard"
# KEYBOARD_ID=14
#
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

# echo "$KEYBOARD_LIST"
# echo "$KEYBOARD_LIST" | grep -v "AT Translated" | grep -v "ZSA"

# If there is at least an other keyboard than the laptop one or the ZSA, choose the first one.
if [[ -n $(echo "$KEYBOARD_LIST" | grep -v "AT Translated" | grep -v "ZSA") ]]; then
    KEYBOARD_ID=$(
        echo "$KEYBOARD_LIST" |
            grep -v "AT Translated" |
            grep -v "ZSA" |
            awk -F '\t' '{print $2}' |
            awk -F = '{print $2}' |
            head -n 1
    )
elif [[ -n $(echo "$KEYBOARD_LIST" | grep "ZSA") ]]; then
    KEYBOARD_ID=$(
        echo "$KEYBOARD_LIST" |
            grep "ZSA" |
            awk -F '\t' '{print $2}' |
            awk -F = '{print $2}' |
            head -n 1
    )
else
    KEYBOARD_ID="AT Translated Set 2 keyboard"
fi

# echo $KEYBOARD_ID

# if [[ -n $(xinput list --short | grep ZSA) ]]; then
#     KEYBOARD_ID=$(
#         xinput list --short |
#             grep ZSA |
#             grep -v "Consumer" |
#             grep -v "System Control" |
#             grep -v "pointer" |
#             grep -v "Keyboard" |
#             awk '{print $8}' |
#             awk -F = '{print $2}'
#     )
# else
#     KEYBOARD_ID="AT Translated Set 2 keyboard"
# fi

# echo "KEYBOARD_ID" "$KEYBOARD_ID"

# cpm: characters per minute
# wpm: words per minute (1 word = 5 characters)
METRIC=wpm
FORMAT="%d $METRIC"

INTERVAL=5

# If you have a keyboard layout that is not listed here yet, create a condition
# yourself. $3 is the key index. Use `xinput test "AT Translated Set 2 keyboard"`
# to see key codes in real time.  Be sure to open a pull request for your
# layout's condition!
# LAYOUT=qwerty
LAYOUT=azerty

case "$LAYOUT" in
	qwerty) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 24 && $3 <= 33) || ($3 >= 37 && $3 <= 53) || ($3 >= 52 && $3 <= 58)'; ;;
	azerty) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 24 && $3 <= 33) || ($3 >= 37 && $3 <= 54) || ($3 >= 52 && $3 <= 57)'; ;;
	qwertz) CONDITION='($3 >= 10 && $3 <= 20) || ($3 >= 24 && $3 <= 34) || ($3 == 36) || ($3 >= 38 && $3 <= 48) || ($3 >= 52 && $3 <= 58)'; ;;
    dvorak) CONDITION='($3 >= 10 && $3 <= 19) || ($3 >= 27 && $3 <= 33) || ($3 >= 38 && $3 <= 47) || ($3 >= 53 && $3 <= 61)'; ;;
    dontcare) CONDITION='1'; ;; # Just register all key presses, not only letters and numbers
	*) echo "Unsupported layout \"$LAYOUT\""; exit 1; ;;
esac

# We have to account for the fact we're not listening a whole minute
multiply_by=60
divide_by=$INTERVAL

case "$METRIC" in
	wpm) divide_by=$((divide_by * 5)); ;;
	cpm) ;;
	*) echo "Unsupported metric \"$METRIC\""; exit 1; ;;
esac

hackspeed_cache="$(mktemp -p '' hackspeed_cache.XXXXX)"
trap 'rm "$hackspeed_cache"' EXIT

# Write a dot to our cache for each key press
printf '' > "$hackspeed_cache"
xinput test "$KEYBOARD_ID" | \
	stdbuf -o0 awk '$1 == "key" && $2 == "press" && ('"$CONDITION"') {printf "."}' >> "$hackspeed_cache" &

while true; do
	# Ask the kernel how big the file is with the command `stat`. The number we
	# get is the file size in bytes, which equals the amount of dots the file
	# contains, and hence how much keys were pressed since the file was last
	# cleared.
	lines=$(stat --format %s "$hackspeed_cache")

	# Truncate the cache file so that in the next iteration, we count only new
	# keypresses
	printf '' > "$hackspeed_cache"

	# The shell only does integer operations, so make sure to first multiply and
	# then divide
	value=$((lines * multiply_by / divide_by))

	printf "$FORMAT\\n" "$value"

	sleep $INTERVAL
done
