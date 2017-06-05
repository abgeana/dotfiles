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
insert_sudo() {
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR+=5
    fi
}

# define new widget for calling the insert_sudo function
zle -N insert_sudo_widget insert_sudo

# this function shows all 255 color codes
show-colors() {
    for i in {0..255}; do
        echo -e "\e[38;05;${i}m${i}"
    done | column -c 80 -s " "
    echo -e "\e[m"
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

# this function prints an incremental timer
stopwatch() {
    date_start=$(date +%s)
    while true; do
        echo -ne "$(date -u --date @$(( $(date +%s) - $date_start )) +%H:%M:%S)\r"
    done
}

# this function prints a decremental timer for the specified amount of time
countdown() {
    if [[ $# == 0 ]]; then
        echo "Usage: countdown [seconds] [ minutes [hours] ]"
        return
    elif [[ $# == 1 ]]; then
        local date_start=$(( $(date +%s) + $1 ))
    elif [[ $# == 2 ]]; then
        local date_start=$(( $(date +%s) + $1 + $2 * 60 ))
    elif [[ $# == 3 ]]; then
        local date_start=$(( $(date +%s) + $1 + $2 * 60 + $3 * 60 * 60 ))
    fi

    while [ $date_start -ge `date +%s` ]; do
        echo -ne "$(date -u --date @$(( $date_start - $(date +%s) )) +%H:%M:%S)\r";
    done
}

# special purpose rm which moves files to ~/.trash instead of actually removing them (life saver)
rm() {
    if [[ ! -d ~/.trash ]]; then
        mkdir ~/.trash
    fi
    for file in "$@"; do
        local base="$(basename $file)"
        if [[ -a ~/.trash/$base ]]; then
            local idx=$(/bin/ls -la ~/.trash | grep $base | wc -l)
            mv $file "$HOME/.trash/$base ($idx)"
        else
            mv $file ~/.trash
        fi
    done
}

# function which cleans the ~/.trash directory used by the above rm
# it removes files older than 30 days
clean-trash() {
    local current_time=$(date +%s)
    for file in ~/.trash/*; do
        local change_time=$(stat -c %Z $file)
        local age=$(( (current_time - change_time) / (60. * 60. * 24) ))
        if [[ $age -gt 30 ]]; then
            /bin/rm -rf $file
        fi
    done
}

# calculate time based otp codes and put the result in the clipboard
totp() {
    local seed=0
    local rawseed=0
    if [[ $# == 0 ]]; then
        while read -r input; do
            rawseed=$( echo $input | grep 'totp' )
            if [[ ! -z $rawseed ]]; then
                seed=$( echo $rawseed | awk '{ split($0, a, " "); print a[2] }' )
            fi
        done
    else
        seed=$1
    fi

    if [[ ! -z $seed ]]; then
        oathtool --totp -b $seed | xsel -ib
        echo "Done."
    else
        echo "No seed has been provided."
    fi
}

# this function performs a grep with all the right flags and pipes through less
grl () {
    grep -r -n "$@" | less
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
    env                                             \
        LESS_TERMCAP_mb=$(printf "\e[1;31m")        \
        LESS_TERMCAP_md=$(printf "\e[1;31m")        \
        LESS_TERMCAP_me=$(printf "\e[0m")           \
        LESS_TERMCAP_se=$(printf "\e[0m")           \
        LESS_TERMCAP_so=$(printf "\e[1;8;31m")      \
        LESS_TERMCAP_ue=$(printf "\e[0m")           \
        LESS_TERMCAP_us=$(printf "\e[1;32m")        \
        man "$@"
}

# open luks encrypted devices easily
luksopen() {
    local need_sudo=0

    if [[ $# != 3 ]]; then
        echo 'Usage: luksopen [device in /dev] [volume name] [mount point]'
        return
    fi

    if [[ $(id -u) != 0 ]]; then
        which sudo &> /dev/null
        if [[ $? != 0 ]]; then
            echo 'You are not root and you do not have sudo installed.'
            return
        else
            need_sudo=1
            sudo -n true 2> /dev/null
            if [[ $? != 0 ]]; then
                echo 'You need to type the password for sudo first!'
            fi
        fi
    fi

    if [[ $need_sudo ]]; then
        sudo cryptsetup luksOpen /dev/$1 $2
        if [[ $? == 0 ]]; then
            sudo mount /dev/mapper/$2 $3
        else
            echo "Could not open $1"
        fi
    else
        cryptsetup luksOpen /dev/$1 $2
        if [[ $? == 0 ]]; then
            mount /dev/mapper/$2 $3
        else
            echo "Could not open $1"
        fi
    fi
}

# close luks devices easily
luksclose() {
    local need_sudo=0

    if [[ $# != 1 ]]; then
        echo 'Usage: luksclose [volume name]'
        return
    fi

    if [[ $(id -u) != 0 ]]; then
        which sudo &> /dev/null
        if [[ $? != 0 ]]; then
            echo 'You are not root and you do not have sudo installed.'
            return
        else
            need_sudo=1
            sudo -n true 2> /dev/null
            if [[ $? != 0 ]]; then
                echo 'You need to type the password for sudo first!'
            fi
        fi
    fi

    local mount_point=$(mount -l | grep $1 | awk '{ print $3 }')

    if [[ $need_sudo ]]; then
        sudo umount $mount_point
        if [[ $? != 0 ]]; then
            sudo cryptsetup luksClose $1
        else
            echo "Could not close $1"
        fi
    else
        umount $mount_point
        if [[ $? != 0 ]]; then
            cryptsetup luksClose $1
        else
            echo "Could not close $1"
        fi
    fi
}

# create new tmux session and switch to it
tn() {
    if [[ $# != 1 ]]; then
        echo 'Usage: tn [new session name]'
        return
    fi

    if [[ $TMUX ]]; then
        tmux new-session -d -s $1
        tmux switch-client -t $1
    else
        echo '$TMUX is not set, meaning you are probably not in a tmux session'
    fi
}

# start a markdown note file and append the date and time to the file name
note() {
    local timestamp="$(date +%Y-%m-%d_%H-%M-%S)"

    if [[ $# != 1 ]]; then
        vim "$timestamp.md"
    else
        vim "$1 $timestamp.md"
    fi
}

# start a vim session with the contents of the current tmux pane
# acronym for "pane edit"
pe() {
    tmux capture-pane -p -S - | \
    vim -c 'call TmuxCapturePaneSetup()' -
}

# this function lets me use ctrl-z to push processes to background
# and to also pull them to foreground
# inspired from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/fancy-ctrl-z/fancy-ctrl-z.plugin.zsh
fancy-ctrl-z () {
    # if line buffer is empty
    if [[ $#BUFFER -eq 0 ]]; then
        # if there are background jobs
        if [[ $(jobs | wc -l) -gt 0 ]]; then
            # run fg
            fg
        else
            print '\nYou have no background jobs.'
        fi
    fi
}

# define new widget for calling the fancy-ctrl-z function
zle -N fancy-ctrl-z
