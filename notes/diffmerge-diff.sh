#!/bin/sh

path="$(cygpath $1)"
old="$(cygpath --mixed --absolute "$2")"
new="$(cygpath --mixed --absolute "$5")"

echo -e "path\n$path"
echo -e "old\n$old"
echo -e "new\n$new"

"/c/Program Files/SourceGear/DiffMerge/DiffMerge.exe" -nosplash "$old" "$new" --title1="Old" --title2="New $path"