# this function permits the command 'lsw $arg' which performs 'ls -l $(which $arg)'
lsw() {
    local w=$(which $1 2> /dev/null)
    if [[ $? == 0 ]]; then
        ls -l $w
    else
        echo "$w not found"
    fi
}

# the following functions allow execution of the previous command with sudo in front of it
# this is the same as "sudo !!", but with the added cool factor
# save the command to the environment variable $PREVIOUS_COMMAND
save_prev_command() {
    # arguments:
    # $1 line as it was written
    # $2 line with alias expanded and truncated with a certain size limit
    # $3 full line with alias expanded
    if [[ $2 != fuck ]]; then
        PREVIOUS_COMMAND=$2
    fi
}

# hook save_prev_command to be called before execution of a command
add-zsh-hook preexec save_prev_command

# eval contents of $PREVIOUS_COMMAND
fuck() {
    # try to remove some unwanted characters and
    # hopefully prevent a nasty command injection here
    regexp-replace PREVIOUS_COMMAND '[><;]|(\|\|)|(&&)' ''
    echo "$PREVIOUS_COMMAND"
    eval "sudo $PREVIOUS_COMMAND"
}

# this function will add "sudo " before the command when pressing alt-s
# if using rxvt, make sure the searchable-scrollback extension is removed
insert-sudo() {
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR+=5
    fi
}

# define new widget for calling the insert_sudo function
zle -N insert-sudo

# this function shows all 255 color codes
show-colors() {
    for i in {0..255}; do
        echo -e "\e[38;05;${i}m${i}"
    done | column -c 80 -s " "
    echo -e "\e[m"
}

# this function prints a test pattern for 24bit colors
# https://unix.stackexchange.com/a/404415
test-24bit-colors() {
    awk -v term_cols="${width:-$(tput cols || echo 80)}" 'BEGIN{
        s="/\\";
        for (colnum = 0; colnum<term_cols; colnum++) {
            r = 255-(colnum*255/term_cols);
            g = (colnum*510/term_cols);
            b = (colnum*255/term_cols);
            if (g>255) g = 510-g;
            printf "\033[48;2;%d;%d;%dm", r,g,b;
            printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
            printf "%s\033[0m", substr(s,colnum%2+1,1);
        }
        printf "\n";
    }'
}

# this function calcultates the size of all directories and files
# in the current working directory
sz() {
    pwd
    du -hs .
    for node in * ; do
        du -hs "$node"
    done
}

# this function calls ripgrep with all the right flags and pipes through less
rgl () {
    rg --pretty --hidden --no-ignore "$@" | less
}

# reload the ~/.zshrc file
reload() {
    if [[ -f ~/.zshrc ]]; then
        echo "Reloading config file."
        source ~/.zshrc
    fi
}

# colorized man pages
# details on http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
man() {
    # LESS_TERMCAP_mb - begin blinking
    # LESS_TERMCAP_md - begin bold
    # LESS_TERMCAP_me - end mode
    # LESS_TERMCAP_se - end standout-mode
    # LESS_TERMCAP_so - begin standout-mode - info box
    # LESS_TERMCAP_ue - end underline
    # LESS_TERMCAP_us - begin underline
    env                                             \
        LESS_TERMCAP_mb=$(printf "\e[1;31m")        \
        LESS_TERMCAP_md=$(printf "\e[1;31m")        \
        LESS_TERMCAP_me=$(printf "\e[0m")           \
        LESS_TERMCAP_se=$(printf "\e[0m")           \
        LESS_TERMCAP_so=$(printf "\e[1;7;31m")      \
        LESS_TERMCAP_ue=$(printf "\e[0m")           \
        LESS_TERMCAP_us=$(printf "\e[1;32m")        \
        man "$@"
}

# this function lets me use ctrl-z to push processes to the background
# and to also pull them to foreground
# inspired from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
fancy-ctrl-z () {
    # if line buffer is empty
    if [[ $#BUFFER -eq 0 ]]; then
        # if there are background jobs
        if [[ $(jobs | wc -l) -gt 0 ]]; then
            # run fg like this, otherwise vim complains
            BUFFER="fg"
            zle accept-line
        else
            print '\nYou have no background jobs.'
        fi
    fi
}

# define new widget for calling the fancy-ctrl-z function
zle -N fancy-ctrl-z

# this function will escape the word under the cursor when alt-q is pressed
# based on https://www.zsh.org/mla/users/2007/msg00976.html (see _quote_word)
quote-word() {
    q=qqqq
    modify-current-argument '${('$q[1,${NUMERIC:-1}]')ARG}'
}

# define new widget for calling the quote-word function
zle -N quote-word

# this function does the opposite of quote-word defined above
unquote-word() {
    modify-current-argument '${(Q)ARG}'
}

# define new widget for calling the unquote-word function
zle -N unquote-word

# use ranger to cd to another directory
# adapted from https://github.com/ranger/ranger/blob/master/examples/bash_automatic_cd.sh
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    /bin/rm -f -- "$tempfile"
}

ssh-agent-fix() {
    if [[ ! -v TMUX ]]; then
        # we are outside tmux
        # in this case, we check if there is a forwarded agent (i.e. the SSH_AUTH_SOCK variable is set)
        if [[ ! -v SSH_AUTH_SOCK ]]; then
            # the variable is not set
            # export the SSH_AUTH_SOCK variable used by the ssh agent to point it to the gpg agent
            # this is needed to use the hardware gpg keys generated on yubikeys
            export SSH_AUTH_SOCK=`gpgconf --list-dirs agent-ssh-socket`
        fi
    else
        # we are inside tmux
        eval `tmux show-environment -s SSH_AUTH_SOCK`
    fi
}
ssh-agent-fix

gpg-agent-fix() {
    gpg-connect-agent reloadagent /bye > /dev/null
    gpg-connect-agent updatestartuptty /bye > /dev/null
}
