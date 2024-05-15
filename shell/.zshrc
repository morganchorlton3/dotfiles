# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="robbyrussell"

# ZSH Plugins
plugins=(git aws terraform laravel)

source $ZSH/oh-my-zsh.sh

# Load the shell dotfiles
for file in ~/.dotfiles/shell/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

export NVM_DIR=~/.nvm
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
