#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# helpers
check_install() {
  if [[ ! $(which $@) ]]; then
    echo "Installing $@"
    brew install $@
  fi
}

# omz
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# homebrew
if [[ ! $(which brew) ]]; then
  echo "Installing hombrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/gorka/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# cli tools
check_install httpie
check_install tmux
check_install zsh
check_install tree
check_install go
check_install ripgrep
check_install fzf

# brew
brew install vim
brew install rectangle
brew install webtorrent
brew install karabiner-elements
brew install alfred
brew install slack
brew install gifcapture
brew install firefox
brew install docker
brew install visual-studio-code
brew install kitty
brew install fd
brew install bat
brew install trash
brew install switchaudio-osx
