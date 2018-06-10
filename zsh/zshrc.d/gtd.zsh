# initially based on the "gtd with taskwarrior" tutorial
# https://taskwarrior.org/news/news.20150627.html
# a useful 15 minutes to gtd tutorial
# https://hamberg.no/gtd/

# quick reminders
# to delegate:
#   task n modify -in +waiting
#   task n annotate "check: what to check" due:+1w wait:+1d
# to defer:
#   task n done
#   task proj:gtd add email the paper to jack

# add items to my inbox list
alias in='task add +in'

# add items to my maybe list
alias maybe='task add +maybe'

# add items to my maybe list
alias nxt='task add +nxt'

# add items to the tickle list
tickle () {
    when=$1
    shift
    in +tickle wait:$when $@
}

# function to generate a gtd report and use it in the PROMPT variable
gtd_report() {
    local in=$(task +in +PENDING count)

    if [[ $in == "0" ]]; then
        echo "○"
    else
        echo "｢$in｣"
    fi
}
