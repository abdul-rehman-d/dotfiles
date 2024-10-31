#!/bin/bash

picom -c &
nitrogen --restore &
nm-applet &
blueman-applet &
volumeicon &
flameshot &
copyq &
xss-lock --transfer-sleep-lock -- i3lock -c "#282A36" --nofork &

