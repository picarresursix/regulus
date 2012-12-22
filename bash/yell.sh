
reg_yell_CHECKPERIOD=2

reg_yell_MUSICPLAYER=music123

reg_yell_BEEPFILE=~/regulus/bash/beep.wav

function reg_yell
{
    notify-send $1 "[done]" ;
    $reg_yell_MUSICPLAYER $reg_yell_BEEPFILE 2>/dev/null
}

function reg_yell_when_done
{
    processes=$(ps -ef)
    if [[ $(echo $processes | grep $1) == "" ]]; then
        echo "No such process as '"$1"'. Aborting."
    else
        echo "Process found"
        keepGoing=0
        while [[ $keepGoing == 0 ]]; do
            processes=$(ps -ef)
            if [[ $(echo $processes | grep $1) == "" ]]; then
                keepGoing=1
            else
                sleep $reg_yell_CHECKPERIOD
            fi
        done
        yell $1
    fi
}
