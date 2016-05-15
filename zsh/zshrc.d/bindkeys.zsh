# history searching
bindkey '^R' history-incremental-search-backward
bindkey '^T' history-incremental-search-forward

# vim mode!
bindkey -v
bindkey '^H' backward-delete-char
bindkey '^?' backward-delete-char
bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line

# alt-s for executing the insert_sudo_widget (defined in functions.zsh)
bindkey '^[s' insert_sudo_widget
