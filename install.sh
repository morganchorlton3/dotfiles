#!/bin/bash

# Hide "last login" line when starting a new terminal session
touch $HOME/.hushlogin

# Install zsh
echo 'Install oh-my-zsh'
echo '-----------------'
rm -rf $HOME/.oh-my-zsh
curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Add global gitignore
ln -s $HOME/.dotfiles/shell/.global-gitignore $HOME/.global-gitignore
ln -s $HOME/.dotfiles/shell/.gitconfig $HOME/.gitconfig
git config --global core.excludesfile $HOME/.global-gitignore



# Symlink zsh prefs
rm $HOME/.zshrc
ln -s $HOME/.dotfiles/shell/.zshrc $HOME/.zshrc


# Activate zsh
cd ~/.dotfiles/shell
chmod +x z.sh
