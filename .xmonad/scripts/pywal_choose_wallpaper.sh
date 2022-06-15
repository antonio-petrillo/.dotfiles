#!/usr/bin/env bash

input="$HOME"/.dotfiles/wallpapers

selected=$(sxiv -N "change_wallpaper_pywal" -ot $input)
if [[ "$selected" != "" ]]
then
    wal -i "$selected"
    killall xmobar
    "$HOME"/.xmonad/scripts/xmobar_pywal_color_sync.sh
    xmonad --recompile
    xmonad --restart
fi
