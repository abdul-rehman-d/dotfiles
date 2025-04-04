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
echo -e "\e[44m################### GIT & GITHUB SSH KEYS ###################\e[0m"

bash ~/dotfiles/setups/git.sh

echo ""
echo -e "\e[44m################### DONE ###################\e[0m"
echo "Next Step: "
echo "1. Reboot the system and select the Qtile session from the login screen."
