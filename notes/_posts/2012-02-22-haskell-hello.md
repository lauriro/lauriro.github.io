---
layout: post
title: Haskell Notes
summary: Write a Hello World Haskell Program
tags: [haskell]
css:
- /css/pygments.css
- /css/gist.css
---

Hello World
-----------

$ vim hello.hs

-- This is a comment
main = putStrLn "Hello World!"

$ ghc -o hello hello.hs
$ ./hello
Hello World!

