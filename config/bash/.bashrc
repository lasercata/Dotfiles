#-----------------------------------------------
#
# Author            : Parrot OS, then Lasercata
# Last modification : 2023.12.23
# Version           : v1.7.5
#
#-----------------------------------------------

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


#------Path
export PATH=/usr/local/texlive/2023/bin/x86_64-linux:~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:$PATH


#------History
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Add date and timestamps to bash history
export HISTTIMEFORMAT='%F, %T | '

#Save command in the history right after execution (and not after end of session)
PROMPT_COMMAND='history -a'

#Ignore some commands
export HISTIGNORE="history:ls:ll"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTFILESIZE=20000
export HISTSIZE=10000


#------Other
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


#------Colors / prompt
#---colors
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n"
    #\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]
    #Changed this in order to have a (mostly) nice prompt with mode indicator (vi mode)
    #See .inputrc
else
    PS1='┌──[\u@\h]─[\w]\n'
    #└──╼ \$ 
fi

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
	man() {
	env \
	LESS_TERMCAP_mb=$'\e[01;31m' \
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	man "$@"
	}
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n"
    #\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]
    #Changed this in order to have a (mostly) nice prompt with mode indicator (vi mode)
    #See .inputrc
    ;;
*)
    ;;
esac

#---add functions to time commands
#This file is from the repo https://github.com/rcaloras/bash-preexec.
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

convertsecs() {
    h=$(bc <<< "${1}/3600")
    m=$(bc <<< "(${1}%3600)/60")
    s=$(bc <<< "${1}%60")
    printf "%02d:%02d:%06.3f\n" "$h" "$m" "$s" |
    sed 's/\(00:\)*//' ;
}

#Used https://unix.stackexchange.com/questions/485798/show-time-elapsed-since-i-started-last-command-in-prompt.
first_command=true
preexec() {
    cmd_start="$SECONDS"
    start=$(date +%s.%N)

    first_command=false
}

precmd() {
    [ -n "$COMP_LINE" ] && return  # do nothing if completing

    if $first_command; then
        normal_ps=true
    else
        local cmd_end="$SECONDS"
        elapsed_=$((cmd_end-cmd_start))
        elapsed=$(echo "$(date +%s.%N) - $start" | bc)

        if (($elapsed_ < 1)); then
            normal_ps=true
        else
            normal_ps=false
        fi
    fi

    if $normal_ps; then #In this case, the terminal has just be launched, so no command has been executed, or the command finished rapidly.
        if [ "$color_prompt" = yes ]; then
            PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n"
            #\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]
            #Changed this in order to have a (mostly) nice prompt with mode indicator (vi mode)
            #See .inputrc
        else
            PS1='┌──[\u@\h]─[\w]\n'
            #└──╼ \$ 
        fi

    else
        if [ "$color_prompt" = yes ]; then
            PS1="\n\033[0;3mLast command took $(convertsecs $elapsed)s.\n\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n"
            # PS1="\n\033[0;3mLast command took $(printf "%.3f" $elapsed)s.\n\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n"
        else
            PS1='Last command took $(convertsecs $elapsed)s.\n┌──[\u@\h]─[\w]\n'
        fi
    fi
}

# unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    alias ip='ip -color=auto'
fi


#------Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


#------Bindings
# f is an alias for lf + cd to last dir.
bind '"\C-f":"f\C-m"'


#------Completion
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


#------Vi mode
set -o vi
EDITOR=nvim #The editor used for visual mode (when hitting v in normal mode in command line, open the line in an editor)
export EDITOR

PAGER=bat
export PAGER

TERMINAL=kitty
export TERMINAL


#------Cap locks
# Disable the cap locks key
#setxkbmap -option ctrl:nocaps
# To re enable it :
#setxkbmap -option
# Done in system settings.

#------fzf bindings and autocompletion
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi

if [ -f /usr/share/doc/fzf/examples/completion.bash ]; then
    source /usr/share/doc/fzf/examples/completion.bash
fi

#------GPG
#To be able to enter the password of my key to sign commits
GPG_TTY=$(tty)
export GPG_TTY

#------Integrate KDE apps in i3
export QT_QPA_PLATFORMTHEME="qt5ct"
#
# export QT_STYLE_OVERRIDE="Breeze Dark"

#------Gnome dark mode ?
export GTK_THEME=Adwaita:dark
# export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
# export QT_STYLE_OVERRIDE=adwaita-dark

# source /home/lasercata/.bash_completions/please.sh

# export NVM_DIR="/home/lasercata/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
