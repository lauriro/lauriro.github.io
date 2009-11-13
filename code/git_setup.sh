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
git config --global alias.cm commit -m
git config --global alias.cam commit -am
git config --global alias.s status
git config --global alias.d diff
git config --global alias.cp cherry-pick
git config --global alias.e '!/bin/run_editor.sh'

git config --global core.editor "git e"

git config --global mergetool.diffmerge.cmd "/c/Program\ Files/SourceGear/DiffMerge/DiffMerge.exe --merge --result=\$MERGED \$LOCAL \$BASE \$REMOTE"
git config --global mergetool.diffmerge.trustExitCode false
git mergetool -t diffmerge
