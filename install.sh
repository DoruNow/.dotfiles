#!/usr/bin/env bash

sudo snap install --classic code
sudo apt install -y zsh tmux nginx
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
