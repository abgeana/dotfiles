alias l='ls --quoting-style=literal --color=tty'
alias ls='ls --quoting-style=literal --color=tty'
alias ll='ls --quoting-style=literal --color=tty -lh'
alias llz='ls --quoting-style=literal --color=tty -lhZ'
alias la='ls --quoting-style=literal --color=tty -Ah'
alias lla='ls --quoting-style=literal --color=tty -Alh'
alias llaz='ls --quoting-style=literal --color=tty -AlhZ'

alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias ffi='find . -type f -iname'
alias fdi='find . -type d -iname'

alias unset-proxy='unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY'
alias unset-hist='unset HISTFILE HISTSIZE'

alias tmux='tmux -2'
alias gdb='gdb -q'
alias cd..='cd ..'
alias grep='grep --color=always'
alias less='less -R'
alias ncdu='ncdu -0 -e --color dark'
alias ty='tmux loadb -'
alias rcp="rsync -ah --inplace --info=progress2"
alias rm='echo "This is not the command you are looking for."; false'
alias pz='ps x -o "%p %r %u %c"'

# global aliases defined with '-g' (i.e. can be placed anywhere in other commands)
alias -g silent='> /dev/null 2>&1'
alias -g noerr='2> /dev/null'
alias -g stdboth='2>&1'
