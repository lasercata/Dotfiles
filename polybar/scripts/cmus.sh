#!/bin/bash

#--------------------------------------------------------------------------------
#
# Last modification : 2023.05.09
# Author            : https://github.com/raytruong/polybar-cmus/, then Lasercata
# Version           : v1.2
#
#--------------------------------------------------------------------------------

prepend_zero () {
        seq -f "%02g" $1 $1
}

artist=$(echo -n $(cmus-remote -C status | grep "tag artist" | cut -c 12-))
song=$(echo -n $(cmus-remote -C status | grep title | cut -c 11-))
fn=$(basename "$(cmus-remote -Q | grep file)" .mp3)

if [[ $artist = *[!\ ]* ]] && [[ $song = *[!\ ]* ]]; then
    position=$(cmus-remote -C status | grep position | cut -c 10-)
    minutes1=$(prepend_zero $(($position / 60)))
    seconds1=$(prepend_zero $(($position % 60)))
    duration=$(cmus-remote -C status | grep duration | cut -c 10-)
    minutes2=$(prepend_zero $(($duration / 60)))
    seconds2=$(prepend_zero $(($duration % 60)))
    echo -n "$artist - $song [$minutes1:$seconds1/$minutes2:$seconds2]"

elif [[ $fn = *[!\ ]* ]]; then
    position=$(cmus-remote -C status | grep position | cut -c 10-)
    minutes1=$(prepend_zero $(($position / 60)))
    seconds1=$(prepend_zero $(($position % 60)))
    duration=$(cmus-remote -C status | grep duration | cut -c 10-)
    minutes2=$(prepend_zero $(($duration / 60)))
    seconds2=$(prepend_zero $(($duration % 60)))
    echo -n "[$minutes1:$seconds1/$minutes2:$seconds2] $fn"

else
    echo
fi
