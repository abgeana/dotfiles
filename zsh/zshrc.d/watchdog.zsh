# the watchdog code allows the automatic destruction of root shells after a certain amount of time
# this code requires the timeout.zsh file to be loaded as well

SHELL_PID=$$
IPC_FILE="/tmp/ipc-watchdog-self-destroy-$SHELL_PID"

watchdog-self-destroy() {
    local TIMER_SELF_DESTROY=2
    while [[ $TIMER_SELF_DESTROY > 0 ]]; do
        sleep 60

        IPC_CONTENT=$(cat $IPC_FILE)
        echo '' > $IPC_FILE
        if [[ $IPC_CONTENT == kick ]]; then
            TIMER_SELF_DESTROY=15
        else
            TIMER_SELF_DESTROY=$(($TIMER_SELF_DESTROY-1))
        fi

        if [[ $TIMER_SELF_DESTROY == 1 ]]; then
            print $fg[red]'\n!!! Shell session will be closed in one minute !!!'
        elif [[ $TIMER_SELF_DESTROY == 0 ]]; then
            echo 'exit' > $IPC_FILE
        fi
    done
}

kick-watchdog-self-destroy() {
    echo 'kick' > $IPC_FILE
}

start-watchdog-self-destroy() {
    touch $IPC_FILE
    chmod 600 $IPC_FILE
    kick-watchdog-self-destroy
    watchdog-self-destroy $IPC_FILE&
}

clean-watchdog-self-destroy-files() {
    for f in `ls /tmp/ipc-watchdog-self-destroy-*`; do
        local oldpid=$(echo $f | awk '{ split($0, a, "-"); print a[5] }')
        local pidcmd=$(ps -p $oldpid -o comm=)
        if [[ $pidcmd != zsh ]]; then
            rm $f
        fi
    done
}

verify-watchdog-self-destroy() {
    # this is needed to exit from root shells when the watchdog times out
    if [[ $(id -u) == 0 ]]; then
        local IPC_CONTENT=$(cat $IPC_FILE 2> /dev/null)
        if [[ $IPC_CONTENT == exit ]]; then
            exit
        fi
    fi
}

if [[ $(id -u) == 0 ]]; then
    echo 'Started self destroy watchdog...'
    start-watchdog-self-destroy
fi
