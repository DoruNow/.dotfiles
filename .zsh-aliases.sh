#!/bin/zsh

alias aliases-config="code ~/.dotfiles/.zsh-aliases.sh"
alias functions-config="code ~/.dotfiles/.zsh-functions.sh"
alias git-config="code ~/.dotfiles/.gitconfig.sh"

# log into cabana droplet with secondary ssh key
alias remotecab="ssh -i ~/.ssh/id2_rsa.pub root@134.122.53.64"
alias copy="xclip -sel clip"
alias check="git difftool master"
alias act="source /home/doru/dev/spynl.app/.venv/bin/activate"
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
alias tail-test="tail -f /home/doru/Desktop/test-log"
alias source-all="for f in /home/doru/.dotfiles/*.sh; do source $f; done"
alias fix="npm run lint --fix"

