#!/bin/bash
#
# bootstrap installs things.

function bootstrapTerminal() {	
	sudo -v #ask password beforehand
	source ~/personal/dotfiles/install.sh
}


echo 'Bootstrap terminal'
echo '------------------'
echo 'This will reset your terminal. Are you sure you want to do this? (y/n) '
read -p 'Answer: '  reply

if [[ $reply =~ ^[Yy]$ ]]
then
   bootstrapTerminal
fi