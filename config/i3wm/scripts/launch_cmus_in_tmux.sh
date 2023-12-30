#!/bin/bash

#--------------------------
#
# Last update : 2023.12.18
# Author      : lasercata
# Version     : v1.0.0
#
#--------------------------

# This script launch cmus in a new tmux session named "cmus" if it was not
# created, and attach to it otherwise.

tmux new -d -s cmus;
status=$?

if test $status -eq 0; then
    tmux send-keys 'cmus' C-m;
    tmux send-keys 3;
fi

tmux attach -t cmus;
