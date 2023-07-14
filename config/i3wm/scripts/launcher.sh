#!/bin/bash

#--------------------------
#
# Last update : 2023.07.14
# Author      : lasercata
# Version     : v1.0.0
#
#--------------------------

# This script kill the program given in argument, and relaunch it after.

killall $(basename "$1")
$1
