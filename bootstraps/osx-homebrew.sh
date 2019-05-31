#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install macvim --with-override-system-vim --with-cscope --with-lua

brew install \
  aria2 \
  awscli \
  bash \
  bash-completion \
  chruby \
  composer \
  composer \
  curl \
  diff-so-fancy
  direnv \
  editorconfig \
  ffmpeg \
  fzf \
  giflossy \
  git \
  git-extras \
  gnupg \
  go \
  hexyl \
  httpie \
  imagemagick \
  irssi \
  jq \
  kubernetes-cl i\
  most \
  ncdu \
  netcat \
  nmap \
  node \
  openjpeg \
  openssl \
  php \
  phplint \
  pinentry \
  pstree \
  pwgen \
  python \
  redis \
  rename \
  ripgrep \
  rlwrap \
  rsync \
  ruby-build \
  ruby-install \
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
  cinch \
  dropbox \
  fantastical \
  firefox \
  flux \
  go2shell \
  google-chrome \
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
  visual-studio-code \
  vlc

# Set Homebrew bash as default
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
chsh -s /usr/local/bin/bash
