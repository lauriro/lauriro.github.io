---
layout: post
title: Install root certificates
summary: Curl guys extracted for you certificates from mozilla.
tags: [ssl, cygwin]
css:
- /css/pygments.css
- /css/gist.css
---


{% highlight bash %}
cd /usr/ssl/certs
curl http://curl.haxx.se/ca/cacert.pem | awk 'split_after==1{n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1} {print > "cert" n ".pem"}'
c_rehash
{% endhighlight %}

