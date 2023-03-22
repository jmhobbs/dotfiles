# Dotfiles & Bootstrapping

This is my dotfiles reboot, heavily influenced by others and by my past configs.

It is currently oriented on MacOS, zsh and neovim.  When I get a new Linux daily driver I'll fix it up for that too.

# install.sh

The main entry point for setup is `install.sh`, a `bash` script.

Everything _should_ be safe to run more than once, but no promises.

```
install.sh [all|bootstrap|software|config|link]

all       - Install and configure everything, in order
bootstrap - Install what we need to install everything else
software  - Install software and Brewfile
config    - Set and link all configs
link      - Just (re)link config files
```

## all

From zero to nearly usable system in one script.

## bootstrap

Download just enough to do the rest of the work.

## software

Download and install all the software I use regularly.

## config

Configure OS preferences and restart all required services.  Also links in config files as outlined in `links`

### links

This will link all the dotfiles that it can.

Anything ending in `.symlink` will be symlinked into the home directory.

Anything ending in `.mergedir` will have it's contents symlinked in a merge style.

Existing files or links will _not_ be overridden.

It is safe to run this multiple times.
