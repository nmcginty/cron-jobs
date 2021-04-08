#!/usr/bin/zsh

course="ml-cs613"
rsync -avzP --exclude={'.venv','__pycache__'} ~/code/school/drexel/${course} nm3249@tux:~/courses/
#rsync -avzP --delete ~/code/school/drexel/${course} nm3249@tux:~/courses/
