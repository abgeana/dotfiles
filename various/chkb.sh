#! env zsh

set -e
set -o pipefail

LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')
if [[ $LAYOUT == "us" ]]
then
    echo 'Setting keyboard layout to Russian (ru).'
    setxkbmap ru
else
    echo 'Setting keyboard layout to English (us).'
    setxkbmap us
fi
