#!/bin/bash

# AUTHOR: Leo Perrin <leoperrin@picarresursix.fr>

yell_CHECKPERIOD=2

yell_MUSICPLAYER=music123

yell_BEEPFILE=~/regulus/yell/beep.wav

function do_yell
{
    notify-send $1 "[done]" ;
    $yell_MUSICPLAYER $yell_BEEPFILE 2>/dev/null
}

function yell_when_done
{
    processes=$(ps -ef)
    if [[ $(grep $1 <<< $processes) == "" ]]; then
        echo "No such process as '"$1"'. Aborting."
    else
        echo "Process found"
        keepGoing=0
        while [[ $keepGoing == 0 ]]; do
            processes=$(ps -ef)
            if [[ $(grep $1 <<< $processes) == "" ]]; then
                keepGoing=1
            else
                sleep $yell_CHECKPERIOD
            fi
        done
        do_yell $1
    fi
}

yell_when=0
while getopts ":w:" option
do
    case $option in
        w)
            yell_when=1
            if [[ $# < 2 ]]
            then
                echo "I need a string to search in the process's name!"
            else
                yell_when_done $2
            fi
            ;;
    esac
done
if [[ $yell_when == 0 ]]
then
    do_yell $1
fi
