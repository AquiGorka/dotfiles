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

# dotfiles
if [[ ! -d $(pwd)/dotfiles ]]; then
  git clone https://github.com/AquiGorka/dotfiles
fi

# execute permissions for dotfiles/bin
chmod +x `find $(pwd)/dotfiles/bin -type f`

# symlinks
./dotfiles/symlink

# zsh default shell
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
  chsh -s $(which zsh)
fi

# voilá
zsh
