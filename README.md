# Dotfiles & Bootstrapping

This is my dotfiles reboot, heavily influenced by others and by my past configs.

It is currently oriented on MacOS, zsh and neovim.  When I get a new Linux daily driver I'll fix it up for that too.

# Makefile

The main entry point for setup is the `Makefile`

```
make [all|links|software|macOS|trust]

all      - Install everything, in order
links    - Link all configs
software - Install software and Brewfile
os       - Set os preferences and config
trust    - Import GPG keys, and other trusty things
```

## links

This will link all the dotfiles that it can.

Anything ending in `.symlink` will be symlinked into the home directory.

Anything ending in `.mergedir` will have it's contents symlinked in a merge style.

Existing files or links will _not_ be overridden.

It is safe to run this multiple times.

## software

Download and install all the software I use regularly.

## os

Configure OS preferences and restart all required services.

## trust

Download and install any trust related things, like GPG keys or SSH host keys.
