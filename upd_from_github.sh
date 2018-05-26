#https://blog.csdn.net/u012150179/article/details/17172211
git remote -v
git fetch origin master
git log -p master.. origin/master
git merge origin/master
