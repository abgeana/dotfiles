# code for the left side of the prompt

COLOR_EXTRA='118'
HOSTNAME=$(hostname -s)

if [[ $(uname -a) =~ ".*Linux.*" ]]; then

    # prompt when using zsh in a linux based environment

    if [[ $(id -u) == 0 ]]; then
        COLOR_USER='51'
    else
        COLOR_USER='196'
    fi

    if [[ $HOSTNAME =~ hthvm\-.* ]]; then
        COLOR_HOST=208
    elif [[ $HOSTNAME =~ rogvm\-.* ]]; then
        COLOR_HOST=201
    else
        typeset -A HOST_COLORS
        HOST_COLORS=(
            bendis          156
            heretic         156
            hathor          227
            rogue           206
            apozeu           36
            homero           21
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

    export PROMPT="%F{255}[ %* ]%F{ $COLOR_USER } %n %F{ $COLOR_EXTRA } @ %F{ $COLOR_HOST } %m %F{ $COLOR_EXTRA }: %~ %f "

elif [[ $(uname -a) =~ .*Cygwin.* ]]; then

    # prompt when using zsh in a cygwin based environment

    if [[ $(id -Gn) =~ .*Administrators.* ]]; then
        COLOR_USER='51'
    else
        COLOR_USER='196'
    fi

    COLOR_HOST='118'

    export PROMPT="%F{255}[ %* ]%F{ $COLOR_USER } %n%F{ $COLOR_EXTRA }: %~ %f "

fi

# color for the right side of the prompt which shows the mode (e.g. normal, insert) when using vimode
# https://superuser.com/questions/151803
# http://pawelgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/

VIM_INS_MODE="[INS]"
VIM_NRM_MODE="[NRM]"
VIM_MODE=$VIM_INS_MODE

function zle-keymap-select {
    VIM_MODE="${${KEYMAP/vicmd/${VIM_NRM_MODE}}/(main|viins)/${VIM_INS_MODE}}"
    zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
    VIM_MODE=$VIM_INS_MODE
}
zle -N zle-line-finish

# for some reason i currently fail to understand, the line below needs to be exactly as is
# do not change the quotes
RPROMPT='${VIM_MODE}'
