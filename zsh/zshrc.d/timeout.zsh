# timeouts to do things every $TMOUT seconds
TMOUT=1

TRAPALRM() {
    # this is needed to update the time in the prompt every second
    # https://stackoverflow.com/questions/2187829
    zle reset-prompt

    # for root shells (see watchdog.zsh)
    verify-watchdog-self-destroy
}
