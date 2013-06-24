#!/bin/bash

# Compiles a latex document by running pdflatex, bibtex, pdflatex and
# pdflatex again and removing the files generated (except the pdf).

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
fi
