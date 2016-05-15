alias l='ls --color=tty'
alias ls='ls --color=tty'
alias ll='ls --color=tty -lh'
alias la='ls --color=tty -Ah'
alias lla='ls --color=tty -Alh'
alias cd..='cd ..'
alias tmux='tmux -2'
alias tmux-ssh='tmux -2 -f ~/.tmux.conf.ssh -S /tmp/tmux-ssh'
alias tb='tmux attach-session -t base || tmux new-session -s base'
alias dhcp='dhclient -r && dhclient'
alias cat='cat -v'
alias unset-proxy='unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY'
alias unset-hist='unset HISTFILE'
alias brm='/bin/rm'
alias gdb='gdb -q'
alias grep='grep --color=always'
alias less='less -R'

# global aliases defined with '-g' (i.e. can be placed anywhere in other commands)
alias -g silent='> /dev/null 2>&1'
alias -g noerr='2> /dev/null'
alias -g stdboth='2>&1'

# if we have neovim installed, alias vim to nvim
NVIM_BIN=$(which nvim)
if [[ $? == 0 ]]; then
    alias vim='nvim'
fi

# aliases specific for cygwin
if [[ $(uname -a) =~ ".*Cygwin.*" ]]; then
    alias clear='echo -e "\033c"'
    alias psh='echo "\n" | powershell'
fi
