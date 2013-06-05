# Author: Leo "picarresursix" Perrin <leoperrin@picarresursix.fr>
# Time-stamp: <2013-05-22 10:57:49 leo>


# Opens the paper whose name is given as the first argument

papers=$(find ~/Bibliotheque/scientific_papers/ -name "$1*pdf")
evince "$papers" &
