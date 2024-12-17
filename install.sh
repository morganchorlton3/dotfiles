#!/bin/bash

print_colored_text() {
    local text="$1"    # The text to print
    local color="$2"   # The color code
    local divider="$3" # Optional divider flag (empty or "yes")

    # Print a new line or divider before text if requested
    if [[ "$divider" == "yes" ]]; then
        echo -e "\n"  # Divider (can customize as needed)
    fi

    # ANSI escape codes for colors
    case $color in
        "black") echo -e "\033[30m$text\033[0m" ;;
        "red") echo -e "\033[31m$text\033[0m" ;;
        "green") echo -e "\033[32m$text\033[0m" ;;
        "yellow") echo -e "\033[33m$text\033[0m" ;;
        "blue") echo -e "\033[34m$text\033[0m" ;;
        "magenta") echo -e "\033[35m$text\033[0m" ;;
        "cyan") echo -e "\033[36m$text\033[0m" ;;
        "white") echo -e "\033[37m$text\033[0m" ;;
        "bold_red") echo -e "\033[1;31m$text\033[0m" ;;
        "bold_blue") echo -e "\033[1;34m$text\033[0m" ;;
        *) echo -e "\033[0m$text" ;;  # Default (no color)
    esac

    if [[ "$divider" == "yes" ]]; then
        echo -e "\n"  # Divider (can customize as needed)
    fi
}
# Install zsh
echo 'Install oh-my-zsh'
echo '-----------------'
rm -rf $HOME/.oh-my-zsh
curl -L https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# Add global gitignore
ln -s $HOME/personal/dotfiles/shell/.global-gitignore $HOME/.global-gitignore
ln -s $HOME/personal/dotfiles/shell/.gitconfig $HOME/.gitconfig
git config --global core.excludesfile $HOME/.global-gitignore

# Symlink zsh prefs
rm $HOME/.zshrc
ln -s $HOME/personal/dotfiles/shell/.zshrc $HOME/.zshrc

# Spaceship
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

mkdir ~/.config
ln -s $HOME/personal/dotfiles/shell/config/spaceship.zsh $HOME/.config/spaceship.zsh

mkdir ~/.config/pypoetry
ln -s $HOME/personal/dotfiles/shell/config/pypoerty_config.toml $HOME/.config/pypoetry/config.toml

# Activate zsh
cd ~/personal/dotfiles/shell
chmod +x z.sh

# ZSH extensions
## autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

## Spaceship
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# To open browser links from wsl
sudo add-apt-repository -y ppa:wslutilities/wslu
sudo apt install wslu


read -p "Do you want to install software (Python3.13, terraform, AWS CLI)? (y/n): " answer

# Check the user's input
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
  sudo apt update
  sudo apt upgrade -y
  
  #Python (poetry)
  print_colored_text "Installing Python3.13" "bold_blue" "yes"
  sudo add-apt-repository -y ppa:deadsnakes/ppa
  sudo apt install python3.13


  print_colored_text "Installing Poetry" "bold_blue" "yes"
  curl -sSL https://install.python-poetry.org | python3 -

  #NVM
  print_colored_text "Installing NVM (Node Version Manager)" "bold_blue" "yes"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

  # AWS CLI
  print_colored_text "Installing AWS CLI" "bold_blue" "yes"
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  sudo apt install unzip
  unzip awscliv2.zip
  sudo ./aws/install
  rm awscliv2.zip
  rm -r ./aws

  # Terraform
  print_colored_text "Installing Terraform" "bold_blue" "yes"
  sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
  wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
  gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update
  sudo apt-get install terraform

  print_colored_text "Installing Docker" "bold_blue" "yes"
  sudo apt-get update
  sudo apt-get install -y ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
  sudo usermod -aG docker $USER
  newgrp docker

  # Add the repository to Apt sources:
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update

  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  print_colored_text "Installing brew" "bold_blue" "yes"
  NONINTERACTIVE=1 DEBIAN_FRONTEND=noninteractive /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  print_colored_text "Installing Lazydocker" "bold_blue" "yes"
  brew install jesseduffield/lazydocker/lazydocker

else
    echo "Not Instaling software"
fi