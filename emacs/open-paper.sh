#!/bin/bash
# Author: Leo "picarresursix" Perrin <leoperrin@picarresursix.fr>
# Time-stamp: <2013-06-17 21:28:49 leo>



# Opens the paper whose name is given as the second argument if the
# first argument is -o, echoes the name of the first paper matching
# otherwise.


if [[ "$1" == "-o" ]]
    then
    papers=$(find ~/doctoral_studies/ressources/papers -name "$2*pdf")
    evince "$papers" &
    else
    papers=$(find ~/doctoral_studies/ressources/papers -name "$1*pdf")
    echo $papers | sed "s/ /\\\\ /g"
fi
