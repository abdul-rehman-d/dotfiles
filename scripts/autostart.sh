#!/bin/bash

picom -c &
nitrogen --restore &
nm-applet &
blueman-applet &
volumeicon &
flameshot &
copyq &
xss-lock --transfer-sleep-lock -- i3lock -i $HOME/dotfiles/assets/lock-screen.png --nofork &

