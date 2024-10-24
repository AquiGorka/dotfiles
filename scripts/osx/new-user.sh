#!/bin/bash

# wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
# restart dock
killall Dock &> /dev/null

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
ln -sf ~/dotfiles/zshrc.macos ~/.zshrc.macos
rm ~/.tmux.conf
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore.global ~/.gitignore.global
if [ ! -d ~/.vim/tmp ]; then
  mkdir -p ~/.vim/tmp
fi
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/kitty.conf ~/.config/kitty

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

# Keyboard
  # input sources
    # add spanish iso to keyboard (manually)
    # git clone https://github.com/myshov/xkbswitch-macosx
    # ./xkbswitch-macosx/bin/xkbswitch -se Spanish-ISO

  # shortcuts (Keyboard)
    # move focus to next window (manually in shortcuts > keyboard)
    # https://apple.stackexchange.com/questions/280220/how-to-change-the-default-shortcut-for-move-focus-to-next-window-to-something

# Trackpad
  # tap to click

# Dock
  # manually set min, max and magnification
  # automatically hide and show the dock
  # show recent applications in dock

# Mission control
  # hot corners remove notes
  # top right notifications

# chrome
  # offer to save passwords: no
  # offer to translate: no
  # disable sync and automatic login
  # https://blog.ideasynthesis.com/2018/09/24/Disable-Google-Chrome-Sign-In-and-Sync/
  # defaults write com.google.Chrome SyncDisabled -bool true
  # defaults write com.google.Chrome RestrictSigninToPattern -string ".*@google.com"

# chrome extensions
  # no way to do this automatically
  # https://blog.chromium.org/2015/05/continuing-to-protect-chrome-users-from.html
  # manually install:
    # jsonview: https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc/related?hl=en
    # grammarly: https://chrome.google.com/webstore/detail/grammarly-for-chrome/kbfnbcaeplbcioakkpcpgfkobkghlhen/related?hl=en
    # whatfont: https://chrome.google.com/webstore/detail/whatfont/jabopobgcpjmedljpbcaablpmlmfcogm/related?hl=en

# karabiner-elements
  # research on adding karabiner.json to dotfiles and symlink
  # in the meantime, manually:
  # caps_lock to control
  # right_command to delete_forward

# alfred
  # manually:
  # disable spotlight shortcut search spotlight using spotlight > shortcuts
  # frosty teal theme
  # theme options
    # hide hat
    # hide result shortcuts
    # hide menu bar icon
    # 7 results
    # save position when dragging

# rectangle
  # Gaps between windows: 6px
  # TODO
  # it looks like the configs can be exported and imported
  # maybe add to dotfiles?
