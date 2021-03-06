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
    bib_input=$(echo $1 | sed "s/.tex//g")
    pdflatex "$1"
    bibtex "$bib_input"
    pdflatex "$1"
    pdflatex "$1"
    if [[ $(ls *.aux) ]]; then rm *.aux; fi
    if [[ $(ls *.bbl) ]]; then rm *.bbl; fi
    if [[ $(ls *.blg) ]]; then rm *.blg; fi
    if [[ $(ls *.lot) ]]; then rm *.lot; fi
    if [[ $(ls *.lof) ]]; then rm *.lof; fi
    if [[ $(ls *.log) ]]; then rm *.log; fi
fi
