#!/bin/bash

get_rand_wallpaper() {
  num=$(ls -1 $HOME/dotfiles/wallpapers | wc -l)
  rand=$((1 + $RANDOM % $num))
  ls -1 $HOME/dotfiles/wallpapers | sed -n "${rand}p"
}


picom -c &
# nitrogen --restore &
feh --bg-fill $HOME/dotfiles/wallpapers/$(get_rand_wallpaper)
nm-applet &
blueman-applet &
flameshot &
copyq &
xss-lock --transfer-sleep-lock -- i3lock -i $HOME/dotfiles/assets/lock-screen.png --nofork &

