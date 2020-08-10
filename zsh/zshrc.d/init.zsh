# load custom dircolors file if present
if [[ -f ~/.dircolors ]]; then
    eval "export $(dircolors --sh ~/.dircolors)"
fi

# word splitting - non alphanumeric chars treated as part of a word
# default is '*?_-.[]~=/&;!#$%^(){}<>'
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # remove /

# set time between esc key press and mode change registration to 0.1 seconds
export KEYTIMEOUT=1

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
# for editing the command line in $EDITOR
autoload -Uz edit-command-line
# to modify the word under the cursor
autoload -Uz modify-current-argument

# load modules
# explanations for modules in:
#   man zshmodules
#   https://linux.die.net/man/1/zshmodules
zmodload zsh/zpty

# enable editing the command line in $EDITOR
zle -N edit-command-line

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
# allow corrections to be displayed on the screen
setopt correct
# do not ask if i agree to rm all (i already have the special rm function)
setopt rm_star_silent
# run background jobs with the same priority
# also avoids an issue in wsl - https://github.com/Microsoft/WSL/issues/1887
unsetopt bg_nice
# disable the beep sound
unsetopt beep

# zstyle changes
# explanations for the zstyle command in:
#   man zshmodules
#   http://zsh.sourceforge.net/Doc/Release/Zsh-Modules.html#The-zsh_002fzutil-Module

# use same dircolors config for autocomplete suggestions
# https://superuser.com/questions/700406
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
