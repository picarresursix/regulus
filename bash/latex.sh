#!/bin/bash

# Functions intended to make using latex easier


function convert_img_to_eps
# Uses the convert command to convert the given image to the eps
# format used by latex
{
    if [[ $(echo $1 | sed "s/.*\.//g") != "eps" ]]; then
        convert $1 $(echo $1 | sed "s/\..*//g").eps
    fi
}
