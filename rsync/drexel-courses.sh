#!/usr/bin/zsh

course="qfds-dsci500"
rsync -avzP --delete ~/code/school/drexel/${course} nm3249@tux:~/courses/
