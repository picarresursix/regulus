#!/bin/bash



function regulus_list_dependencies
# Lists the dependencies of the scripts in the Regulus_Dir directory.
{
    dependencies=""
    for script in $(ls $regulus_bash_dir"/"*.sh | grep -v dependencies); do
        dependencies=$dependencies$(grep "dependencies" $script | cut -d ":" -f 2)
    done
    echo $dependencies    
}
