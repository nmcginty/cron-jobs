#!/usr/bin/zsh

rsync -avzP --delete --exclude={'.venv','__pycache__'} ~/code/school/drexel/${CURRENT_DREXEL_COURSE}/ nm3249@tux:~/courses/${CURRENT_DREXEL_COURSE}
#rsync -avzP --delete ~/code/school/drexel/${course} nm3249@tux:~/courses/
