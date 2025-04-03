#!/bin/bash

sudo apt install -y xserver-xorg xinit
sudo apt install -y libpangocairo-1.0-0
sudo apt install -y python3-pip python3-xcffib python3-cairocffi

sudo apt install -y flameshot feh copyq

sudo pip install qtile --break-system-packages

ln -s $HOME/dotfiles/qtile $HOME/.config/qtile
sudo cp $HOME/dotfiles/qtile/qtile.desktop /usr/share/xsessions/
