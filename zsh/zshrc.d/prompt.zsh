HOSTNAME=$(hostname -s)
if [[ $(id -u) == 0 ]]; then
    COLOR_USER=87
else
    COLOR_USER=196
fi

if [[ $HOSTNAME =~ rogvm\-.* ]]; then
    COLOR_HOST=214
else
    typeset -A HOST_COLORS
    HOST_COLORS=(
        bendis          156
        heretic         156
        hathor           41
        rogue           202
        decebal          92
        tanya           134
    )

    for key in "${(@k)HOST_COLORS}"; do
        if [[ $HOSTNAME == $key ]]; then
            COLOR_HOST=$HOST_COLORS[$key]
        fi
    done

    if [[ -z $COLOR_HOST ]]; then
        COLOR_HOST=$(python -c "import hashlib; m = hashlib.md5(); m.update('$HOSTNAME'); print ord(m.digest()[0])")
    fi
fi

# unicode arrows ◀ ▶ ▲ ▼
# some good places to find exotic unicode symbols:
# http://shapecatcher.com/
# http://panmental.de/symbols/info.htm
# http://xahlee.info/comp/unicode_arrows.html
if [[ $(id -u) == 0 || "$(which task)" =~ ".*not found" ]]; then
    export PROMPT=" %F{ $COLOR_USER }% ○ %F{ $COLOR_HOST }%m%F{ $COLOR_USER } ▶%f "
else
    # use single quotes to re-evaluate properly every time
    export PROMPT=' %F{ $COLOR_USER }% $(gtd_report) %F{ $COLOR_HOST }%m%F{ $COLOR_USER } ▶%f '
fi
