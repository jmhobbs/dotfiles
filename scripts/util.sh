#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

headline_banner () {
  printf "\033[1;35m========================================================\033[0m\n"
  printf "\033[1;35m%s\033[0m\n" "$1"
  printf "\033[1;35m========================================================\033[0m\n"
}

install_banner () {
  headline_banner "$(printf "Installing %s" "$1")"
}

skipping () {
  printf "\033[1;33mSkipping:\033[0m %s\n" "$1"
}

installing () {
  printf "✅ Installing \033[0;34m%s\033[0m\n" "$1"
}

already_installed () {
  skipping "$(printf "Already installed: \033[0;34m%s\033[0m\n" "$1")"
}
