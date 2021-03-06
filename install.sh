#!/usr/bin/env bash

sudo apt install -y code zsh tmux nginx maim rg xclip
sudo apt-get install ripgrep
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
curl -sL https://j.mp/glab-cli | sudo sh

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# plugins=(z zsh-autosuggestions zsh-syntax-highlighting fzf-zsh-plugin)
# to set vscode as default editor
git config --global core.editor "code --wait"