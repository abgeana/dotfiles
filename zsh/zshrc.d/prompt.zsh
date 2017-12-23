COLOR_EXTRA='118'
HOSTNAME=$(hostname -s)
if [[ $(id -u) == 0 ]]; then
    COLOR_USER='51'
else
    COLOR_USER='196'
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

export PROMPT="%F{255}[ %F{ $COLOR_USER }%n%F{ $COLOR_EXTRA } @ %F{ $COLOR_HOST }%m%F{ $COLOR_EXTRA } %F{255}] %F{ $COLOR_EXTRA }%2d %f "
