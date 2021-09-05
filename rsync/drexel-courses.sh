#!/usr/bin/zsh

rsync -avzP --delete --exclude={'.venv','__pycache__','.git','*.csv','*.pkl','*.data'} \
      ~/code/school/drexel/${CURRENT_DREXEL_COURSE}/ nm3249@tux:~/courses/${CURRENT_DREXEL_COURSE}
