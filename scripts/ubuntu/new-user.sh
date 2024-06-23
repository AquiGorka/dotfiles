#!/bin/bash

# omz
if [ ! -d ~/.oh-my-zsh ]; then
  echo "- Installing omz"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# kitty theme
if [ ! -d ~/.config/kitty/nord-kitty ]; then
  mkdir -p ~/.config/kitty
  git clone https://github.com/connorholyday/nord-kitty ~/.config/kitty/nord-kitty
fi

# tmux tpm
  # run tmux then
  # Press prefix + I (capital i, as in Install) to fetch the plugins
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# symlink
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/zshrc.linux ~/.zshrc.linux
rm ~/.tmux.conf
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore.global ~/.gitignore.global
ln -sf ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
if [ ! -d ~/.vim/tmp ]; then
  mkdir -p ~/.vim/tmp
fi
ln -sf ~/dotfiles/vimrc ~/.vimrc

# vim
if [ ! -d ~/.vim/autoload/plug.vim ]; then
  # plugin manager
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  # tmp
  if [ ! -d ~/.vim/tmp ]; then
    mkdir ~/.vim/tmp
  fi
  # install plugins
  vim +PlugInstall +qall
fi

# nvm
if [ ! -d ~/.nvm ]; then
  echo "- Installing nvm "
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.7/install.sh | bash
fi

# zsh
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
  # add to list of shells
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  # default
  chsh -s $(which zsh)
  # voilá
  zsh
fi
