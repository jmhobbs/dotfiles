#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install macvim --with-override-system-vim --with-cscope --with-lua

brew install \
  bash \
  bash-completion \
  chruby \
  coreutils \
  curl \
  direnv \
  editorconfig \
  ffmpeg \
  gifsicle \
  git \
  git-extras \
  gnupg \
  go \
  httpie \
  imagemagick \
  jq \
  most \
  netcat \
  nmap \
  node \
  openssl \
  pwgen \
  python \
  redis \
  rename \
  ripgrep \
  ruby-install \
  shellcheck \
  the_silver_searcher \
  tree \
  watch \
  wget

brew cask install \
  bartender \
  caffeine \
  charles \
  cinch \
  dropbox \
  fantastical \
  flux \
  go2shell \
  gpg-suite \
  hajo-headphone-enhancer \
  iterm2 \
  meld \
  mou \
  ngrok \
  osxfuse \
  postico \
  sequel-pro \
  spectacle \
  vlc

# Set Homebrew bash as default
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash
