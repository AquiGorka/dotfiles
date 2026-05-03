#!/bin/bash
set -euo pipefail

# Ask for the administrator password upfront and keep it alive
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done 2>/dev/null &

# homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -x /opt/homebrew/bin/brew ]; then
    BREW_PREFIX=/opt/homebrew
  else
    BREW_PREFIX=/usr/local
  fi
  (echo; echo "eval \"\$($BREW_PREFIX/bin/brew shellenv)\"") >> "$HOME/.zprofile"
  eval "$($BREW_PREFIX/bin/brew shellenv)"
fi

# omz
if [ ! -d ~/.oh-my-zsh ]; then
  echo "- Installing omz"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# formulae
brew install \
  bat \
  fd \
  fzf \
  gh \
  go \
  httpie \
  ripgrep \
  switchaudio-osx \
  tmux \
  trash \
  tree \
  vim \
  zsh

# casks
brew install --cask \
  alfred \
  firefox \
  gifcapture \
  karabiner-elements \
  kitty \
  rectangle \
  slack \
  visual-studio-code \
  webtorrent

# bun
curl -fsSL https://bun.sh/install | bash
