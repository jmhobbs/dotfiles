#!/bin/bash

# Fix permissions after symlinking
chmod 0700 ~/.gnupg

# Write defaults on macOS so pinentry does not cache in keychain
uname -a | grep Darwin > /dev/null && defaults write org.gpgtools.common "UseKeychain" -bool "false"

# Add the GitHub web flow key
curl https://github.com/web-flow.gpg | gpg --import
