---
layout: post
published: true
title: Git daemon
summary: Share your code.
tags: [git]
time: "14:56"
css:
- /css/pygments.css
---

## Git daemon

{% highlight bash %}
$ cd /code/test/repo
$ touch .git/git-daemon-export-ok
$ git daemon --base-path=/code --enable=receive-pack &
$ git clone git://localhost/test/repo
{% endhighlight %}



