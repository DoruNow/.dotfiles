#!/usr/bin/env bash

sudo apt install curl zsh tmux nginx ripgrep xclip -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
curl -sL https://j.mp/glab-cli | sudo sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# plugins=(z zsh-autosuggestions zsh-syntax-highlighting)
# to set vscode as default editor

git config --global core.editor "code --wait"

# git config user.name doru
# git config user.email doru.dev.now@gmail.com

# git config --global user.name doru
# git config --global user.email teodor@softwear.nl

# make tmux use zsh
echo "set-option -g default-shell /bin/zsh" > ~/.tmux.conf

# set audio output default
# List all outputs
# pactl list short sinks
# Example set:
# pactl set-default-sink alsa_output.pci-0000_00_1f.3.analog-stereo