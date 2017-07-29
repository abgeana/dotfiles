alias l='ls --quoting-style=literal --color=tty'
alias ls='ls --quoting-style=literal --color=tty'
alias ll='ls --quoting-style=literal --color=tty -lh'
alias la='ls --quoting-style=literal --color=tty -Ah'
alias lla='ls --quoting-style=literal --color=tty -Alh'
alias cd..='cd ..'
alias tmux='tmux -2'
alias tmux-ssh='tmux -2 -f ~/.tmux.conf.ssh -S /tmp/tmux-ssh'
alias dhcp='dhclient -r && dhclient'
alias cat='cat -v'
alias unset-proxy='unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY'
alias unset-hist='unset HISTFILE'
alias brm='/bin/rm -irf'
alias gdb='gdb -q'
alias arm-gdb='arm-none-eabi-gdb -q'
alias grep='grep --color=always'
alias less='less -R'
alias fm='vifm'
alias cal='ncal -M -w -3'
alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias ffi='find . -type f -iname'
alias fdi='find . -type d -iname'

# global aliases defined with '-g' (i.e. can be placed anywhere in other commands)
alias -g silent='> /dev/null 2>&1'
alias -g noerr='2> /dev/null'
alias -g stdboth='2>&1'

# if we have neovim installed, alias vim to nvim
NVIM_BIN=$(which nvim 2> /dev/null)
if [[ $? == 0 ]]; then
    alias vim='nvim'
    VIM_BIN=$NVIM_BIN
fi

# if we have vimx on fedora, alias vim to vimx
VIMX_BIN=$(which vimx 2> /dev/null)
if [[ $? == 0 ]]; then
    alias vim='vimx'
    VIM_BIN=$VIMX_BIN
fi

# aliases specific for cygwin
if [[ $(uname -a) =~ .*Cygwin.* ]]; then
    alias clear='echo -e "\033c"'
    alias psh='echo "\n" | powershell'
fi
