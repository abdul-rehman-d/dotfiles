#!/bin/bash

sudo apt update
sudo apt upgrade -y

sudo apt install git curl -y

git clone https://github.com/abdul-rehman-d/dotfiles.git ~/dotfiles

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
	echo "Running GUI setup"
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
