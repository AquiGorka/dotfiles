#!/bin/bash
set -euo pipefail

# Ask for the administrator password upfront and keep it alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done 2>/dev/null &

# homebrew
if [[ ! $(which brew) ]]; then
  echo "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> "$HOME/.zprofile"
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
curl -fsSL https://bun.sh/install | bash
