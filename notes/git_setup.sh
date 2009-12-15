#!/bin/sh
git config --global user.name "Lauri Rooden" 
git config --global user.email lauri@neti.ee

git config --global core.autocrlf false
git config --global color.branch auto
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.status auto

git config --global alias.b branch
git config --global alias.go checkout
git config --global alias.c commit
git config --global alias.s status
git config --global alias.d diff
git config --global alias.dh diff HEAD
git config --global alias.dm diff origin/master
git config --global alias.cp cherry-pick
git config --global alias.e '!/bin/run_editor.sh'

git config --global alias.e '!/usr/bin/geany'
git config --global core.editor "git e"

git config --global mergetool.diffmerge.cmd "/c/soft/DiffMerge/DiffMerge.exe -nosplash --merge --result=\$MERGED \$LOCAL \$BASE \$REMOTE"
git config --global mergetool.diffmerge.cmd "diffmerge -nosplash --merge --result=\$MERGED \$LOCAL \$BASE \$REMOTE"

git config --global mergetool.diffmerge.trustExitCode false
git config --global merge.tool diffmerge

git config --global diff.external "/c/soft/diffmerge-diff.sh"
git config --global diff.external "diffmerge \"$2\" \"$5\" "

git config --global alias.lp "log --pretty=format:'%h %an, %ar: %s'"
git config --global alias.lg "log --pretty=format:'%h %an, %ar: %s' --topo-order --graph --all"



chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub  
chmod 644 ~/.ssh/authorized_keys
chmod 644 ~/.ssh/known_hosts
