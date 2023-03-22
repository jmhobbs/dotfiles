#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__root="$(cd "$__dir/../" && pwd)"

source "$__dir/util.sh"

PINENTRY="pinentry"

if [[ $OSTYPE == "darwin"* ]]
then
  PINENTRY="$(brew --prefix)/bin/pinentry-mac"
else
  PINENTRY="pinentry-bemenu"
fi

headline_banner "Writing Templates"

find "$__root" -name '*.tmpl' -print0 | \
  while IFS= read -r -d '' file
  do
    target="${file/.tmpl/}"
    printf "✅ Writing - \033[0;34m%s\033[0m \033[1;32m⮕ \033[0m \033[1;34m%s\033[0m\n" "$file" "$target"

    TEMPLATE_WARNING="THIS IS A GENERATED FILE, COPY CHANGES BACK TO $file" \
    PINENTRY="$PINENTRY" \
      envsubst < "$file" > "$target"
  done
echo
