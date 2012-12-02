#!/bin/bash


# Contains several bash functions supposed to be useful for me,
# <leoperrin@picarresursix.fr>.


function yell_when_done
# Runs the command given as a paramater and emits a beep and sends a
# notification when the computations are finished.
{
    $* ;
    notify-send $1 "[done]" ;
    beep -f 400 -l 200 --new -f 600 -l 150 ;
}
