#!/bin/bash
set -euo pipefail

# wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
# restart dock
killall Dock &> /dev/null

# omz
if [ ! -d ~/.oh-my-zsh ]; then
  echo "- Installing omz"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
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
if [ ! -d ~/dotfiles ]; then
  echo "Error: ~/dotfiles not found. Clone the dotfiles repo first."
  exit 1
fi
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/zshrc.macos ~/.zshrc.macos
rm -f ~/.tmux.conf
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/gitignore.global ~/.gitignore.global
mkdir -p ~/.vim/tmp
ln -sf ~/dotfiles/vimrc ~/.vimrc
mkdir -p ~/.config/kitty
ln -sf ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
mkdir -p ~/.config/karabiner
ln -sf ~/dotfiles/karabiner.json ~/.config/karabiner/karabiner.json

# vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
  # plugin manager
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  # install plugins
  vim +PlugInstall +qall
fi

# nvm
if [ ! -d ~/.nvm ]; then
  echo "- Installing nvm "
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
if ! nvm ls node &>/dev/null; then
  nvm install node
fi
nvm use node

# zsh
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
  # add to list of shells (only if not already present)
  if ! grep -qxF "$(which zsh)" /etc/shells; then
    sudo sh -c "echo $(which zsh) >> /etc/shells"
  fi
  # default
  chsh -s $(which zsh)
  echo "Default shell set to $(which zsh). Open a new terminal to start using it."
fi

# Keyboard
  # input sources (logout/login required to activate)
  # Spanish-ISO (Keyboard Layout)
  if ! defaults read com.apple.HIToolbox AppleEnabledInputSources 2>/dev/null | grep -q "Spanish - ISO"; then
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
      '{"InputSourceKind" = "Keyboard Layout"; "KeyboardLayout ID" = 173; "KeyboardLayout Name" = "Spanish - ISO";}'
    echo "Added Spanish-ISO keyboard layout"
  fi
  # Mandarin Pinyin Simplified (Input Method) — TEST entry, remove after verifying
  if ! defaults read com.apple.HIToolbox AppleEnabledInputSources 2>/dev/null | grep -q "SCIM.ITABC"; then
    defaults write com.apple.HIToolbox AppleEnabledInputSources -array-add \
      '{"Bundle ID" = "com.apple.inputmethod.SCIM"; "Input Mode" = "com.apple.inputmethod.SCIM.ITABC"; "InputSourceKind" = "Input Mode";}'
    echo "Added Mandarin Pinyin Simplified input method"
  fi
  killall cfprefsd 2>/dev/null || true

  # shortcuts (Keyboard) — logout/login required to activate
  # Move focus to next window in active app -> Cmd+< (Spanish-ISO `<>` key, keycode 10)
  defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 \
    '{enabled = 1; value = { parameters = (60, 10, 1048576); type = standard; }; }'

# Trackpad — logout/login required to activate
  # tap to click (built-in + bluetooth + global)
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
  defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
  defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Dock
  defaults write com.apple.dock tilesize -int 48
  defaults write com.apple.dock largesize -int 80
  defaults write com.apple.dock magnification -bool true
  defaults write com.apple.dock autohide -bool true
  defaults write com.apple.dock show-recents -bool false
  killall Dock &> /dev/null

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

echo
echo "Done. new-user.sh completed successfully."
