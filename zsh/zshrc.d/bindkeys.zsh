# if using vi mode, the the viins keymap is used by default
# to specify key bindings to work in command mode, use '-M vicmd'

# history searching
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^T' history-incremental-pattern-search-forward
bindkey -M vicmd '^R' history-incremental-pattern-search-backward
bindkey -M vicmd '^T' history-incremental-pattern-search-forward

# go up and down in history
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward

# vim mode!
bindkey -v
bindkey '^H' backward-delete-char
bindkey '^?' backward-delete-char
bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line

# alt-s for executing the insert_sudo_widget (defined in functions.zsh)
bindkey '^[s' insert_sudo_widget
bindkey -M vicmd '^[s' insert_sudo_widget
