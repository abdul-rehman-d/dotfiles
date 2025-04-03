#!/bin/bash

sudo apt install fzf -y

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz -C $HOME/
mv $HOME/nvim-linux-x86_64 $HOME/.nvim
rm nvim-linux-x86_64.tar.gz

ln -s $HOME/dotfiles/nvim $HOME/.config/nvim
