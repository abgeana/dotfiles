# vim: foldmethod=marker

alias tmux='tmux -2'
alias tb='ts base'
alias tm='tmux -L master'
alias tp='tmuxp'
alias tminit='cd ~; tmuxp load -L master'

# create new tmux session and switch to it
ts() {
    local target_session=''
    local target_exists=0

    if [[ $# != 1 ]]; then
        target_session='base'
    else
        target_session=$1
    fi

    # make a list of all sessions
    sessions=( $(tmux list-sessions | awk '{ split($1, s, ":"); print s[1] }') )

    # check if the target session name exists
    # https://stackoverflow.com/questions/5203665
    if [[ ${sessions[(i)$target_session]} -le ${#sessions} ]]; then
        target_exists=1
    else
        target_exists=0
    fi

    # if target session does not exist, then create it in detached mode
    if [[ $target_exists == 0 ]]; then
        tmux new-session -d -s $target_session
    fi

    # wait for tmux to start a new session
    sleep 0.2

    # switch to the session
    if [[ $TMUX ]]; then
        # if we are inside a tmux session, then just switch
        tmux switch-client -t $target_session
    else
        # if we are not inside a tmux session, attach to it
        tmux attach -t $target_session
    fi
}
