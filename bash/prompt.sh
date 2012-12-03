#!/bin/bash
# Time-stamp: <2012-12-03 09:56:19 leo>

# Contains functions used to have a nice prompt.

# dependencies: git


# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[10;95m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

function git_repo_branch
# If the directory we are in is not part of a git branch, prints the
# empty string. Otherwise, prints the branch name.
{
    git branch >/dev/null 2>/dev/null && echo $(git branch | grep \* | cut -d " " -f 2)
}



function pretty_last_commit_description
# If the current directory is in a git repository, pretty prints the
# simple description of the last commit.
{
    description=$(git log -n 1 --oneline | cut -d " " -f 2-)
    echo $description | sed 's/\$/\\\$/g'
}


function pretty_last_commit_date
# If the current directory is in a git repository, pretty prints the
# date of the last commit.
{
    git log -n 1 --format="%cd" | cut -d " " -f 2-5
}



function regulus_prompt
# A coloured prompt displaying time, directory, current git branch,
# last commit time and description (if relevant).
{
    PS1=$Red'\t '$Blue'\u (\w) '
    branch=$(git_repo_branch)
    if [[ $branch == "" ]]; then
        # not in a git repository
        PS1='\n'$PS1'\n-$'
    else
        PS1='\n'$PS1$Color_Off' last commit: ['$(pretty_last_commit_date)']\n'
        PS1=$PS1'['$Red$branch$Color_Off'] '$(pretty_last_commit_description)
        PS1=$PS1$Blue'\n-$'
    fi
    PS1=$PS1$Color_Off' '
}
