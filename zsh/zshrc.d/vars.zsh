# history configuration
# https://stackoverflow.com/questions/11917567
export HISTFILE="$HOME/.zsh.history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
export HISTFILESIZE=

# zsh binary distro independent location (needed for .tmux.common)
export ZSH_BINARY=$(which zsh)

# needed for gpg-agent (see man gpg-agent)
export GPG_TTY=$(tty)
if [[ -f "$HOME/.gpg-agent-info" ]]; then
    . "$HOME/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi

# for $EDITOR, check for availability of neovim, otherwise fallback to vim
NVIM_BIN=$(which nvim)
if [[ $? == 0 ]]; then
    export EDITOR=$NVIM_BIN
    alias vim='nvim'
else
    export EDITOR=$(which vim)
fi
