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
brew bundle --no-upgrade

echo
printf "\033[1;35m====================\033[0m\n"
printf "\033[1;35mInstalling from asdf\033[0m\n"
printf "\033[1;35m====================\033[0m\n\n"


for plugin in nodejs golang ruby kubectl
do
  printf "✅ Installing \033[0;34m%s\033[0m\n" "$plugin"
  asdf plugin add "$plugin"
  asdf install "$plugin" latest
done

echo
printf "\033[1;35m===============\033[0m\n"
printf "\033[1;35mInstalling Misc\033[0m\n"
printf "\033[1;35m===============\033[0m\n\n"

printf "✅ Installing \033[0;34mfzf\033[0m\n"
"$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

printf "✅ Installing \033[0;34mMartian Mono\033[0m\n"
wget -qO /tmp/martian-mono.zip https://github.com/evilmartians/mono/releases/download/v1.0.0/martian-mono-1.0.0-ttf.zip
unzip /tmp/martian-mono.zip -d ~/Library/Fonts/ -x '__MACOSX/*' 'README.txt' 'Changelog.md'
rm /tmp/martian-mono.zip

printf "✅ Installing \033[0;34msrv\033[0m\n"
go install github.com/jmhobbs/srv@latest
