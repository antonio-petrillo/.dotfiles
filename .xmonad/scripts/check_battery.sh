#!/usr/bin/env bash
#
# inspired by https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget
#

# kill previous instance of the script
ps aux | grep "check_battery.sh" | awk '{print $2}' | xargs kill -p

under_30_flag="/tmp/battery_under_30"
under_15_flag="/tmp/battery_under_15"

battery="Battery 0"
isCharging=$(acpi | grep "^$battery" | grep -o "[a-zA-Z]*harging")
chargeLevel=$(acpi | grep "^$battery" | grep -o "[[:digit:]]\+%")

while true # I know this is ugly, but I didn't manage to send notification with crontab, even if the script is effectively runned
do

if [[ "$isCharging" == "Discharging" ]]
then
    case "$chargeLevel" in
        # just in case
        "2"[0-9]"%" | "30%" | "1"[6-9]"%")
            if [[ ! -e $under_30_flag ]]
            then
                notify-send -t 5000 -u normal "Houston we have a problem" "Battery is under 30%" -i "$HOME"/.xmonad/assets/spaceman.jpg
                touch $under_30_flag
            fi
            ;;
        "1"[0-5]"%")
            if [[ ! -e $under_30_flag ]]
            then
                notify-send -t 5000 -u critical "Houston we have a big problem" "Battery is under 15%" -i "$HOME"/.xmonad/assets/ghost.png
                touch $under_15_flag
            fi
            ;;
    esac
fi

if [[ "$isCharging" == "Charging" ]]
then
    case "$chargeLevel" in
        "99%" | "100%")
                notify-send -t 5000 -u low "Houston everything is okay here" "Battery is fully charged" -i "$HOME"/.xmonad/assets/spaceman.jpg
            ;;
    esac

    if [[ -e $under_30_flag ]]
    then
        rm $under_30_flag
    fi
    # just in case
    if [[ -e $under_15_flag ]]
    then
        rm $under_15_flag
    fi
fi

sleep 60
done
