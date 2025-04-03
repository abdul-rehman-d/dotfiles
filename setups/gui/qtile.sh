#!/bin/bash

sudo apt install xserver-xorg xinit
sudo apt install libpangocairo-1.0-0
sudo apt install python3-pip python3-xcffib python3-cairocffi

pip install qtile

ln -s $HOME/dotfiles/qtile $HOME/.config/qtile
