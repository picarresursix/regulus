#!/bin/bash

# Compiles a latex document by running pdflatex, bibtex, pdflatex and
# pdflatex again and removing the files generated (except the pdf).

# If the file's name is "notes.tex", appends instruction to add lists
# of figures and tables as well as bibliography using my standard PhD
# bibliography as the bib file.

if [[ $# < 1 ]]
then
    echo "Need a .tex file to compile!"
else
    file_name=$1
    grep "notes.tex" <<< $file_name > /dev/null
    if [[ $? == 0 ]]
    then
        prov_name=./notes-prov.tex
        cat "$file_name" | grep -v "end{document}" > "$prov_name"
        echo "" >> "$prov_name"
        echo "\\listoffigures" >> "$prov_name"
        echo "\\listoftables" >> "$prov_name"
        echo "\\bibliographystyle{alpha}" >> "$prov_name"
        echo "\\bibliography{/home/leo/doctoral_studies/ressources/papers/biblio.bib}" >> "$prov_name"
    fi
    # bib_input=$(echo $file_name | sed "s/.tex//g")
    # pdflatex "$file_name"
    # bibtex "$bib_input"
    # pdflatex "$file_name"
    # pdflatex "$file_name"
    # if [[ $(ls *.aux) ]]; then rm *.aux; fi
    # if [[ $(ls *.bbl) ]]; then rm *.bbl; fi
    # if [[ $(ls *.blg) ]]; then rm *.blg; fi
fi
