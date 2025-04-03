#!/bin/bash

sudo apt install i3 i3status -y

ln -s $HOME/dotfiles/i3 $HOME/.config/i3
ln -s $HOME/dotfiles/i3status $HOME/.config/i3status
