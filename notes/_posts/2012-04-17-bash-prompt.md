---
layout: post
title: Bash prompt
summary: How to setup bash custom prompt (PS1)
tags: [bash]
css:
- /css/pygments.css
---

Paste to the end of your ~/.bashrc file

```bash
export PS1='\n\[\e[32m\]\t \u@\h \[\e[33m\w$(__git_ps1)\e[0m\]\n\$ '
ps1_time() {
	printf "\033[s\033[2A\033[32m%s\033[0m\033[u" $(date +%H:%M:%S);
}
export PROMPT_COMMAND="trap 'ps1_time; trap DEBUG' DEBUG"

```


Fix for long lines

```bash
ps1_time() {
	local s=1 c IFS=$'\n'
	for c in $BASH_COMMAND; do s=$((${#c}/$COLUMNS+1+$s)); done
	printf "\033[s\033[${s}A\033[32m%s\033[0m\033[u" $(date +%H:%M:%S);
}
export PS1='\n\[\e[32m\]\t \u@\h \[\e[33m\w$(__git_ps1)\e[0m\]\n\$ '
export PROMPT_COMMAND="trap 'ps1_time; trap DEBUG' DEBUG"
```
