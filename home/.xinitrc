#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# see https://unix.stackexchange.com/a/295652/332452
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
mkdir -p "$HOME"/.local/share/keyrings

export DOTFILES="$HOME/dotfiles"

#xrandr --output HDMI-0 --primary --mode 1920x1080 --output DP-0 --mode 1600x900 --right-of HDMI-0
#xrandr xrandr --output DP-0 --mode 1600x900 --pos 1920x0 --output HDMI-0 --mode 1920x1080 --pos 0x0
numlockx &
exec leftwm
