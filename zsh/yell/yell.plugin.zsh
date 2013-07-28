#!/bin/zsh
# AUTHOR: Léo Perrin <leoperrin@picarresursix.fr>
# Time-stamp: <2013-07-28 19:59:05 leo>

# Functions allowing to be yelled at through through a sound and a
# notification when a program which took more than $PATIENCE seconds
# to run is finished.

PATIENCE=15
SIGNIFICANT_TIME=1


pre_command()
{
    BEGIN_TIME=$(date +"%s")
    CURRENT_CMD_NAME=$1
}

post_command()
{
    EXIT_CODE=$?
    END_TIME=$(date +"%s")
    delta=$(bc <<< $END_TIME-$BEGIN_TIME)
    # Sending notification if the process took too long
    if (($delta > $PATIENCE))
    then
        hours=$(bc <<< $delta/3600)
        minutes=$(bc <<< ($delta-$hours*3600)/60)
        seconds=$(bc <<< ($delta-$hours*3600-$minutes*60))
        process_info="exit code: "$EXIT_CODE"\ntime     : "$hours":"$minutes":"$seconds
        notify-send $CURRENT_CMD_NAME $process_info

        # Printing the date of end of the process if it took a
        # significant time
        if [[ $hours > $SIGNIFICANT_TIME ]]
        then
            echo ""
            echo $fg[green]"FINISHED "$reset_color"on "$(date | cut -d "(" -f 1)
            echo ""
        fi
    fi
}

BEGIN_TIME=$(date +"%s")
CURRENT_CMD_NAME="None"
add-zsh-hook preexec pre_command
add-zsh-hook precmd post_command
