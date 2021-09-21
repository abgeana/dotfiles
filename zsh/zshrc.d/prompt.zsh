SHNAME=$(hostname -s)
if [[ $(id -u) == 0 ]]; then
    COLOR_USER=46
else
    COLOR_USER=202
fi

if [[ $(hostname) =~ .*\.ubiq.domic.io ]]; then
    COLOR_HOST=82
elif [[ $(hostname) =~ .*\.cuib.domic.io ]]; then
    COLOR_HOST=39
elif [[ $(hostname) =~ .*\.docker.domic.io ]]; then
    COLOR_HOST=201
else
    typeset -A HOST_COLORS
    HOST_COLORS=(
        molly           196
        wl-ageana-01    123
    )

    for key in "${(@k)HOST_COLORS}"; do
        if [[ $SHNAME == $key ]]; then
            COLOR_HOST=$HOST_COLORS[$key]
        fi
    done

    if [[ -z $COLOR_HOST ]]; then
        COLOR_HOST=$(python3 -c "import hashlib; m = hashlib.md5(); m.update('$SHNAME'.encode('utf-8')); print(m.digest()[0])")
    fi
fi

# disable right-hand prompt
unset RPS1
unset RPROMPT

set-prompt() {
    # unicode arrows ◀ ▶ ▲ ▼ ▸
    # some good places to find exotic unicode symbols:
    # http://shapecatcher.com/
    # http://panmental.de/symbols/info.htm
    # http://xahlee.info/comp/unicode_arrows.html
    if [[ $# == 0 ]]; then
        export PROMPT=" %F{ $COLOR_USER }% %F{ $COLOR_HOST }%m%F{ $COLOR_USER } ▶%f "
    else
        export PROMPT=" %F{ $COLOR_USER }% %F{196}[$@] %F{ $COLOR_HOST }%m%F{ $COLOR_USER } ▶%f "
    fi
}

set-prompt
