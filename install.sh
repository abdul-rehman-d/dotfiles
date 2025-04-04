#!/bin/bash

set -e

echo -e "\e[44m########################\e[0m"
echo -e "\e[44m## Dotfiles Installer ##\e[0m"
echo -e "\e[44m########################\e[0m"

echo ""
echo -e "\e[44m################### UPDATE SYSTEM ###################\e[0m"
sudo apt update
sudo apt upgrade -y

echo ""
echo -e "\e[44m################### INSTALLING DEPENDENCIES ###################\e[0m"
sudo apt install git -y

echo ""
echo -e "\e[44m################### CLONING DOTFILES ###################\e[0m"
git clone https://github.com/abdul-rehman-d/dotfiles.git ~/dotfiles

mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/dev
mkdir -p ~/dev/personal/
mkdir -p ~/dev/work/

echo "If you want to setup ssh keys for github, please enter personal and/or work email addresses."
read -p "Personal Github email: " personal_email
read -p "Personal Github ssh passcode: " personal_passcode
read -p "Work email: " work_email
read -p "Work Github ssh passcode: " work_passcode
read -p "Name: " name

export PERSONAL_EMAIL=$personal_email
export PERSONAL_PASSPHRASE=$personal_passcode
export WORK_EMAIL=$work_email
export WORK_PASSPHRASE=$work_passcode
export NAME=$name

echo ""
echo -e "\e[44m################### SETTING UP CLI SOFTWARE ###################\e[0m"
# iterate over ~/dotfiles/setups/cli/
for file in ~/dotfiles/setups/cli/*; do
	# check if file is a script
	if [[ -f $file ]]; then
	    # check if file is executable
	    if [[ -x $file ]]; then
		# run the script
		echo "Running $file"
		bash "$file"
	    fi
	fi
done

echo ""
echo -e "\e[44m################### SETTING UP GUI SOFTWARE ###################\e[0m"
# iterate over ~/dotfiles/setups/gui/
for file in ~/dotfiles/setups/gui/*; do
	# check if file is a script
	if [[ -f $file ]]; then
	    # check if file is executable
	    if [[ -x $file ]]; then
		# run the script
		echo "Running $file"
		bash "$file"
	    fi
	fi
done

echo ""
echo -e "\e[44m################### DONE ###################\e[0m"
echo "Next Step: "
echo "1. Add SSH keys to Github (~/.ssh/git-personal.pub and ~/ssh/git-work.pub)"
echo "2. Reboot the system and select the Qtile session from the login screen."
