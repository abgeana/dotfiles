# history configuration
# https://stackoverflow.com/questions/11917567
export HISTFILE="$HOME/.zsh.history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export HISTFILESIZE=

# zsh binary distro independent location (needed for .tmux.common)
export ZSH_BINARY=$(which zsh 2> /dev/null)

# needed for gpg-agent (see man gpg-agent)
export GPG_TTY=$(tty)
if [[ -f "$HOME/.gpg-agent-info" ]]; then
    . "$HOME/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi

# for $EDITOR, check for availability of neovim, vimx, or otherwise fallback to vim
NVIM_BIN=$(which nvim 2> /dev/null) # check for neovim
if [[ $? == 0 ]]; then
    export EDITOR=$NVIM_BIN
fi
if [[ ! -v EDITOR ]]; then
    VIMX_BIN=$(which vimx 2> /dev/null) # check for vimx
    if [[ $? == 0 ]]; then
        export EDITOR=$VIMX_BIN
    fi
fi
if [[ ! -v EDITOR ]]; then
    VIM_BIN=$(which vim 2> /dev/null) # check for vim
    if [[ $? == 0 ]]; then
        export EDITOR=$VIM_BIN
    fi
fi
if [[ ! -v EDITOR ]]; then
    export EDITOR=vi # just use vi
fi

# add sbin folders to the path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
