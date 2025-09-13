#!/usr/bin/env bash

#--------------------------------
#
# Last modification : 2025.09.13
# Author            : Lasercata
# Version           : v1.0.0
#
#--------------------------------

# This script is used to display the file "$1" in full screen (like the previewer, but instead of being on the side, it is in full screen).
# This script is called by the binding 'i' in lf.
#
# Usage:
#   ./visualizer.sh "$f"
# 
# Where "$f" is the file to display.

##-Init
FILE_PATH="${1}" # Full path of the highlighted file

MIME_TYPE="$(file --dereference --brief --mime-type -- "${FILE_PATH}")"

##-Functions
dir_display() {
    ls -lah --color --group-directories-first $1
}

##-Display
case "${MIME_TYPE}" in
    # For image, just use the previewer
    image/* | video/* | font/* | application/pdf) ~/.config/lf/previewer.sh "$FILE_PATH" ;;

    # For folders, just use `ls`
    inode/directory) dir_display "$FILE_PATH" | bat --paging=always --file-name "$FILE_PATH" --color never ;;

    # For anything else, pipe the previewer into bat
    *) ~/.config/lf/previewer.sh "$FILE_PATH" | bat --paging=always --file-name "$FILE_PATH" --color never ;;

    # The --file-name is used to display the file name in the header.
    # The --color never is used to prevent bat to try to add color, as it is already passed through bat once (with the previewer.sh).
esac

