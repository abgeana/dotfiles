# specific host & user settings outside version control
if [[ -f ~/.zshrc.add ]]; then
    source ~/.zshrc.add
fi

# load custom dircolors file if present
if [[ -f ~/.dircolors ]]; then
    eval "export $(dircolors --sh ~/.dircolors)"
fi

# word splitting - non alphanumeric chars treated as part of a word
# default is '*?_-.[]~=/&;!#$%^(){}<>'
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # remove /

# autoload calls for functions distributed by zsh
# explanations for autoload flags in:
#   man zshbuilins
#   https://unix.stackexchange.com/questions/214296
#   https://stackoverflow.com/questions/12570749

# for autocompletion
autoload -Uz compinit
# for colors in the shell
autoload -Uz colors
# for adding event hooks
autoload -Uz add-zsh-hook
# for using regular expressions
autoload -Uz regexp-replace

# call initialization functions distributed by zsh
# these are declared by autoload calls above

# enable autocompletion
compinit
# allow use of colors (e.g. in prompt)
colors

# configure options in zsh
# explanations for setopt/unsetopt in:
#   man zshoptions

# enable substitutions and expansions
setopt prompt_subst
# automatically change directories without cd
setopt autocd
# expand on characters such as '~' for home directory
setopt extendedglob
# case insensitive globbing
unsetopt case_glob
# append commands to history immediately (not at exit)
setopt inc_append_history
# share history file between zsh sessions
setopt share_history
# remove old duplicates of new history entries
setopt hist_ignore_all_dups
# if a command starts with a space, then do not include it in the history file
setopt hist_ignore_space
# this line makes sure the right prompt of previous lines is removed
setopt transient_rprompt
# automatically get completion when pressing tab instead of a list of options
#setopt menu_complete

# zstyle changes
# explanations for the zstyle command in:
#   man zshmodules
#   http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fzutil-Module

# use same dircolors config for autocomplete suggestions
# https://superuser.com/questions/700406
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# make autocomplete suggestions case insensitive
# https://unix.stackexchange.com/questions/185537
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
