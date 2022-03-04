#!/bin/bash
# setup for all users
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/AquiGorka/dotfiles/master/scripts/osx/users.sh)"

# helpers
check_install() {
  if [[ ! $(which $@) ]]; then
    echo "Installing $@"
    brew install $@
  fi
}

# homebrew
if [[ ! $(which brew) ]]; then
  echo "Installing hombrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# dependencies
check_install httpie
check_install tmux
check_install vim
check_install zsh
check_install tree
check_install go
check_install ripgrep
check_install fzf

# casks
brew install vlc --cask
brew install rectangle --cask
brew install webtorrent --cask
brew install karabiner-elements --cask
brew install alfred --cask
brew install slack --cask
brew install gifcapture --cask
brew install firefox --cask
brew install docker --cask
brew install visual-studio-code --cask
brew install kitty --cask
