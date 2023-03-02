#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! type brew > /dev/null 2>&1
then
  printf "\033[1;35m===================\033[0m\n"
  printf "\033[1;35mInstalling Homebrew\033[0m\n"
  printf "\033[1;35m===================\033[0m\n\n"
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login
fi

echo
printf "\033[1;35m===================\033[0m\n"
printf "\033[1;35mInstalling Brewfile\033[0m\n"
printf "\033[1;35m===================\033[0m\n\n"
brew bundle

echo
printf "\033[1;35m=====================\033[0m\n"
printf "\033[1;35mInstalling fzf config\033[0m\n"
printf "\033[1;35m=====================\033[0m\n\n"
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish


echo
printf "\033[1;35m=======================\033[0m\n"
printf "\033[1;35mInstalling Martian Mono\033[0m\n"
printf "\033[1;35m=======================\033[0m\n\n"
wget -qO /tmp/martian-mono.zip https://github.com/evilmartians/mono/releases/download/v1.0.0/martian-mono-1.0.0-ttf.zip
unzip /tmp/martian-mono.zip -d ~/Library/Fonts/ -x '__MACOSX/*' 'README.txt' 'Changelog.md'
rm /tmp/martian-mono.zip
