#!/bin/bash

# Install zsh
sudo apt install zsh unzip -y

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# oh my posh prompt
curl -s https://ohmyposh.dev/install.sh | bash -s

rm $HOME/.zshrc
ln -s $HOME/dotfiles/zshrc $HOME/.zshrc

chsh -s $(which zsh)
