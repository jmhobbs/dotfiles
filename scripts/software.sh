#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__root="$(cd "$__dir/../" && pwd)"

source "$__dir/util.sh"

if [[ "$OSTYPE" == "darwin"* ]]
then
  install_banner "Brewfile"
  (cd "$__root" && brew bundle --no-upgrade --no-lock)
  echo

  # todo: port to linux?
  install_banner "from asdf"
  for plugin in nodejs golang ruby kubectl
  do
    if asdf plugin list | grep "$plugin" > /dev/null
    then
      already_installed "$plugin"
    else
      printf "✅ Installing \033[0;34m%s\033[0m\n" "$plugin"
      asdf plugin add "$plugin"
      asdf install "$plugin" latest
      asdf global "$plugin" latest
    fi
  done
  echo
fi

install_banner "Misc"
if [ -f "$HOME/.fzf.zsh" ]
then
  already_installed "fzf"
else
  printf "✅ Installing \033[0;34mfzf\033[0m\n"
  "$(brew --prefix)"/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
fi

if ! type srv > /dev/null 2>&1
then
  installing "srv"
  go install github.com/jmhobbs/srv@latest
else
  already_installed "srv"
fi

# todo: port to linux
if [[ "$OSTYPE" == "darwin"* ]]
then
  if [ -f ~/Library/Fonts/MartianMono-StdRg.ttf ]
  then
    already_installed "Martian Mono"
  else
    installing "Martian Mono"
    wget -qO /tmp/martian-mono.zip https://github.com/evilmartians/mono/releases/download/v1.0.0/martian-mono-1.0.0-ttf.zip
    unzip /tmp/martian-mono.zip -d ~/Library/Fonts/ -x '__MACOSX/*' 'README.txt' 'Changelog.md'
    rm /tmp/martian-mono.zip
  fi
fi
echo
