
function reg_list_dependencies
{
    files=$reg_BASH_CONFIG_FILE\ $reg_SOFTWARE_LIST
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
