#!/bin/bash

echo $PERSONAL_EMAIL
echo $PERSONAL_PASSPHRASE
echo $WORK_EMAIL
echo $WORK_PASSPHRASE
echo $NAME

if [[ -n $PERSONAL_EMAIL ]]; then
	ssh-keygen -t rsa -b 4096 -C "$PERSONAL_EMAIL" -f "$HOME/.ssh/git-personal" -N "$PERSONAL_PASSPHRASE"

	cp $HOME/dotfiles/gitconfig $HOME/.gitconfig

	sed -i "s/<github-email-here>/${PERSONAL_EMAIL}/g" $HOME/.gitconfig
	sed -i "s/<github-name-here>/${NAME}/g" $HOME/.gitconfig
fi

if [[ -n $WORK_EMAIL ]]; then
	ssh-keygen -t rsa -b 4096 -C ${WORK_EMAIL} -f "$HOME/.ssh/git-work" -N "$WORK_PASSPHRASE"

	cp $HOME/dotfiles/gitconfig-work $HOME/.gitconfig-work

	sed -i "s/<github-work-email-here>/${WORK_EMAIL}/g" $HOME/.gitconfig-work
	sed -i "s/<github-name-here>/${NAME}/g" $HOME/.gitconfig-work
fi

