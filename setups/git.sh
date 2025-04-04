#!/bin/bash

read -p "Do you want to setup SSH keys for Github? (Y/n) " choice </dev/tty
choice=${choice:-Y}

if [[ ! "$choice" =~ ^[Yy]$ ]]; then
    echo "Aborted setting up git configs"
    exit 0
fi

read -p "Personal Github email: " personal_email </dev/tty
read -p "Personal Github ssh passcode: " personal_passcode </dev/tty
read -p "Work email: " work_email </dev/tty
read -p "Work Github ssh passcode: " work_passcode </dev/tty
read -p "Name: " name </dev/tty


if [[ -n $personal_email ]]; then
	if [[ -f "$HOME/.ssh/git-personal.pub" && "$(tail -n1 $HOME/.ssh/git-personal.pub | awk '{print $NF}')" == $personal_email ]]; then
		echo "SSH key already exists for $personal_email"
	else
		ssh-keygen -t rsa -b 4096 -C "$personal_email" -f "$HOME/.ssh/git-personal" -N "$personal_passcode"
	fi

	cp $HOME/dotfiles/gitconfig $HOME/.gitconfig

	sed -i "s/<github-email-here>/${personal_email}/g" $HOME/.gitconfig
	sed -i "s/<github-name-here>/${name}/g" $HOME/.gitconfig

	echo -e "\e[31mAdd the following SSH key to your personal Github account:\e[0m"
	cat $HOME/.ssh/git-personal.pub
fi

if [[ -n $work_email ]]; then
	if [[ -f "$HOME/.ssh/git-work.pub" && "$(tail -n1 $HOME/.ssh/git-work.pub | awk '{print $NF}')" == $work_email ]]; then
		echo "SSH key already exists for $work_email"
	else
		ssh-keygen -t rsa -b 4096 -C "$work_email" -f "$HOME/.ssh/git-work" -N "$work_passcode"
	fi

	cp $HOME/dotfiles/gitconfig-work $HOME/.gitconfig-work

	sed -i "s/<github-work-email-here>/${work_email}/g" $HOME/.gitconfig-work
	sed -i "s/<github-name-here>/${name}/g" $HOME/.gitconfig-work

	echo -e "\e[31mAdd the following SSH key to your work Github account:\e[0m"
	cat $HOME/.ssh/git-work.pub
fi

