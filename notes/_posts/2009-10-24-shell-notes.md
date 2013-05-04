---
layout: post
title: Shell notes
summary: Some useful examples about shell.
tags: [shell, ssh, tar]
css:
- /css/pygments.css
- /css/gist.css
---


Variables
---------

{% highlight bash %}
${var}            # value of var (same as $var)
${var-DEFAULT}    # replace by $DEFAULT when $var is not defined (or "DEFAULT" when $DEFAULT is not defined).
${var=DEFAULT}    # create $var with the value $DEFAULT when $var is not defined (or "DEFAULT" when $DEFAULT is not defined).
${var+DEFAULT}    # replace by $DEFAULT when $var is defined. Otherwise leave empty.
${var?ERR_MSG}    # if var not set, print $ERR_MSG and abort script with an exit status of 1. 

${!var*} ${!var@} # matches all previously declared variables beginning with var

# foo=/tmp/my.dir/filename.tar.gz 

${foo#*.}         # remove shortest match from front -> dir/filename.tar.gz
${foo##*/}        # remove longest match from front -> filename.tar.gz (like basename)
${foo%/*}         # remove shortest match from end -> /tmp/my.dir (like dirname)
${foo%%.*}        # remove longest match from end -> /tmp/my

${#str}           # length of str
${str:pos}        # extract substring from $str at $pos
${str:pos:len}    # extract $len characters substring from $str at $pos [zero-indexed, first character is at position 0]

${str/old/new}    # Replace first match of "old" with "new".
${str//old/new}   # Replace all matches of "old" with "new".
${str/#old/new}   # If "old" matches front end of $str, replace "old" with "new".
${str/%old/new}   # If "old" matches back end of $str, replace "old" with "new".

# Special variables

$0 - $9, ${10}    # positional arguments ($0 refers to the name of the script itself).
$#                # the number of positional arguments.
$*                # a single string of positional arguments "$1 $2 .. $n" separated by IFS variable, starting at $1.
$@                # a sequence of positional arguments ("$1", "$2", ... "$n").
$?                # the exit status of the last command executed. When a command
                  # completes successfully, it returns the exit status
                  # of 0 (zero), otherwise it returns a non-zero exit
                  # status.
$$                # the process number of this shell - useful for
                  # including in filenames, to make them unique.
$!                # the process id of the last command run in
                  # the background.
$-                # the current options supplied to this invocation
                  # of the shell.
$_                # last argument of previous command.
$IFS              # internal field separator character.
$RANDOM           # a random integer <= 200 $((RANDOM%=200)). random number between 100 and 300 $((RANDOM%200+100)).
{% endhighlight %}


Arrays
------

{% highlight bash %}
arr=( )                             # create empty array
arr[0]="foo"                        # set value
arr=(${arr[@]} $new)                # push
arr=(${arr[@]:0:$((${#arr[@]}-1))}) # pop
arr=(${arr[@]:1})                   # shift
arr=($new ${arr[@]})                # unshift
echo ${arr[@]}                      # print array

base64_charset=( {A..Z} {a..z} {0..9} + / = )

$ IP=1.2.3.4; A=(${IP//./ });
# Reverse IP
$ echo "${A[3]}.${A[2]}.${A[1]}.${A[0]}"
# IP to INT
$ echo $(((A[0]<<24) + (A[1]<<16) + (A[2]<<8) + A[3]))
{% endhighlight %}


Expressions
-----------

{% highlight bash %}
# arithmetic binary operators
-eq  equal                         -ne  not equal
-lt  less than                     -le  less than or equal
-gt  greater than                  -ge  greater than or equal

# string operators
-n   not empty                     -z   is empty
=    equal to                      !=   not equal to
\<   less than                     \>   greater than (ASCII)

# Files
-e  file exists.                   -r  file is readable.
-f  file is a regular file.        -w  file is writable.
-d  file is a directory.           -x  file is executable.
-h  file is a symbolic link.       -s  file is not zero size.
-b  file is a block device.        -u  SUID (set user ID) bit is set.
-c  file is a character device.    -g  SGID bit is set.
-p  file is a named pipe (FIFO).   -k  sticky bit is set.
-S  file is a socket.              -O  file is owned by you.
-t  file refers to a terminal.     -G  file is owned by your group.

-N          file modified since it was last read.
F1 -nt F2   file F1 is newer than F2, or F1 exists and F2 does not.
F1 -ot F2   file F1 is older than F2, or F2 exists and F1 does not.
F1 -ef F2   files F1 and F2 are hard links to the same file

-o OPT      True if shell option "OPT" is enabled.

Expressions may be combined using the following operators, listed in decreasing order of precedence:

Operation	Effect
[ ! EXPR ]	True if EXPR is false.
[ ( EXPR ) ]	Returns the value of EXPR. This may be used to override the normal precedence of operators.
[ EXPR1 -a EXPR2 ]	True if both EXPR1 and EXPR2 are true.
[ EXPR1 -o EXPR2 ]	True if either EXPR1 or EXPR2 is true.
{% endhighlight %}



Files and folders
-----------------

Unix allows any character in a filename except NUL.
`ls` separates filenames with newlines, 
this leaves us unable to get a list of filenames safely with `ls`.

{% highlight bash %}
touch 'a,comma' 'a|pipe' 'a space' $'a\nnewline'
ls | cat
# a,comma
# a
# newline
# a|pipe
# a space

# Iterate over files in current directory
for f in *; do
	test -f "$f" || continue

	echo "file: $f"
done


# Recursively iterate over files
find . -type f -exec echo "file: {}" \;


# BAD! Do not do this!
for f in $(ls); do ... done
for f in $(find . -maxdepth 1); do ... done
ls | while read f; do ... done


# The -print0 feature is typically found on GNU and BSD systems.
# For find implementations lacking it, it can be emulated
find . -type f -exec printf '%s\0' {} \; | xargs -0 rm
{% endhighlight %}


{% highlight bash %}
# push to remote
tar czf - /path/directory_to_get | ssh user@host "cat > /path/data.tgz" 
tar czf - /path/directory_to_get | ssh user@host tar xzf - -C /path/
cat ~/.ssh/id_rsa.pub | ssh user@host "cat - >> ~/.ssh/authorized_keys"

# pull from remote
ssh user@host "tar czf - /path/directory_to_get" | cat > /path/data.tgz
ssh user@host "tar czf - /path/directory_to_get" | tar xzvf - -C /path/

# get from internet
wget -qO- http://www.rooden.ee/pub/id_rsa.pub >> ~/.ssh/authorized_keys
curl -Ls http://www.rooden.ee/pub/id_rsa.pub >> ~/.ssh/authorized_keys

# Extract tarball from internet without local saving
wget -qO - "http://www.tarball.com/tarball.gz" | tar zxvf -

# File system permissions
find /www -type d -print0 | xargs -0 chmod 0755
find /www -type f -print0 | xargs -0 chmod 0644


### Getting file size
# POSIX
size=$(wc -c -- "$file")
# GNU
size=$(stat -c %s -- "$file")


find . -type f -name .dropbox -exec rm {} +
find . -name *.conf -print0 | xargs -0 grep -l -Z mem_limit | xargs -0 -i cp {} {}.bak
ls -1 -b | grep \.avi | while read FILE; do mkdir "${FILE%%.avi}"; mv "$FILE" "${FILE%%.avi}"; done
{% endhighlight %}


Loops
-----

{% highlight bash %}
for f in *.erl ; do erlc +debug_info -o ../ebin $f; done
for F in *.mp3*; do mv -v "$F" "$(echo "$F" | sed -e s,@.*,,)"; done
for (( c=1; c<=5; c++ )); do echo "Welcome $c times..."; done

for i in $(echo "one;two;three" | tr ";" "\n") ; do echo $i; done

ls -l --time-style=long-iso | grep '^-' | while read a b c d e f g name; do test -d $f || mkdir $f; mv $name $f/; done
{% endhighlight %}


Database
--------

{% highlight bash %}
mysqldump --quick -u user -p pass -h host database | mysql -u user -p pass -P port -h host

ssh user@host "mysqldump -u user -p pass -h sqlhost database | gzip -cf9" | cat > /path/database.gz

mysql -u user -p pass < query.sql > result.txt
{% endhighlight %}


Random
------

{% highlight bash %}
kill -9 `ps -ef |grep stunnel|grep -v grep | awk '{print $2}'`

# Git sha1
echo -en "blob 7\0foobar\n" | sha1sum


for project in list-of-lots-of-projects; do ( \
mkdir "$project"; cd "$project"
git svn init "svn+ssh://user@svnserver.ee/opt/svn/$project" --no-metadata
git config svn.authorsfile /Users/cj/Documents/svn-src/users.txt
git svn fetch ); done

ps -wax -o rss= -p `pgrep -f 'php-cgi'` | awk 'BEGIN {s=0}{s = s + $1} END {print "Total memory used: " s "K"}'
grep "?mod=update" access.log | awk 'BEGIN {s=0} { s+=1; print $4,$5 " - " $1 " - asukoht: " $11 } END { print "-\nKokku leitud ridu:", s ,"\n-"}'
curl -d '{"method":"evlog_insert","params":[{"evcode":"test","origin":"web","ts":123,"ids":[1,3,5] }]}' http://192.168.1.193:8000/json-rpc
{% endhighlight %}



### Disk stuff

{% highlight bash %}
# Clear disk cache
sync; sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
sudo sync; sudo sysctrl -w vm.drop_caches=3; free

# Hard Disk Read Speed
dd if=/dev/sda of=/dev/null bs=1M count=1k

# Hard Disk Write Speed
dd if=/dev/zero of=test.dump bs=1M count=1k conv=fdatasync

# Processor/memory bandwidth
dd if=/dev/zero of=/dev/null bs=1M count=10k

# Show progress of `dd`
dd if=/dev/sda | gzip -c - | ssh user@example.com "dd of=disk_image.gz" &
pid=$!
while ps -p $pid > /dev/null; do kill -USR1 $pid; sleep 10; done

# Wipe disk with read-write test
badblocks -wsv /dev/<device>
{% endhighlight %}




