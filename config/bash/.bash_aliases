#--------------------------------
#
# Author            : Lasercata
# Last modification : 2024.02.24
# Version           : v1.2.8
#
#--------------------------------

alias _='sudo'
alias _i='sudo -i'

alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'

alias dd='dd status=progress'

alias p3='python3'
alias p='python'

alias viqt='nvim-qt'

#When quitting ranger, the terminal will cd to the last location.
alias rg='. ranger'
alias f='cd "$(lf -print-last-dir)"'

alias v='nvim'

#alias bat='batcat'
alias fd="fzf --preview 'bat--color=always --style=numbers --line-range=:500 {}'"

alias gits="git status"
alias gitss="git status -s"
alias gitd="git diff --word-diff"
alias gitc="git commit -m"
alias gitls='(echo "current branch: $(git branch --show-current)"; git ls-files | tree -C --fromfile) | bat'
# alias gitls="tree -C --gitignore | bat"
# alias gitl="git log --oneline --all"
# alias gitl="git log --oneline --graph --all"
# alias gitl="git log --graph --all --decorate --format=format:'%C(yellow)%h%C(reset)%C(auto)%d%C(reset) %C(white)%<(70)%s%C(reset) - %C(cyan)%an%C(reset) %C(magenta)(%ar)%C(reset)'"
alias gitl="git log --graph --all --decorate --format=format:'%C(yellow)%h%C(reset)%C(auto)%d%C(reset) - %C(cyan)%an%C(reset) %C(magenta)(%ar)%C(reset) %C(white)%s%C(reset)'"
alias gitlb="git log --graph --decorate --format=format:'%C(yellow)%h%C(reset)%C(auto)%d%C(reset) - %C(cyan)%an%C(reset) %C(magenta)(%ar)%C(reset) %C(white)%s%C(reset)'"

alias q="exit"
alias qq="exit"
alias qqq="exit"
alias :q="exit"
