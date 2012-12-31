#!/bin/bash

# AUTHOR: Leo Perrin <leoperrin@picarresursix.fr>

function rod_load_configuration
{
    if [[ $# < 1 ]]
    then
        rod_file=roadmap.org
    else
        rod_file=$1
    fi
    if [[ ! -e $rod_file ]]
    then
        echo "No "$rod_file" file here! I can't update a none existing file."
        echo "usage: rod_update roadmap_file (roadmap_file is optionnal; defaults to \"roadmap.org\""
    else
        rod_EXCLUDE_FILES=$(grep "EXCLUDE:" $rod_file | cut -d ":" -f 2 | cut -c 2-)
    fi
}

rod_EXTENSIONS_HEADERS="hpp h"

rod_EXTENSIONS_CODE="c cpp py sage el html php css sh tex"

function rod_list_files
{
    old_IFS=$IFS
    IFS=''
    rod_result=$(find . -name "[^.^\#]*.*[^~]")
    IFS=$old_IFS
    for pattern in $rod_EXCLUDE_FILES
    do
        IFS=''
        rod_result=$(grep -v $pattern <<< $rod_result)
        IFS=$old_IFS
    done
    IFS=''
    echo $rod_result #${rod_result//$'\n'/\n/}
    IFS=$old_IFS
}

function rod_display_file_stat
{
    # initialising the counters for each extensions
    number_h=0    ; length_h=0
    number_hpp=0  ; length_hpp=0
    number_c=0    ; length_c=0
    number_cpp=0  ; length_cpp=0
    number_py=0   ; length_py=0
    number_sage=0 ; length_sage=0
    number_el=0   ; length_el=0
    number_html=0 ; length_html=0
    number_css=0  ; length_css=0
    number_php=0  ; length_php=0
    number_sh=0   ; length_sh=0
    number_tex=0  ; length_tex=0 
    number_txt=0  ; length_txt=0 
    number_org=0  ; length_org=0 
    number_md=0   ; length_md=0
    number_misc=0 ; length_misc=0
    total_files=0 ; length_total=0

    # listing the files
    list_files=$(rod_list_files $1)

    # going through the files and counting
    for file in $list_files; do
        extension=$(echo $file | cut -d "." -f 3)
        length=$(wc -l $file | cut -d " " -f 1)
        ((total_files = $total_files+1))
        ((length_total = $length_total+$length))
        case $extension in
            h)  ((number_h = $number_h+1))
                ((length_h = $length_h+$length)) ;;
            hpp)  ((number_hpp = $number_hpp+1))
                ((length_hpp = $length_hpp+$length)) ;;
            c)  ((number_c = $number_c+1))
                ((length_c = $length_c+$length)) ;;
            cpp)  ((number_cpp = $number_cpp+1))
                ((length_cpp = $length_cpp+$length)) ;;
            py)  ((number_py = $number_py+1))
                ((length_py = $length_py+$length)) ;;
            sage)  ((number_sage = $number_sage+1))
                ((length_sage = $length_sage+$length)) ;;
            el)  ((number_el = $number_el+1))
                ((length_el = $length_el+$length)) ;;
            html)  ((number_html = $number_html+1))
                ((length_html = $length_html+$length)) ;;
            css)  ((number_css = $number_css+1))
                ((length_css = $length_css+$length)) ;;
            php)  ((number_php = $number_php+1))
                ((length_php = $length_php+$length)) ;;
            sh)  ((number_sh = $number_sh+1))
                ((length_sh = $length_sh+$length)) ;;
            tex)  ((number_tex = $number_tex+1))
                ((length_tex = $length_tex+$length)) ;;
            txt)  ((number_txt = $number_txt+1))
                ((length_txt = $length_txt+$length)) ;;
            org)  ((number_org = $number_org+1))
                ((length_org = $length_org+$length)) ;;
            md)  ((number_md = $number_md+1))
                ((length_md = $length_md+$length)) ;;
            *)  ((number_misc = $number_misc+1))
                ((length_misc = $length_misc+$length)) ;;
        esac
        done
      
    # computing the numbers for each type
    ((number_header=$number_h+$number_hpp))
    ((length_header=$length_h+$length_hpp))
    ((number_code=$number_c+$number_cpp+$number_py+$number_sage+$number_el+$number_html+$number_css+$number_php+$number_el+$number_sh+$number_tex))
    ((length_code=$length_c+$length_cpp+$length_py+$length_sage+$length_el+$length_html+$length_css+$length_php+$length_el+$length_sh+$length_tex))
    ((number_documentation=$number_txt+$number_org+$number_md))
    ((length_documentation=$length_txt+$length_org+$length_md))

    # displaying the results
    echo -e "** global statistics: #files #lines"
    echo -e "   + total:     "$total_files"\t"$length_total

    if [[ $number_header != 0 ]]; then
        echo -e "   + headers:   "$number_header"\t"$length_header
    fi
    if [[ $number_code != 0 ]]; then
        echo -e "   + code:      "$number_code"\t"$length_code
    fi
    if [[ $number_documentation != 0 ]]; then
        echo -e "   + doc/notes: "$number_documentation"\t"$length_documentation
    fi

    echo -e "** Files sorted by extension"
    if [[ $number_h    != 0 ]]; then echo -e "   + h:   "$number_h"\t"$length_h ; fi
    if [[ $number_c    != 0 ]]; then echo -e "   + c:   "$number_c"\t"$length_c ; fi
    if [[ $number_hpp  != 0 ]]; then echo -e "   + hpp: "$number_hpp"\t"$length_hpp ; fi
    if [[ $number_cpp  != 0 ]]; then echo -e "   + cpp: "$number_cpp"\t"$length_cpp ; fi
    if [[ $number_py   != 0 ]]; then echo -e "   + py : "$number_py"\t"$length_py ; fi
    if [[ $number_sage != 0 ]]; then echo -e "   + sage:"$number_sage"\t"$length_sage ; fi
    if [[ $number_el   != 0 ]]; then echo -e "   + el:  "$number_el"\t"$length_el ; fi
    if [[ $number_html != 0 ]]; then echo -e "   + html:"$number_html"\t"$length_html ; fi
    if [[ $number_css  != 0 ]]; then echo -e "   + css: "$number_css"\t"$length_css ; fi
    if [[ $number_php  != 0 ]]; then echo -e "   + php: "$number_php"\t"$length_php ; fi
    if [[ $number_sh   != 0 ]]; then echo -e "   + sh:  "$number_sh"\t"$length_sh ; fi
    if [[ $number_tex  != 0 ]]; then echo -e "   + tex: "$number_tex"\t"$length_tex ; fi
    if [[ $number_txt  != 0 ]]; then echo -e "   + txt: "$number_txt"\t"$length_txt ; fi
    if [[ $number_org  != 0 ]]; then echo -e "   + org: "$number_org"\t"$length_org ; fi
    if [[ $number_md   != 0 ]]; then echo -e "   + md:  "$number_md"\t"$length_md ; fi
    if [[ $number_misc != 0 ]]; then echo -e "   + misc:"$number_misc"\t"$length_misc ; fi
}

