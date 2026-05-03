#!/bin/bash
set -euo pipefail

# This script requires sudo privileges. If your daily user is not an admin,
# switch to an admin user first: `su - <admin-user>` then rerun.
# Ask for the administrator password upfront and keep it alive
if ! sudo -v; then
  echo "Error: $(whoami) cannot run sudo on $(hostname -s)."
  echo "Switch to an admin user (e.g. 'su - <admin-user>') and rerun."
  exit 1
fi
while true; do sudo -n true; sleep 60; kill -0 "$$" 2>/dev/null || exit; done 2>/dev/null &

# homebrew
if ! command -v brew &>/dev/null; then
  echo "Installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# brew shellenv: arch-aware, append to ~/.zprofile only if missing, eval every run
if [ -x /opt/homebrew/bin/brew ]; then
  BREW_PREFIX=/opt/homebrew
else
  BREW_PREFIX=/usr/local
fi
SHELLENV_LINE="eval \"\$($BREW_PREFIX/bin/brew shellenv)\""
if ! grep -qF "$SHELLENV_LINE" "$HOME/.zprofile" 2>/dev/null; then
  printf '\n%s\n' "$SHELLENV_LINE" >> "$HOME/.zprofile"
fi
eval "$($BREW_PREFIX/bin/brew shellenv)"

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

# whitelist the brew zsh in /etc/shells so per-user chsh (in new-user.sh) succeeds
BREW_ZSH="$BREW_PREFIX/bin/zsh"
if ! grep -qxF "$BREW_ZSH" /etc/shells; then
  echo "$BREW_ZSH" | sudo tee -a /etc/shells > /dev/null
fi

# casks
# NOTE: mysides was deprecated upstream (Oct 2025) — install still works for now;
# if/when brew removes it, the Finder sidebar setup in new-user.sh will silently skip.
brew install --cask \
  alfred \
  firefox \
  gifcapture \
  karabiner-elements \
  kitty \
  mysides \
  rectangle \
  slack \
  visual-studio-code \
  webtorrent

# NOTE: Firefox enterprise policies via Contents/Resources/distribution/policies.json
# was removed — modifying the .app bundle invalidates the code signature on macOS
# Sequoia+, causing "Firefox is damaged and can't be opened". Configure desired
# settings manually, or revisit with a non-bundle delivery method (mobileconfig
# requires manual Profile approval; user.js requires post-first-launch handling).

# docker desktop (via DMG so the in-app updater stays intact)
if [ ! -d /Applications/Docker.app ]; then
  echo "Installing Docker Desktop"
  if [ "$(uname -m)" = "arm64" ]; then
    DOCKER_URL=https://desktop.docker.com/mac/main/arm64/Docker.dmg
  else
    DOCKER_URL=https://desktop.docker.com/mac/main/amd64/Docker.dmg
  fi
  DOCKER_DMG=/tmp/Docker.dmg
  curl -fsSL -o "$DOCKER_DMG" "$DOCKER_URL"
  DOCKER_MOUNT=$(hdiutil attach "$DOCKER_DMG" -nobrowse | tail -1 | awk '{print $3}')
  sudo cp -R "$DOCKER_MOUNT/Docker.app" /Applications/
  hdiutil detach "$DOCKER_MOUNT" -quiet
  rm "$DOCKER_DMG"
  sudo /Applications/Docker.app/Contents/MacOS/install --accept-license --user="$USER"
fi

# bun
curl -fsSL https://bun.sh/install | bash

echo
echo "Done. new-computer.sh completed successfully."
echo "Next: run new-user.sh to set up dotfiles symlinks and per-user config."
