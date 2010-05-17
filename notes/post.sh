#!/bin/bash
# Author: Lauri Rooden <lauri@neti.ee>

echo -n "Please provide a post title: "
read title

# typeset -l filename=$title
filename="`echo -n "${title}" | tr 'A-Z' 'a-z'`"
filename=${filename//õ/o}
filename=${filename//Õ/o}
filename=${filename//ä/a}
filename=${filename//Ä/a}
filename=${filename//ö/o}
filename=${filename//Ö/o}
filename=${filename//ü/u}
filename=${filename//[^a-z0-9]/-}
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

