
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
