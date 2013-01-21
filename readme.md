<!-- Time-stamp: <2013-01-21 20:55:35 leo> -->


REGULUS
=======


Regulus is the name of the system I use to store all the miscellaneous
customization, bash-functions and configuration of my system.  The aim
is to have a proper version control of all of my configuration files
as well as doing some tidying.

I had the idea when I saw the
[sputnik project](https://github.com/sputnik/) started by dell.

The files in this directory are the ones I actually use, i.e. for
instance my `.emacs` file is just a symbolic link to the one at
`~/regulus/emacs/dot_emacs`.


Files currently protected by Regulus
====================================

Bash
----

The configuration of my bash prompt, and the miscellaneous custom
functions I use:

* To have a nice prompt displaying some characteristics of my last
commit if I am in a git repository.
* Easily make scripts executables and copy them somewhere in my $PATH.
* My .bashrc

Emacs configuration
-------------------

My .emacs file and .emacs.d directory. Custom shortcuts, and some
custom functions. For more info about the *meuporg.el* file, look at
my [its website](https://picarresursix.github.com/meuporg).


Yell
----

Functions to warn me when a function's execution is finished via a
notification and a sound. Useful when launching time consuming
computations/simulations.


Vaugho
------

I call my encrypted partition my "vault" and I call my backup "ghost"
(it is a copy of my home). Vaugho provides functions to deal with
both; in particular to be able to mount partitions at the same point
nautilus would.



Modifying/Hacking
=================

As you might guess since I put this project on github, feel free (and
further, encouraged) to use it! I would also love to hear your
comments: you can contact me via github or at `leoperrin
[at/arobase] picarresursix.fr`.
