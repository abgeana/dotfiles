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

# edit tmux pane in editor
bindkey -M viins '^[E' pane-edit
bindkey -M vicmd '^[E' pane-edit

# alt-s for executing the insert-sudo widget (defined in functions.zsh)
bindkey -M viins '^[s' insert-sudo
bindkey -M vicmd '^[s' insert-sudo

# ctrl-z for executing the fancy-ctrl-z widget (defined in functions.zsh)
bindkey -M viins '^Z' fancy-ctrl-z
bindkey -M vicmd '^Z' fancy-ctrl-z

# alt-q for executing the quote-word widget (defined in functions.zsh)
bindkey -M viins '^[q' quote-word
bindkey -M vicmd '^[q' quote-word

# alt-shift-q for executing the unquote-word widget (defined in functions.zsh)
bindkey -M viins '^[Q' unquote-word
bindkey -M vicmd '^[Q' unquote-word

# ctrl-o for running lfcd (defined in lfcd.zsh)
# lf does not work well if bindkey calls a widget; use -s instead
bindkey -M viins -s '^O' 'lfcd\n'
bindkey -M vicmd -s '^O' 'lfcd\n'