function rod_display_item
{
    if [[ $# < 1 ]]; then
        echo "Argument missing: I need an item to search for!"
    else
        # generating the list of relevant data
        item_list=$(grep -n \!$1\! $(rod_list_files))
        old_IFS=$IFS
        IFS=$'\n'

        # displaying the links
        echo "\\*\\* [/] "${1^^}" list"
        index=0
        for item in $item_list; do
           ((index=$index+1))
           file=$(echo $item | cut -d ":" -f 1)
           line_number=$(echo $item | cut -d ":" -f 2)
           description=$(echo $item | cut -d "!" -f 3- | cut -c 2-)
           echo "   "$index". [ ] [[file:"$(pwd)"/"$file"::"$line_number"]["$description"]] ("$file":"$line_number")"
        done
    fi

    IFS=$old_IFS
}

function rod_remove_heading
{
    if [[ $# < 2 ]]
    then
        echo "I need to know wich heading to remove from which file, sorry."
        echo "usage: rod_remove_heading <heading> <file>"
    else
        awk 'BEGIN {c=0}                           \
             {                                     \
                 if (/^\* '$1'/)                   \
                    {c=1; print $0}                \
                 else if ((c==1)&&(/^\* [A-Z].*/)) \
                    {c=0; print $0}                \
                 else if (c==0)                    \
                    {print $0}                     \
             }' $2
     fi
}

function rod_update
{
    if [[ $# < 1 ]]
    then
        rod_file=roadmap.org
    else
        rod_file=$1
    fi
    if [[ ! -e $rod_file ]]
    then
        echo "No "$rod_file" file here! I can't update a none existing file."
        echo "usage: rod_update roadmap_file (roadmap_file is optionnal; defaults to \"roadmap.org\""
    else
        # removing previous headings
        rod_remove_heading Items $rod_file > $rod_file.temp
        rod_remove_heading Statistics $rod_file.temp > $rod_file
        rm $rod_file.temp

        # adding new content
        stat_file=$(rod_display_file_stat)
        item_todo=$(rod_display_item TODO)
        item_idea=$(rod_display_item IDEA)
        sed -i "/^\* Statistics/a${stat_file//$'\n'/\n}" $rod_file
        sed -i "/^\* Items/a${item_idea//$'\n'/\n}" $rod_file
        sed -i "/^\* Items/a${item_todo//$'\n'/\n}" $rod_file
        echo "Roadmap updated successfully!"
    fi
}

function rod_main_roadmap
{
    if [[ $# < 1 ]]
    then
        current_dir=$(pwd)
    else
        current_dir=$1
    fi

    if [[ $(pwd) == "/" ]]
    then
        echo ""
        cd $current_dir
    elif [[ -e roadmap.org ]]
    then
        echo $(pwd)/roadmap.org
        cd $current_dir
    else
        cd ..
        rod_main_roadmap $current_dir
    fi
}

function rod_help
{
   echo "Usage: roadmap -OPTION"
   echo ""
   echo "OPTION has to be one of the following:"
   echo "   -n: creates an empty roadmap.org file in the current directory."
   echo "   -u: updates the roadmap.org file in the current directory."
   echo "   -h: displays the path to the roadmap ruling this directory tree."
}

happy=0
while getopts ":nuh" option
do
    case $option in
        n)
            cp ~/regulus/roadmap/roadmap-template.org ./roadmap.org
            echo "new roadmap created"
            happy=1
            ;;
        u)
            rod_load_configuration
            echo "Configuration loaded"
            rod_update
            happy=1
            ;;
        h)
            rod_main_roadmap
            happy=1
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            rod_help
            exit 1
    esac
done

if [[ $happy == 0 ]]
then
    rod_help
fi
