#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$__dir/scripts/util.sh"

case "${1:-}" in
  all)
    bash scripts/bootstrap.sh
    bash scripts/software.sh
    bash scripts/templates.sh
    bash scripts/config.sh
    bash scripts/link.sh
    bash scripts/trust.sh
    ;;

  bootstrap)
    bash scripts/bootstrap.sh
    ;;

  software)
    bash scripts/software.sh
    ;;

  config)
    bash scripts/config.sh
    bash scripts/templates.sh
    bash scripts/link.sh
    ;;

  link)
    bash scripts/templates.sh
    bash scripts/link.sh
    ;;

  *)
    echo "$0 [all|bootstrap|software|config|link]"
    echo
    echo "all       - Install and configure everything, in order"
    echo "bootstrap - Install what we need to install everything else"
    echo "software  - Install software and Brewfile"
    echo "config    - Set and link all configs"
    echo "link      - Just (re)link config files"
    ;;
esac
