#!/bin/bash

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

# Spaceship
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

mkdir ~/.config
ln -s $HOME/.dotfiles/shell/spaceship.zsh $HOME/.config/spaceship.zsh

# Activate zsh
cd ~/.dotfiles/shell
chmod +x z.sh

# To open browser links from wsl
sudo apt install wslu