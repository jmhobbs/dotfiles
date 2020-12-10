#!/bin/bash

#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#brew install macvim --with-override-system-vim --with-cscope --with-lua

brew install \
  aria2 \
  awscli \
  bash \
  bash-completion \
  composer \
  curl \
  diff-so-fancy \
  direnv \
  editorconfig \
  fzf \
  giflossy \
  git \
  git-extras \
  gnupg \
  hexyl \
  httpie \
  imagemagick \
  irssi \
  jq \
  kubernetes-cli \
  most \
  netcat \
  nmap \
  nvim \
  node \
  openjpeg \
  openssl \
  php \
  phplint \
  pinentry \
  pstree \
  pwgen \
  redis \
  rename \
  ripgrep \
  rlwrap \
  rsync \
  shellcheck \
  the_silver_searcher \
  tree \
  unrar \
  watch \
  wget \
  zip \
  zopfli

brew cask install \
  bartender \
  caffeine \
  charles \
  google-chrome \
  gpg-suite \
  iterm2 \
  ngrok \
  osxfuse \
  postico \
  sequel-pro \
  visual-studio-code \
  vlc

# Set Homebrew bash as default
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash
