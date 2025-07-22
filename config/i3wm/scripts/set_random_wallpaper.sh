#!/usr/bin/env bash

# This script randomly selects a wallpaper from `~/.wallpapers/favourites` and displays it.

#---Select the file
# wallpaper_fn=$(ls ~/.wallpapers/favourites/ | sort -R | head -n 1)
wallpaper_fn=$(ls ~/.wallpapers/favourites/ | shuf -n 1)

#---Display it
feh --bg-scale ~/.wallpapers/favourites/"$wallpaper_fn"
