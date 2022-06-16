# put config file in the right place
stow -d "$HOME"/.dotfiles -t "$HOME"

git clone https://github.com/doomemacs/doomemacs "$HOME"/.config/emacs
"$HOME"/.config/emacs/bin/doom install

# run pywal one time to generate cache file
wal -i $(ls -1 "$HOME"/.dotfiles/wallpapers/ | shuf | head -1)

# fix symlink
ln -fs "$HOME"/.cache/wal/dunstrc "$HOME"/.config/dunst/dunstrc
ln -fs "$HOME"/.cache/wal/colors.hs "$HOME"/.xmonad/lib/Colors.hs
