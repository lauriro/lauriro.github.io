---
layout: post
published: true
title: Pipe Viewer
summary:
tags: [shell]
time: "16:49"
---

## Pipe Viewer


{% highlight bash %}
$ wget -qO - "http://pipeviewer.googlecode.com/files/pv-1.2.0.tar.gz" | tar zxvf -   
$ cd pv-1.2.0/
$ ./configure
$ export DESTDIR=/cygdrive/c/cygwin
$ make
$ make install
{% endhighlight %}

