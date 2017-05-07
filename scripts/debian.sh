#!/bin/bash
# Setup script for debian based systems
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/AquiGorka/dotfiles/master/scripts/debian.sh)"
# source ./debian.sh
# chmod +x debian.sh && ./debian.sh

# helpers
check_install() {
  if [[ ! $(which $@) ]]; then
    echo "Installing $@"
    apt-get install $@ -y
  fi
}
# ---

# asume bare bones box
apt-get update

# if needed ask right away
check_install sudo
if [[ $(which sudo) ]]; then
  sudo -v
fi

# dependencies
check_install curl
check_install git
check_install python
check_install zsh
check_install vim

# oh-my-zsh
if [[ ! -d ~/.oh-my-zsh/ ]]; then
  echo "Installing Oh My Zsh"
  sh -c "$(curl -kfsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# dotfiles
if [[ ! -d $(pwd)/dotfiles ]]; then
  git clone https://github.com/AquiGorka/dotfiles
fi
./dotfiles/install

# zsh default shell
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
  chsh -s $(which zsh)
fi

# voilá
zsh
