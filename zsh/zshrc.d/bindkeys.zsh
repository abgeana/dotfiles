# if using vi mode, the the viins keymap is used by default
# to specify key bindings to work in command mode, use '-M vicmd'

# vim mode!
bindkey -v
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' backward-kill-line

# go up and down in history
bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward

# history searching
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^T' history-incremental-pattern-search-forward
bindkey -M vicmd '^R' history-incremental-pattern-search-backward
bindkey -M vicmd '^T' history-incremental-pattern-search-forward

# edit command line in editor
bindkey -M viins '^[e' edit-command-line
bindkey -M vicmd '^[e' edit-command-line

# alt-s for executing the insert_sudo_widget (defined in functions.zsh)
bindkey -M viins '^[s' insert_sudo_widget
bindkey -M vicmd '^[s' insert_sudo_widget

# ctrl-z for executing the fancy-ctrl-z widget (defined in functions.zsh)
bindkey -M viins '^Z' fancy-ctrl-z
bindkey -M vicmd '^Z' fancy-ctrl-z
