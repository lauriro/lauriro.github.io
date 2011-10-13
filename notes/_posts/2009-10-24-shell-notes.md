---
layout: post
title: Shell notes
summary: Some useful examples about shell.
tags: [shell, ssh, tar]
css:
- /css/pygments.css
- /css/gist.css
---


Strings
-------

{% highlight bash %}
${var:-default}   # replace by "default" when $var is not defined.
${var:+default}   # replace by "default" when $var is defined. Otherwise leave empty.
${var:?"Message"} # display error message when $var is not defined. 
${var:=default}   # create $var with the Value default when $var is not defined.

${var/old/new}    # Replace first match of "old" with "new".
${var//old/new}   # Replace all matches of "old" with "new".
${var/#old/new}   # If "old" matches front end of $var, replace "old" with "new".
${var/%old/new}   # If "old" matches back end of $var, replace "old" with "new".

# foo=/tmp/my.dir/filename.tar.gz 

${foo%/*}   # remove shortest match from end -> /tmp/my.dir (like dirname)
${foo%%.*}  # remove longest match from end -> /tmp/my
${foo#*.}   # remove shortest match from front -> dir/filename.tar.gz
${foo##*/}  # remove longest match from front -> filename.tar.gz (like basename)

${#foo}     # length
{% endhighlight %}


Special variables
-----------------

{% highlight bash %}
$0 - $9   positional arguments ($0 refers to the name of the script itself).
$#        the number of positional arguments.
$*        a single string of positional arguments "$1 $2 .. $n" separated by IFS variable, starting at $1.
$@        a sequence of positional arguments ("$1", "$2", ... "$n").
$?        the exit status of the last command executed. When a command
          completes successfully, it returns the exit status
          of 0 (zero), otherwise it returns a non-zero exit
          status.
$$        the process number of this shell - useful for
          including in filenames, to make them unique.
$!        the process id of the last command run in
          the background.
$-        the current options supplied to this invocation
          of the shell.
$IFS      internal field separator character.
$RANDOM   a random integer <= 200 $((RANDOM%=200)). random number between 100 and 300 $((RANDOM%200+100)).
{% endhighlight %}


Arrays
------

{% highlight bash %}
arr=( )                             # create empty array
echo ${arr[@]}                      # print array
arr=(${arr[@]} $new)                # push
arr=(${arr[@]:0:$((${#arr[@]}-1))}) # pop
arr=(${arr[@]:1})                   # shift
arr=($new ${arr[@]})                # unshift

$ IP=1.2.3.4; A=(${IP//./ });
# Reverse IP
$ echo "${A[3]}.${A[2]}.${A[1]}.${A[0]}"
# IP to INT
$ echo $(((A[0]<<24) + (A[1]<<16) + (A[2]<<8) + A[3]))
{% endhighlight %}


Expressions used with if
------------------------

{% highlight bash %}
[ -a FILE ]	True if FILE exists.
[ -b FILE ]	True if FILE exists and is a block-special file.
[ -c FILE ]	True if FILE exists and is a character-special file.
[ -d FILE ]	True if FILE exists and is a directory.
[ -e FILE ]	True if FILE exists.
[ -f FILE ]	True if FILE exists and is a regular file.
[ -g FILE ]	True if FILE exists and its SGID bit is set.
[ -h FILE ]	True if FILE exists and is a symbolic link.
[ -k FILE ]	True if FILE exists and its sticky bit is set.
[ -p FILE ]	True if FILE exists and is a named pipe (FIFO).
[ -r FILE ]	True if FILE exists and is readable.
[ -s FILE ]	True if FILE exists and has a size greater than zero.
[ -t FD ]	True if file descriptor FD is open and refers to a terminal.
[ -u FILE ]	True if FILE exists and its SUID (set user ID) bit is set.
[ -w FILE ]	True if FILE exists and is writable.
[ -x FILE ]	True if FILE exists and is executable.
[ -O FILE ]	True if FILE exists and is owned by the effective user ID.
[ -G FILE ]	True if FILE exists and is owned by the effective group ID.
[ -L FILE ]	True if FILE exists and is a symbolic link.
[ -N FILE ]	True if FILE exists and has been modified since it was last read.
[ -S FILE ]	True if FILE exists and is a socket.
[ FILE1 -nt FILE2 ]	True if FILE1 has been changed more recently than FILE2, or if FILE1 exists and FILE2 does not.
[ FILE1 -ot FILE2 ]	True if FILE1 is older than FILE2, or is FILE2 exists and FILE1 does not.
[ FILE1 -ef FILE2 ]	True if FILE1 and FILE2 refer to the same device and inode numbers.
[ -o OPTIONNAME ]	True if shell option "OPTIONNAME" is enabled.
[ -z STRING ]	True of the length if "STRING" is zero.
[ -n STRING ] or [ STRING ]	True if the length of "STRING" is non-zero.
[ STRING1 == STRING2 ]	True if the strings are equal. "=" may be used instead of "==" for strict POSIX compliance.
[ STRING1 != STRING2 ]	True if the strings are not equal.
[ STRING1 < STRING2 ]	True if "STRING1" sorts before "STRING2" lexicographically in the current locale.
[ STRING1 > STRING2 ]	True if "STRING1" sorts after "STRING2" lexicographically in the current locale.
[ ARG1 OP ARG2 ]	"OP" is one of -eq, -ne, -lt, -le, -gt or -ge. These arithmetic binary operators return true if "ARG1" is equal to, not equal to, less than, less than or equal to, greater than, or greater than or equal to "ARG2", respectively. "ARG1" and "ARG2" are integers.
Expressions may be combined using the following operators, listed in decreasing order of precedence:

Operation	Effect
[ ! EXPR ]	True if EXPR is false.
[ ( EXPR ) ]	Returns the value of EXPR. This may be used to override the normal precedence of operators.
[ EXPR1 -a EXPR2 ]	True if both EXPR1 and EXPR2 are true.
[ EXPR1 -o EXPR2 ]	True if either EXPR1 or EXPR2 is true.
{% endhighlight %}

Files and folders
-----------------

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

# Filesize:
stat -c%s temp.txt
cat temp.txt | wc -c


ls -1 -b | grep \.avi | while read FILE; do mkdir "${FILE%%.avi}"; mv "$FILE" "${FILE%%.avi}"; done
find ./ | grep \.dropbox | while read FILE; do rm "$FILE"; done

find . -name *.conf -print0 | xargs -0 grep -l -Z mem_limit | xargs -0 -i cp {} {}.bak
{% endhighlight %}


Loops
-----

{% highlight bash %}
for f in *.erl ; do erlc +debug_info -o ../ebin $f; done
for F in *.mp3*; do mv -v "$F" "$(echo "$F" | sed -e s,@.*,,)"; done
for (( c=1; c<=5; c++ )); do echo "Welcome $c times..."; done

for i in $(echo "one;two;three" | tr ";" "\n") ; do echo $i; done
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




