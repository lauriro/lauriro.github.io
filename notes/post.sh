#!/bin/bash
# Author: Lauri Rooden <lauri@neti.ee>

echo "Please provide a post title: "
read title

# typeset -l filename=$title
filename="`echo -n "${title}" | sed -e 's/[àâä]/a/ig' -e 's/[éèêë]/e/ig' -e 's/[îï]/i/ig' -e 's/[õö]/o/ig' -e 's/[ü]/u/ig' | tr 'A-Z' 'a-z' | tr -c '[a-z0-9]' '-' | sed -e 's/--*/-/g'`"
FILE="_posts/`date +%Y-%m-%d-`${filename}.textile"
TIME=`date +%H:%M`

cat >> ${FILE} << EOF
---
layout: post
published: true
title: ${title}
summary:
tags: []
time: "${TIME}"
---

h2. ${title}

EOF

edit ${FILE}



exit 0

