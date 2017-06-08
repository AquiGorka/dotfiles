#!/bin/bash
# Setup script for macos based systems
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/AquiGorka/dotfiles/master/scripts/macos.sh)"
# chmod +x dotfiles/scripts/macos.sh && ./dotfiles/scripts/macos.sh

# helpers
check_install() {
  if [[ ! $(which $@) ]]; then
    echo "Installing $@"
    brew install $@
  fi
}
# ---

# homebrew
if [[ ! $(which brew) ]]; then
  echo "Installing hombrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# dependencies
# httpie bin is http
if [[ ! $(which http) ]]; then
  echo "Installing httpie"
  brew install httpie
fi
# the rest
check_install python
check_install git
check_install node
check_install yarn
check_install python3
check_install node
check_install iterm2 
check_install tmux
check_install vim
check_install fortune
check_install zsh
check_install tree
check_install go
check_install hugo
check_install unrar

# dotfiles
if [[ ! -d ~/dotfiles ]]; then
  git clone https://github.com/AquiGorka/dotfiles ~/dotfiles
fi

# execute permissions for dotfiles/bin
chmod +x `find ~/dotfiles/bin -type f`

# symlinks
~/dotfiles/symlink

# zsh default shell
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then

  # zsh to list of shells
  sudo sh -c "echo $(which zsh) >> /etc/shells"

  # default
  chsh -s $(which zsh)
  
  # voilá
  zsh
fi

