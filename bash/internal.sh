
export reg_DIR=~/regulus

function reg_install
{
    if [[ $# < 1 ]]
    then
        reg_msg_fail I need to know which script to install.
        echo "Usage: reg_install <script>"
    else
        chmod +x $1
        script_name=$(sed "s/\(.*\)\/\(.*\)\.\(.*\)/\2/" <<< $1)
        sudo cp $1 /usr/local/bin/$script_name
        if [[ $? == 0 ]]
        then
            reg_msg_success "$1 successfully moved to /usr/local/bin/"$script_name
        else
            reg_msg_fail "Problem when copying. Do you have the correct rights?"
        fi
    fi
}

export reg_RED=$(tput setaf 1)
export reg_GREEN=$(tput setaf 2)
export reg_YELLOW=$(tput setaf 3)
export reg_BLUE=$(tput setaf 4)
export reg_PURPLE=$(tput setaf 5)
export reg_CYAN=$(tput setaf 6)
export reg_RESET_COLOR=$(tput sgr0)

function reg_msg_fail
{
    echo $reg_RED"[FAIL]"$reg_RESET_COLOR $1
}

function reg_msg_success
{
    echo $reg_GREEN"[OK]"$reg_RESET_COLOR $1
}

function reg_list_dependencies
{
    files=$(find $reg_DIR -name "[^.\#]*.org")
    res=""
    for file in $files; do
        if (($# < 1)); then
            for dependency in $(grep "Dependencies\:" $file | cut -d ":" -f 2); do
                res=$res" "$dependency
            done
        else
            for dependency in $(grep "Dependencies\:" $file | grep $1 | cut -d ":" -f 2); do
                res=$res" "$dependency
            done
        fi
    done
    echo $res        
}

function reg_is_installed
{
    if [[ $(dpkg --get-selections | grep $1) == "" ]]; then
        echo "no"
    else
        echo "yes"
    fi
}

function reg_check_dependencies
{
    for dependency in $(reg_list_dependencies); do
        if [[ $(reg_is_installed $dependency) == "yes" ]]; then
            echo $dependency' '$reg_GREEN'[yes]'$reg_RESET_COLOR
        else
            echo $dependency' '$reg_RED'[no]'$reg_RESET_COLOR
        fi
    done
}

function reg_git_current_branch
{
    git branch >/dev/null 2>/dev/null && echo $(git branch | grep \* | cut -d " " -f 2)
}

function reg_last_commit_description
{
    description=$(git log -n 1 --oneline | cut -d " " -f 2-)
    echo $description | sed 's/\$/\\\$/g'
}

function reg_last_commit_date
{
    git log -n 1 --format="%cd" | cut -d " " -f 2-5
}

function reg_prompt
{
    branch=$(reg_git_current_branch)
    if [[ $branch == "" ]]; then
        # not in a git repository
        PS1='\n\['$reg_RED'\]\t \['$reg_BLUE'\]\u (\w) \n-$\['$reg_RESET_COLOR'\] '
    else
        PS1='\n\['$reg_RED'\]\t \['$reg_BLUE'\]\u (\w)\['$reg_RESET_COLOR'\] last commit: ['$(reg_last_commit_date)']\n[\['$reg_RED'\]'$branch'\['$reg_RESET_COLOR'\]] \['$UBlack'\]'$(reg_last_commit_description)'\['$reg_RESET_COLOR'\]\['$reg_BLUE'\n-$\['$reg_RESET_COLOR'\] '
    fi
}
