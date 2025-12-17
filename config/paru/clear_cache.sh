#!/usr/bin/env bash

# === Paru cache ===
cd ~/.cache/paru/clone

echo "Paru cache cleaning"

# Create the argument with folders: add a '-c [dir]' for each clone dir
cache_dirs=$(
    for dir in *; do 
        echo "-c $dir"
    done
)

# Dryrun
paccache -dv -k3 $cache_dirs

# Ask confirmation
read -p "Are you sure you want to proceed? (y/n) " confirm
if [[ $confirm == [yY] ]]; then
    echo "Proceeding..."
    paccache -r -k 3 $cache_dirs
else
    echo "Action cancelled."
fi

cd -

# === Pacman cache ===
echo
echo "Pacman cache cleaning"

paccache -dv -k3

# Ask confirmation
read -p "Are you sure you want to proceed? (y/n) " confirm
if [[ $confirm == [yY] ]]; then
    echo "Proceeding..."
    paccache -r -k 3
else
    echo "Action cancelled."
fi
