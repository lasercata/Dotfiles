# vim:foldmethod=marker

#-----------------------------------------------
#
# Author            : Parrot OS, then Lasercata
# Last modification : 2025.04.29
# Version           : v1.2.0
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


#------Path {{{1
export PATH=/usr/local/texlive/2023/bin/x86_64-linux:~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:~/.cargo/bin:$PATH
# }}}1

#------History {{{1
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
# }}}1

#------Other {{{1
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
# }}}1

#------Colors / prompt {{{1
#---colors {{{2
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

    alias diff='diff --color=auto'
    alias d='colordiff'

    alias ip='ip -color=auto'
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
# }}}2

#---Prompt {{{2
# if [ "$color_prompt" = yes ]; then
#     PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n"
#     #\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]
#     #Changed this in order to have a (mostly) nice prompt with mode indicator (vi mode)
#     #See .inputrc
# else
#     PS1='┌──[\u@\h]─[\w]\n'
#     #└──╼ \$ 
# fi

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n"
#     #\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]
#     #Changed this in order to have a (mostly) nice prompt with mode indicator (vi mode)
#     #See .inputrc
#     ;;
# *)
#     ;;
# esac

#---add functions to time commands
# This file is from the repo https://github.com/rcaloras/bash-preexec.
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# convertsecs() {{{3
convertsecs() {
    d=$(bc <<< "${1} / 86400")
    h=$(bc <<< "(${1} % 86400) / 3600")
    m=$(bc <<< "(${1} % 3600) / 60")
    s=$(bc <<< "${1} % 60")
    printf "%dd %02d:%02d:%06.3f\n" "$d" "$h" "$m" "$s" |
        sed 's/^0d //' |
        sed 's/\(00:\)*//' ;
}
# }}}3

# Used https://unix.stackexchange.com/questions/485798/show-time-elapsed-since-i-started-last-command-in-prompt.
first_command=true
# preexec() {{{3
preexec() {
    cmd_start="$SECONDS"
    start=$(date +%s.%N)

    first_command=false
}
# }}}3

# Set the git ps1 variable
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
source /usr/share/git/completion/git-prompt.sh

# precmd {{{3
precmd() {
    [ -n "$COMP_LINE" ] && return  # do nothing if completing

    #---Calculate time elapsed (and compare it to 1s)
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

    #---Set the prompt
    corner_1="┌" #\342\224\214
    dash="─" #"\342\224\200"
    cross="✗" #"\342\234\227"

    red="\[\033[0;31m\]"
    white="\[\033[0;37m\]"
    white_2="\[\033[0;39m\]"
    green="\[\033[0;32m\]"
    yellow="\[\033[01;33m\]"
    blue_bold="\[\033[01;96m\]"
    col="\[\033[0;33m\]"

    link="$red]$dash["

    git_branch="$(git branch --show-current 2> /dev/null)"

    prompt_error="\$([[ \$? != 0 ]] && echo \"${white}${cross}${link}\")"
    id_="${blue_bold}\l"
    time_="${col}\t"
    prompt_user_host="$(if [[ ${EUID} == 0 ]]; then echo "${red}root${yellow}@${blue_bold}\h"; else echo "${white_2}\u${yellow}@${blue_bold}\h"; fi)"
    prompt_path="${green}\w${red}"
    # prompt_git_branch="\$([[ \$git_branch ]] && echo \"${link}${blue_bold}${git_branch}${red}\")"
    prompt_git_branch="\$([[ \$git_branch ]] && echo \"${link}${blue_bold}$(__git_ps1 ' (%s)' | sed 's/^ (//' | sed 's/)$//')${red}\")"

    prompt_color_base="${red}${corner_1}${dash}[${prompt_error}${id_}${link}${time_}${link}${prompt_path}${prompt_git_branch}]\n"

    if $normal_ps; then #In this case, the terminal has just be launched, so no command has been executed, or the command finished rapidly.
        if [ "$color_prompt" = yes ]; then
            PS1=$prompt_color_base
        else
            PS1='┌──[\u@\h]─[\w]\n'
            #└──╼ \$ 
        fi

    else
        if [ "$color_prompt" = yes ]; then
            PS1="\n\033[0;3mLast command took $(convertsecs $elapsed)s.\n$prompt_color_base"
        else
            PS1='Last command took $(convertsecs $elapsed)s.\n┌──[\u@\h]─[\w]\n'
        fi
    fi
}
# }}}3
# }}}2
# }}}1

#------Aliases {{{1
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# }}}1

#------Bindings {{{1
# f is an alias for lf + cd to last dir.
bind '"\C-f":"f\C-m"'
# }}}1

#------Completion {{{1
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
# }}}1

#------Vi mode {{{1
set -o vi
EDITOR=nvim #The editor used for visual mode (when hitting v in normal mode in command line, open the line in an editor)
export EDITOR

# PAGER=bat
# export PAGER

TERMINAL=kitty
export TERMINAL
# }}}1

#------Cap locks {{{1
# Disable the cap locks key
#setxkbmap -option ctrl:nocaps
# To re enable it :
#setxkbmap -option
# Done in system settings.
# }}}1

#------fzf bindings and autocompletion {{{1
if [ -f /usr/share/doc/fzf/examples/key-bindings.bash ]; then
    source /usr/share/doc/fzf/examples/key-bindings.bash
fi

if [ -f /usr/share/doc/fzf/examples/completion.bash ]; then
    source /usr/share/doc/fzf/examples/completion.bash
fi

eval "$(fzf --bash)"
# }}}1

#------GPG {{{1
#To be able to enter the password of my key to sign commits
GPG_TTY=$(tty)
export GPG_TTY
# }}}1

#------Integrate KDE apps in i3 {{{1
export QT_QPA_PLATFORMTHEME="qt5ct"
#
# export QT_STYLE_OVERRIDE="Breeze Dark"
# }}}1

#------Gnome dark mode ? {{{1
export GTK_THEME=Adwaita:dark
# export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
# export QT_STYLE_OVERRIDE=adwaita-dark

# source /home/lasercata/.bash_completions/please.sh

# export NVM_DIR="/home/lasercata/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# }}}1

#------ssh {{{1
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
# }}}1
