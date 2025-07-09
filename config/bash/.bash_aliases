#--------------------------------
#
# Author            : Lasercata
# Last modification : 2025.07.09
# Version           : v1.3.0
#
#--------------------------------

#---Linux
alias _='sudo'
alias _i='sudo -i'

alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'

alias dd='dd status=progress'

#---Python
alias p3='python3'
alias p='python'

#---Programs
alias viqt='nvim-qt'

#When quitting ranger, the terminal will cd to the last location.
alias rg='. ranger'
alias f='cd "$(lf -print-last-dir)"'

alias v='nvim'

#alias bat='batcat'
alias fd="fzf --preview 'bat--color=always --style=numbers --line-range=:500 {}'"

#---Git
# status
alias gits="git status"
alias gitss="git status -s"

# diff
alias gitd="git diff --word-diff"
alias gitdd="git diff"
alias gitds="git diff --word-diff --staged"
alias gitdds="git diff --staged"

# commit
alias gitc="git commit -m"

# list files
alias gitls='(echo "current branch: $(git branch --show-current)"; git ls-files | tree -a -C --fromfile) | bat'
# alias gitls="tree -C --gitignore | bat"

# log
alias gitl="git log --graph --all --decorate --format=format:'%C(yellow)%h%C(reset)%C(auto)%d%C(reset) - %C(cyan)%an%C(reset) %C(magenta)(%ar)%C(reset) %C(white)%s%C(reset)'"

# log (for current branch only)
alias gitlb="git log --graph --decorate --format=format:'%C(yellow)%h%C(reset)%C(auto)%d%C(reset) - %C(cyan)%an%C(reset) %C(magenta)(%ar)%C(reset) %C(white)%s%C(reset)'"

#---Exit
alias q="exit"
alias qq="exit"
alias qqq="exit"
alias :q="exit"
alias :qa="exit"
