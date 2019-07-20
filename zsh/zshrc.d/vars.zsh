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
# the $VIM_BIN variable is set in aliases.zsh (which just so happens to be executed before vars.zsh)
export EDITOR=$VIM_BIN

# add sbin folders to the path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin
