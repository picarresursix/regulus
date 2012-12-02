#!/bin/bash


# Contains several bash functions supposed to be useful for me,
# <leoperrin@picarresursix.fr>.

# dependencies: music123

Tell_Check_Period=1
Cli_Music_Player=music123
Beep_File=~/regulus/bash/beep.wav



function yell
# Sends a notification with the $1 as the title and "[done]" as the
# content and triggers a beep sound as well.
{
    notify-send $1 "[done]" ;
    $Cli_Music_Player $Beep_File 2>/dev/null
}



function tell_me_when_done
# Checks every $Tell_Check_Period seconds that a process having the
# string $1 in its name is still output
{
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
