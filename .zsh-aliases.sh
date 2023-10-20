#!/bin/zsh

alias aliases_config="code ~/.dotfiles/.zsh-aliases.sh"
alias functions_config="code ~/.dotfiles/.zsh-functions.sh"
alias git_config="code ~/.dotfiles/.gitconfig.sh"
alias dot="code -a ~/.dotfiles"
# log into cabana droplet with secondary ssh key
alias remotecab="ssh -i ~/.ssh/id2_rsa.pub root@134.122.53.64"
alias copy="xclip -sel clip"
alias screenshot="maim -s | xclip -selection clipboard -t image/png"
alias poza="maim -s | xclip -selection clipboard -t image/png"
alias check="git difftool master"
alias act="source /home/doru/dev/spynl.app/.venv/bin/activate"
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"
alias tail-test="tail -f /home/doru/Desktop/test-log"
alias source-all="for f in /home/doru/.dotfiles/*.sh; do source $f; done"
alias fix="npm run lint --fix"
alias serve="npm run serve"
alias start="npm run start"
alias rg="rg -g '!dist/' -g '!package-lock.json'"
alias uu="sudo apt-get update && sudo apt-get upgrade -y"
alias edge="ssh -i ~/.ssh/ssh-edge.pub ec2-user@ec2-34-247-217-161.eu-west-1.compute.amazonaws.com"

