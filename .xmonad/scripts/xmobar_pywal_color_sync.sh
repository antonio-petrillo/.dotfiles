#!/usr/bin/env bash

input="$HOME/.xmonad/lib/Colors.hs"

background=$(awk -F'=' '$1 == "background"{print $2}' $input | sed 's/"//g')
foreground=$(awk -F'=' '$1 == "foreground"{print $2}' $input | sed 's/"//g')

color0=$(awk -F'=' '$1 == "color0"{print $2}' $input | sed 's/"//g')
color1=$(awk -F'=' '$1 == "color1"{print $2}' $input | sed 's/"//g')
color2=$(awk -F'=' '$1 == "color2"{print $2}' $input | sed 's/"//g')
color3=$(awk -F'=' '$1 == "color3"{print $2}' $input | sed 's/"//g')
color4=$(awk -F'=' '$1 == "color4"{print $2}' $input | sed 's/"//g')
color5=$(awk -F'=' '$1 == "color5"{print $2}' $input | sed 's/"//g')
color6=$(awk -F'=' '$1 == "color6"{print $2}' $input | sed 's/"//g')
color7=$(awk -F'=' '$1 == "color7"{print $2}' $input | sed 's/"//g')
color8=$(awk -F'=' '$1 == "color8"{print $2}' $input | sed 's/"//g')
color9=$(awk -F'=' '$1 == "color9"{print $2}' $input | sed 's/"//g')
color10=$(awk -F'=' '$1 == "color10"{print $2}' $input | sed 's/"//g')
color11=$(awk -F'=' '$1 == "color11"{print $2}' $input | sed 's/"//g')
color12=$(awk -F'=' '$1 == "color12"{print $2}' $input | sed 's/"//g')
color13=$(awk -F'=' '$1 == "color13"{print $2}' $input | sed 's/"//g')
color14=$(awk -F'=' '$1 == "color14"{print $2}' $input | sed 's/"//g')
color15=$(awk -F'=' '$1 == "color15"{print $2}' $input | sed 's/"//g')

sed -e "s/BGCOLOR/$background/g" \
    -e "s/FGCOLOR/$foreground/g" \
    -e "s/COLOR1/$color1/g" \
    -e "s/COLOR2/$color2/g" \
    -e "s/COLOR3/$color3/g" \
    -e "s/COLOR4/$color4/g" \
    -e "s/COLOR5/$color5/g" \
    -e "s/COLOR6/$color6/g" \
    -e "s/COLOR7/$color7/g" \
    -e "s/COLOR8/$color8/g" \
    -e "s/COLOR9/$color9/g" \
    -e "s/COLOR10/$color10/g" \
    -e "s/COLOR11/$color11/g" \
    -e "s/COLOR12/$color12/g" \
    -e "s/COLOR13/$color13/g" \
    -e "s/COLOR14/$color14/g" \
    -e "s/COLOR15/$color15/g" \
    "$HOME"/.xmonad/template/xmobar/xmobarrc1-template > "$HOME"/.xmonad/xmobar/xmobarrc1


sed -e "s/BGCOLOR/$background/g" \
    -e "s/FGCOLOR/$foreground/g" \
    -e "s/COLOR1/$color1/g" \
    -e "s/COLOR2/$color2/g" \
    -e "s/COLOR3/$color3/g" \
    -e "s/COLOR4/$color4/g" \
    -e "s/COLOR5/$color5/g" \
    -e "s/COLOR6/$color6/g" \
    -e "s/COLOR7/$color7/g" \
    -e "s/COLOR8/$color8/g" \
    -e "s/COLOR9/$color9/g" \
    -e "s/COLOR10/$color10/g" \
    -e "s/COLOR11/$color11/g" \
    -e "s/COLOR12/$color12/g" \
    -e "s/COLOR13/$color13/g" \
    -e "s/COLOR14/$color14/g" \
    -e "s/COLOR15/$color15/g" \
    "$HOME"/.xmonad/template/xmobar/xmobarrc0-template > "$HOME"/.xmonad/xmobar/xmobarrc0
