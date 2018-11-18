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

# add items to my waiting list
alias waiting='task add +waiting'

# add items to my maybe list
alias maybe='task add +maybe'

# add items to my maybe list
alias nxt='task add +nxt'

# easy access to taskwarrior output via the task_sed function
t() {
    task_sed $@
}

# function which performs editing on the output of task
task_sed() {
    zpty TASK task $@
    local taskout=$(zpty -r TASK)
    zpty -d TASK

    taskout=$(echo $taskout | python3 ~/.zshrc.d/task_stdout_replace.py)
    echo $taskout
}
