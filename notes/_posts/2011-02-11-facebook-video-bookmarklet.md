---
layout: post
published: true
title: Facebook video bookmarklet
summary: How to download video from Facebook
tags: [facebook, video, bookmarklet]
time: "22:38"
---

## Facebook video bookmarklet

How to download video from Facebook

### ver1

- Open video in Facebook
- paste into addressbar: javascript:window.location=unescape(window["swf_" + document.querySelector("#player>div").id].variables.video_src)
- Hit Enter and Ctrl+S to save.

### ver2

- Drag [FB video][fb-video] bookmarklet to your bookmarks bar. (On Internet Explorer, you can right-click and select "Add to Favorites".)
- Open video in Facebook
- Click bookmarks and Ctrl+S to save.

[fb-video]: javascript:window.location=unescape(window["swf_"+document.querySelector("#player>div").id].variables.video_src)

