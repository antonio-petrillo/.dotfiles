#!/usr/bin/env bash

# Set X11 cursor (the default is cross)
xsetroot -cursor_name left_ptr

# Set wallpaper
pywal_file="$HOME/.cache/wal/colors.hs"
wallpaper=$(awk -F'=' '$1 == "wallpaper"{print $2}' "$pywal_file" | sed 's/"//g')
feh --bg-scale "$wallpaper"

# Launch battery notifcation script
~/.xmonad/scripts/battery_notification.sh & disown

# Set keyboard layout (for me just remove caps and add another ctrl)
setxkbmap us -option caps:ctrl_modifier

# Launch compositor
killall picom 2>/dev/null
picom --configuration "$HOME/.xmonad/other_config/picom.conf"

# gnome-keyring
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 && eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)

# emacs daemon
emacs --daemon

# screen setup
~/.xmonad/scripts/screen_setup.sh
