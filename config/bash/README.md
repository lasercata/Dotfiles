# Bash config

## bashrc
This is the main configuration file. It should be located in the home directory, at `~/.bashrc`.
This file uses the file `.bash-preexec.sh` from [https://github.com/rcaloras/bash-preexec](https://github.com/rcaloras/bash-preexec) in order to show the time elapsed for a command execution.

## bash_aliases
This file contain the definition of some handy aliases. It is sourced by `.bashrc`.
It should be located in the home directory, at `~/.bash_aliases`.

## inputrc
This file is used to configure the vim mode for the terminal (it changes the cursor shape accordingly to the vim mode, as well as the indicator in front of the line, and adds some motion like `i(`, ...).

It should be located at `~/.inputrc`.
