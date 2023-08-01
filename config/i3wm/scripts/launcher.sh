#!/bin/bash

#--------------------------
#
# Last update : 2023.08.01
# Author      : lasercata
# Version     : v1.0.1
#
#--------------------------

# This script kill the program given in argument, and relaunch it after.
# This is usefull to have only one instace of the program running after restarting i3 in place.

killall $(basename "$1" | awk '{print $1}')
$1
