# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Theme
ZSH_THEME="spaceship"

# ZSH Plugins
#plugins=(git aws terraform python zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting tmux)
plugins=(git aws terraform python tmux zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Load the shell dotfiles
for file in ~/.dotfiles/shell/.{exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

export NVM_DIR=~/.nvm
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# 1Password ssh
alias ssh='ssh.exe'
alias ssh-add='ssh-add.exe'

alias python="python3"


# To open browser links from wsl
export BROWSER=/usr/bin/wslview

# Homebrew
export BREW_HOME="/home/linuxbrew/.linuxbrew/bin"
export PATH="$PATH:$BREW_HOME"

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Created by `pipx` on 2024-06-06 11:42:15
export PATH="$PATH:/home/morgan/.local/bin"
export PATH="$HOME/.local/bin:$PATH"


# bun completions
[ -s "/home/morgan/.bun/_bun" ] && source "/home/morgan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#eval "$(starship init zsh)"
