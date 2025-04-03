#!/bin/bash

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create symbolic links for easy access
mkdir -p "$HOME/.local/bin"
ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/bin/"
ln -sf "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/"

# Add Kitty to applications menu
mkdir -p "$HOME/.local/share/applications"
cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications/"

# Update the desktop entry to use the correct path
sed -i "s|Exec=kitty|Exec=$HOME/.local/kitty.app/bin/kitty|g" "$HOME/.local/share/applications/kitty.desktop"

# Ensure the desktop entry is available in the system menu
update-desktop-database "$HOME/.local/share/applications"

ln -s $HOME/dotfiles/kitty $HOME/.config/kitty
