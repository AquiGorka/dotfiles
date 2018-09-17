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
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# dependencies
# httpie bin is http
if [[ ! $(which http) ]]; then
  echo "Installing httpie"
  brew install httpie
fi
# the rest
check_install node
check_install yarn
check_install tmux
check_install vim
check_install zsh
check_install tree
check_install go
check_install hugo
check_install unrar
check_install ripgrep
check_install git-flow
check_install blockstack

# casks
brew cask install google-chrome
brew cask install flux
brew cask install vlc
brew cask install shiftit
brew cask install webtorrent
brew cask install balsamiq-mockups
brew cask install karabiner-elements
brew cask install alfred
brew cask install slack
brew cask install gifcapture
brew cask install hyper
brew cask install firefox
brew cask install docker
brew cask install visual-studio-code
brew cask install keyase

# yarn
yarn global add prettier standard

