#!/usr/bin/env bash

# Scans the package at current working directory using `aur-scan`.
# Asks the user in case of issue found.
#
# Add this to paru.conf:
# ```
# [bin]
# PreBuildCommand = ~/.config/paru/scan_package.sh
# ```

echo
echo "Scanning package..."

/usr/bin/aur-scan scan --fail-on high . || (
    read -p "Issue(s) found. Please review. Continue with installation (y/N)? " answer

    if [ "$answer" = "y" ]; then
        exit 0
    else
        exit 1
    fi
)


