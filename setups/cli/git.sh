#!/bin/bash

echo "Enter your personal email:"
read personal_email

echo "Enter your work email:"
read work_email

ssh-keygen -t rsa -b 4096 -C "$personal_email" -f "$HOME/.ssh/git-personal" -N ""

ssh-keygen -t rsa -b 4096 -C "$work_email" -f "$HOME/.ssh/git-work" -N ""

# symlinks
ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig
ln -s $HOME/dotfiles/gitconfig-work $HOME/.gitconfig-work

