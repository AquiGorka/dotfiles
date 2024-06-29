#!/bin/bash

sudo apt update

# tools
sudo apt install -y \
  tmux \
  zsh \
  tree \
  ripgrep \
  fzf \
  vim \
  fd-find \
  kitty \
  golang-go

if [ ! -d ~/.oh-my-zsh ]; then
  echo "- Installing omz"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# docker
if [[ ! $(which docker) ]]; then
  echo "- Installing docker"
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh ./get-docker.sh
fi
