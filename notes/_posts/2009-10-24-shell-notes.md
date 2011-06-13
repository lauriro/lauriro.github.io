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

# Reverse IP
$ IP=1.2.3.4; A=(${IP//./ }); echo "${A[3]}.${A[2]}.${A[1]}.${A[0]}"
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

http://sourceforge.net/projects/console/



