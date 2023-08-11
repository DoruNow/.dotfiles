#!/bin/zsh

# switch project
# assumes pathing, understands 6 / 7 as project args for v6/v7
sp() {
    local defaultFlag="r"
    local project=$1
    local flag=${2:-$defaultFlag}

    if [ $flag != 'a' ] && [ $flag != 'r' ] && [ $flag != 'n' ]
    then
      echo "Second argument can only be 'a' [add] / 'r' [replace:default] "
      return
    fi

    if [ $project = "6" ]
    then
      code -$flag ~/dev/softwear-development/v6
    elif [ $project = "7" ]
    then
      code -$flag ~/dev/softwear-development/v7
    elif [ $project = "8" ]
    then
      code -$flag ~/dev/erp/erp8
    elif [ $project = "sd" ]
    then
      code -$flag ~/dev/softwear-development
    else 
      if [ -d ~/dev/$project ]
      then
        code -$flag ~/dev/$project
      else 
        echo "Project $project does not exist"
      fi
    fi    
}

# Launches local stack v6 and v7
# assumes pathing
launch() {
    tmux new-session -d -s local-stack \; \
    send-keys 'z local_ && ./start-stack.sh' C-m \; \
    split-window -v \; \
    split-window -h \; \
    split-window -h \; \
    select-pane -t 1 \; \
    send-keys 'z 7 && npm run app' C-m \; \
    select-pane -t 2 \; \
    send-keys 'z 6 && npm run app:pos' C-m \; 
    sudo service nginx start
}

erp() {
    # if sudo lsof -i -P -n | grep -q 3000
    # then
    #     sudo lsof -i -P -n | grep 3000 | awk '{ print $2}' | xargs sudo kill -9 | > /dev/null
    # fi
    tmux new-session -d -s erp \; \
    send-keys 'cd ~/dev/erp8 && npm run serve' C-m \; \
    split-window -v \; \
    select-pane -t 1 \; \
    send-keys 'cd ~/dev/latest-collection-server && npm run build && npm run e2e' C-m \;
}

rr() {
    # assumes pathing and s7 runs in pane 0.1 as set by launch function
    tmux send-keys -t 0.1 "z 7 && npm run app" ENTER
}

test7() {
  : > ~/Desktop/test-log;
  echo -e "--------------- Started ---------------\n" >> ~/Desktop/test-log;
  tmux send-keys -t 0.3 "cd ~/dev/softwear-development/v7 && npm run --silent test | rg -A5 'LOG:| SUCCESS|should' | >> ~/Desktop/test-log" ENTER;
}

test6() {
  local flag=$1;
  legacy='';

  if [[ $flag == 'f' ]]
  then
    legacy=":legacy"
  fi

  : > ~/Desktop/test-log;
  echo -e "--------------- Started ---------------\n" >> ~/Desktop/test-log;
  tmux send-keys -t 0.3 "cd ~/dev/softwear-development/v6 && npm run --silent test$legacy | rg -A5 'LOG:| SUCCESS|should' | >> ~/Desktop/test-log" ENTER;
}

listen-to-tests() {
  tail -f /home/doru/Desktop/test-log | rg -A5 'should|--------------- Started ---------------|LOG:| SUCCESS';
}

plan() {
  code /home/doru/tm/planhabit;
  tmux new-session -d -s plan \; \
  send-keys 'z plan && code . && npm run serve' C-m \; \
  split-window -v \; \
  select-pane -t 1 \; \
  send-keys 'google-chrome' C-m \; \
}

gcbd() {
  typeset -u ticket;
  ticket=$1
  git checkout master && git checkout -b doru/$ticket && echo '--------SUCCESS--------'
}

gcod() {
  typeset -u ticket;
  ticket=$1
  git checkout doru/$ticket && echo '--------SUCCESS--------'
}

gcbl() {
  typeset -u ticketNumber;
  ticketNumber=$1
  git checkout master && git checkout -b doru/LAT-$ticketNumber && echo '--------SUCCESS--------'
}

gcol() {
  typeset -u ticketNumber;
  ticketNumber=$1
  git checkout doru/LAT-$ticketNumber && echo '--------SUCCESS--------'
}

# todo
# gli() {
#   git pull > pull && rg 'package.json' -- pull 
# }

connect-dot-files() {
  echo 'source ~/.dotfiles/.zsh-aliases.sh'>> ~/.zshrc
  echo 'source ~/.dotfiles/.gitconfig.sh'>> ~/.zshrc
  echo 'source ~/.dotfiles/.zsh-functions.sh'>> ~/.zshrc
}