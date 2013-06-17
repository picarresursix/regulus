#!/bin/bash
# Author: Leo "picarresursix" Perrin <leoperrin@picarresursix.fr>
# Time-stamp: <2013-06-11 17:45:45 leo>


# Opens the paper whose name is given as the first argument

papers=$(find -L ~/doctoral_studies/ressources/papers -name "*$1*pdf" | sed "s/ /\\ /g")
if [ "$papers" = "" ]
then
    echo "no such paper (\""$1"\")"
    else
    evince "$papers" &
fi
