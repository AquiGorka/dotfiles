#!/bin/bash
# local setup for user
# assumes users.sh has been executed
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/AquiGorka/dotfiles/master/scripts/osx/local.sh)"

# dotfiles
if [[ ! -d ~/dotfiles ]]; then
  # clone
  git clone https://github.com/AquiGorka/dotfiles ~/dotfiles
  # execute permissions for dotfiles/bin
  chmod +x `find ~/dotfiles/bin -type f`
  # symlink
  ~/dotfiles/symlink
fi

# Dock
  # manually set min, max and magnification

# chrome
  # offer to save passwords: no

# chrome extensions
  # no way to do this automatically
  # https://blog.chromium.org/2015/05/continuing-to-protect-chrome-users-from.html
  # manually install:
    # jsonview: https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc/related?hl=en
    # momemtum: https://chrome.google.com/webstore/detail/momentum/laookkfknpbbblfpciffpaejjkokdgca
    # supergenpass: https://chriszarate.github.io/supergenpass/
    # grammarly: https://chrome.google.com/webstore/detail/grammarly-for-chrome/kbfnbcaeplbcioakkpcpgfkobkghlhen/related?hl=en

# shiftit
  # manually check start on login

# karabiner-elements
  # research on adding karabiner.json to dotfiles and symlink
  # in the meantime, manually:
  # caps_lock to control
  # right_command to delete_forward

# alfred
  # manually:
  # disable spotlight shortcut
  # frosty teal theme
  # theme options
    # hide hat
    # hide result shortcuts
    # hide menu bar icon
    # 7 results
    # save position when dragging

# vim
  # plugin manager
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  # tmp
  mkdir ~/.vim/tmp
  # install plugins
  vim +PlugInstall +qall

# zsh
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
  # add to list of shells
  sudo sh -c "echo $(which zsh) >> /etc/shells"
  # default
  chsh -s $(which zsh)
  # voilá
  zsh
fi

