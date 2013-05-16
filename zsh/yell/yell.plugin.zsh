#!/bin/zsh
# AUTHOR: Léo Perrin <leoperrin@picarresursix.fr>
# Time-stamp: <2013-05-11 19:27:32 leo>

# Functions allowing to be yelled at through through a sound and a
# notification when a program which took more than $PATIENCE seconds
# to run is finished.

PATIENCE=10

yell ()
{
    notify-send $*
}

pre_command()
{
    BEGIN_TIME=$(date +"%s")
    CURRENT_CMD_NAME=$1
}

post_command()
{
    END_TIME=$(date +"%s")
    delta=$(bc <<< $END_TIME-$BEGIN_TIME)
    if (($delta > $PATIENCE))
    then
        hours=$(bc <<< $delta/3600)
        minutes=$(bc <<< ($delta-$hours*3600)/60)
        seconds=$(bc <<< ($delta-$hours*3600-$minutes*60))
        yell $CURRENT_CMD_NAME $hours"h "$minutes"min "$seconds"sec"
    fi
}

BEGIN_TIME=$(date +"%s")
CURRENT_CMD_NAME="None"
add-zsh-hook preexec pre_command
add-zsh-hook precmd post_command
