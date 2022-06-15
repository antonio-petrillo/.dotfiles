#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.config/emacs/bin"
# remember to generate ssh key for github
eval $(keychain --eval --quiet ~/.ssh/github)
. "$HOME/.cargo/env"

# history ripgrep
function hrg(){
    history | rg "$1"
}

alias rb="rustup docs --book & disown"
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
(cat ~/.cache/wal/sequences &) # pywal easy integration
