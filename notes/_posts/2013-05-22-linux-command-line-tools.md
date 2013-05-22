---
layout: post
published: true
title: Linux command line tools
summary:
tags: [shell, uniq, date]
time: "13:44"
---

## Linux command line tools


### uniq

{% highlight bash %}
sort a b | uniq             # union - items in either a or b
sort a b | uniq -d          # intersection - items both in a and b
sort a a b | uniq -u        # difference - items in b not in a
sort a b | uniq -u          # symmetric difference - items in only one file

cat a b | sort | uniq       # a union b
cat a b | sort | uniq -d    # a intersect b
cat a b b | sort | uniq -u  # difference a – b
cat a b | sort | uniq -u    # symmetric difference

join -t'\0' -a1 -a2 a b     # union of sorted files
join -t'\0' a b             # intersection of sorted files
join -t'\0' -v2 a b         # difference of sorted files
join -t'\0' -v1 -v2 a b     # symmetric difference of sorted files
{% endhighlight %}


### Date

{% highlight bash %}
date --date='25 Dec' +%A    # what day does xmas fall on, this year
date --date='@2147483647'   # convert seconds since the epoch to date
{% endhighlight %}


