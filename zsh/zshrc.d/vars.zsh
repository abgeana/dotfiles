# history configuration
# https://stackoverflow.com/questions/11917567
export HISTFILE="$HOME/.zsh.history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export HISTFILESIZE=

# zsh binary distro independent location (needed for .tmux.common)
export ZSH_BINARY=$(which zsh 2> /dev/null)

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

# needed for gpg-agent (see man gpg-agent)
export GPG_TTY=$(tty)

# load custom dircolors file if present
if [[ -f ~/.dircolors ]]; then
    # on macos use gdircolors which gets installed via the coreutils package
    eval "export $(gdircolors --sh ~/.dircolors)"
fi

# custom PATH
export PATH
PATH=""
path_append() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
path_prepend() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:${PATH:+"$PATH"}"
    fi
}

# add standard (s/)bin folders to the path
path_append "/home/`/usr/bin/id -u -n`/.local/bin"
path_append "/usr/local/bin"
path_append "/usr/bin"
path_append "/bin"
path_append "/usr/local/sbin"
path_append "/usr/sbin"
path_append "/sbin"
