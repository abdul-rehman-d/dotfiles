#!/bin/bash

sudo apt install fzf wget -y

# Install neovim
wget https://github.com/neovim/neovim/releases/download/v0.11.0/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86-64.tar.gz -C $HOME/
mv $HOME/nvim-linux-x86_64 $HOME/.nvim

ln -s $HOME/dotfiles/nvim $HOME/.config/nvim
