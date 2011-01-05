# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# source ~/git-completion.bash

export PS1='
\[\033[32m\]\u@\h \[\033[33m\w$(__git_ps1)\033[0m\]
$ '


alias ui='cd /c/Code/yoga/web'
alias web='cd /c/Code/github/lauriro.github.com'

alias ssh-add='ssh-agent >~/ssh-agent-pid; source ~/ssh-agent-pid; ssh-add'
alias runphp='/c/Arhiiv/php-5.2.6-Win32/php-cgi.exe -b 127.0.0.1:9000 &'
