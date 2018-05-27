#!/bin/bash

today=`date +"%Y%m%d"`

printenv | sed 's/^\(.*\)$/export \1/g' > /dsrc/project_env.log
cat /dsrc/project_env.log

service cron restart 

#start notebook
jupyter notebook --allow-root


