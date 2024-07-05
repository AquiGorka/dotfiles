#!/bin/bash

sudo yay -Suy

# tools
sudo pacman -S zsh
sudo pacman -S tmux
sudo pacman -S tree
sudo pacman -S ripgrep
sudo pacman -S fzf
sudo pacman -S vim
sudo pacman -S fd-find
sudo pacman -S kitty
sudo pacman -S docker

if [ ! -d ~/.oh-my-zsh ]; then
  echo "- Installing omz"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

sudo systemctl start docker.service
sudo systemctl enable docker.service
