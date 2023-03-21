Ly ?
bemenu
pinentry-bemenu
swaylock-effects (the fork)
waybar

/dev/nvme0n1p3 -> /          ext4
/dev/nvme0n1p1 -> /boot/efi  vfat


Reload Config : cmd-shift-c

https://github.com/emersion/mako
https://github.com/Alexays/Waybar
https://github.com/ArtsyMacaw/wlogout
https://github.com/Cloudef/bemenu

Wifi Quality - wavemon
Wifi Connection - nmcli connection show


Waybar + fonts-font-awesome

apt install waybar fonts-font-awesome pavucontrol


greetd + tuigreet

https://github.com/fairyglade/ly

git clone https://git.sr.ht/~kennylevinsen/greetd


apt install libpam0g-dev rustc cargo

cargo build --release

# Put things into place
sudo cp target/release/{greetd,agreety} /usr/local/bin/
sudo cp greetd.service /etc/systemd/system/greetd.service
mkdir /etc/greetd
cp config.toml /etc/greetd/config.toml

# Create the greeter user
sudo useradd -M -G video greeter
sudo chmod -R go+r /etc/greetd/

# Look in the configuration file `/etc/greetd/config.toml` and edit as appropriate.
# When done, enable and start greetd
systemctl disable --now gdm3
systemctl enable --now greetd
