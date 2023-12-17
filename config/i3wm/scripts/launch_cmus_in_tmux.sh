#!/bin/bash

#--------------------------
#
# Last update : 2023.12.18
# Author      : lasercata
# Version     : v1.0.0
#
#--------------------------

tmux new -d -s cmus;
status=$?

if test $status -eq 0; then
    tmux send-keys 'cmus' C-m;
    tmux send-keys 3;
fi

tmux attach -t cmus;
