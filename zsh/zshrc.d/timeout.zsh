# timeouts to do things every $TMOUT seconds
TMOUT=1

TRAPALRM() {
    # for root shells (see watchdog.zsh)
    verify-watchdog-self-destroy
}
