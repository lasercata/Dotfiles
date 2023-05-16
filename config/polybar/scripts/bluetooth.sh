#!/bin/sh

# From https://github.com/msaitz/polybar-bluetooth

if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo "%{F#66ffffff}󰂲" #off
else
  if [ $(echo info | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then 
      echo "%{F#f6668a}%{u#f6668a}%{+u}" #active but not connected (red-3)
  fi
  echo "%{F#2193ff}%{u#2193ff}%{+u}" #connected
fi

