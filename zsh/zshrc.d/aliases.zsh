alias l='ls --quoting-style=literal --color=tty'
alias ls='ls --quoting-style=literal --color=tty'
alias ll='ls --quoting-style=literal --color=tty -lh'
alias la='ls --quoting-style=literal --color=tty -Ah'
alias lla='ls --quoting-style=literal --color=tty -Alh'

alias tmux='tmux -2'
alias tmux-ssh='tmux -2 -f ~/.tmux.conf.ssh -S /tmp/tmux-ssh'

alias gdb='gdb -q'
alias arm-gdb='arm-none-eabi-gdb -q'

alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias ffi='find . -type f -iname'
alias fdi='find . -type d -iname'

alias unset-proxy='unset http_proxy https_proxy no_proxy HTTP_PROXY HTTPS_PROXY NO_PROXY'
alias unset-hist='unset HISTFILE HISTSIZE'

# randomly useful
alias cd..='cd ..'
alias dhcp='dhclient -r && dhclient'
alias cat='cat -v'
alias brm='/bin/rm -irf'
alias grep='grep --color=always'
alias less='less -R'
alias cal='ncal -M -w -3'

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

# if VIM_BIN has not been set above...
if [[ -z $VIM_BIN ]]; then
    # if we have vimx on fedora, alias vim to vimx
    VIMX_BIN=$(which vimx 2> /dev/null)
    if [[ $? == 0 ]]; then
        alias vim='vimx'
        VIM_BIN=$VIMX_BIN
    fi
fi

# aliases specific for cygwin
if [[ $(uname -a) =~ .*Cygwin.* ]]; then
    alias clear='echo -e "\033c"'
    alias psh='echo "\n" | powershell'
fi
