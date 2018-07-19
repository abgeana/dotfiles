SHNAME=$(hostname -s)
if [[ $(id -u) == 0 ]]; then
    COLOR_USER=87
else
    COLOR_USER=196
fi

if [[ $(hostname) =~ .*\.alegen\.net ]]; then
    COLOR_HOST=51
elif [[ $SHNAME =~ rogvm\-.* ]]; then
    COLOR_HOST=214
else
    typeset -A HOST_COLORS
    HOST_COLORS=(
        bendis          156
        rogue           202
    )

    for key in "${(@k)HOST_COLORS}"; do
        if [[ $SHNAME == $key ]]; then
            COLOR_HOST=$HOST_COLORS[$key]
        fi
    done

    if [[ -z $COLOR_HOST ]]; then
        COLOR_HOST=$(python -c "import hashlib; m = hashlib.md5(); m.update('$SHNAME'); print ord(m.digest()[0])")
    fi
fi

# unicode arrows ◀ ▶ ▲ ▼
# some good places to find exotic unicode symbols:
# http://shapecatcher.com/
# http://panmental.de/symbols/info.htm
# http://xahlee.info/comp/unicode_arrows.html
TASK_BIN=$(which task 2> /dev/null)
if [[ $? != 0 || $(id -u) == 0 ]]; then
    export PROMPT=" %F{ $COLOR_USER }% ○ %F{ $COLOR_HOST }%m%F{ $COLOR_USER } ▶%f "
else
    # use single quotes to re-evaluate properly every time
    export PROMPT=' %F{ $COLOR_USER }% $(gtd_report) %F{ $COLOR_HOST }%m%F{ $COLOR_USER } ▶%f '
fi
