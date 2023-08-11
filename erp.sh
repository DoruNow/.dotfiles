#!/bin/zsh

code ~/dev/erp8
tmux new-session -d -s erp \; \
send-keys 'cd ~/dev/erp8 && npm run serve' C-m \; \
split-window -v \; \
select-pane -t 1 \; \
send-keys 'cd ~/dev/latest-collection-server && npm run build && npm run e2e' C-m \;
