#!/bin/bash
# Script uses pulse audio contol tools
# provides as-is
# Make script executable and map it on your prefered keyboard shortcut
DEFAULT_MIC=$(pactl stat | grep "Default Source:" | sed 's/Default Source\: //')

function mute_mic()
{
    pactl set-source-mute ${DEFAULT_MIC} 1
    notify-send -t 5000 -u normal "MIC switched OFF"
}

function unmute_mic()
{
    pactl set-source-mute ${DEFAULT_MIC} 0
    notify-send -t 5000 -u normal "MIC switched ON"
}

function switch_mute()
{
    onmute=$(pactl list | sed -n "/${DEFAULT_MIC}/,/^$/p"  | grep -oE "Mute:.*$" | awk '{print $2}')
    if [ "${onmute}" == "yes" ]; then
        unmute_mic
    else
        mute_mic
    fi
}

switch_mute
