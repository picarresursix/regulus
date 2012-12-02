#!/bin/bash


# Contains several bash functions supposed to be useful for me,
# <leoperrin@picarresursix.fr>.



function yell
# Sends a notification with the $1 as the title and "[done]" as the
# content and triggers a beep sound as well.
{
    notify-send $1 "[done]" ;
    beep -f 400 -l 200 --new -f 600 -l 150 ;
}



function tell_me_when_done
# Checks every $Tell_Check_Period seconds that a process having the
# string $1 in its name is still output
{
    Tell_Check_Period=1
    processes=$(ps -ef)
    if [[ $(echo $processes | grep $1) == "" ]]; then
        echo "No such process as '"$1"'. Aborting."
    else
        keepGoing=0
        while [[ $keepGoing == 0 ]]; do
            processes=$(ps -ef)
            if [[ $(echo $processes | grep $1) == "" ]]; then
                keepGoing=1
            else
                sleep $Tell_Check_Period
            fi
        done
        yell $1
    fi
}
