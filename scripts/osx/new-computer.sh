#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# homebrew
if [[ ! $(which brew) ]]; then
  echo "Installing hombrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/gorka/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# omz
if [ ! -d ~/.oh-my-zsh ]; then
  echo "- Installing omz"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# brew
brew install httpie
brew install tmux
brew install zsh
brew install tree
brew install go
brew install ripgrep
brew install fzf
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
curl -fsSL https://bun.com/install | bash
