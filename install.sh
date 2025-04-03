#!/bin/bash


echo "#########################"
echo "## Dotfiles Installer ##"
echo "#########################"

echo "All arguments: $@"
if [[ "$1" == "--cli-only" ]]; then
	echo "Running in CLI only mode. Skipping GUI setup."
else
	echo "Running in full mode. Setting up GUI as well."
fi
exit 0

echo ""
echo "################### UPDATE SYSTEM ###################"
sudo apt update
sudo apt upgrade -y

echo ""
echo "################### INSTALLING DEPENDENCIES ###################"
sudo apt install git -y

echo ""
echo "################### CLONING DOTFILES ###################"
git clone https://github.com/abdul-rehman-d/dotfiles.git ~/dotfiles

mkdir -p ~/.config

echo ""
echo "################### SETTING UP CLI SOFTWARE ###################"
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

if [[ "$1" != "--cli-only" ]]; then
	echo "################### SETTING UP GUI SOFTWARE ###################"
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
fi
