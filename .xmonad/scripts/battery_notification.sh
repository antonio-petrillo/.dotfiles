#!/usr/bin/env bash

#############################################################################################
# inspired by https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget #
#############################################################################################


################################################
###     Stop previous running script        ####
################################################

ps aux | grep "battery_notification.sh" | grep -v "grep" | grep -v "$$"| awk '{print $2}' | xargs kill 2> /dev/null

##########################################
###     Variable customization        ####
##########################################

#  which battery to monitor
battery="Battery 0"

# message to display
under_30_title="Houston we have a problem"
under_30_message="Battery is under 30%"
under_15_title="Houston we have a BIG problem"
under_15_message="Battery is under 15%"

# image
assets_folder="$HOME/.xmonad/assets"
under_30_image="spaceman.jpg"
under_15_image="ghost.png"

# sleep time
timesleep=3

##########################################

under_30_flag=/tmp/under_30_flag
under_15_flag=/tmp/under_15_flag

while true
do
    charge_level=$(acpi | grep "^$battery" | awk -F, '{print $2}' | sed 's/%//')
    is_charging=$(acpi | grep "^$battery" | grep -o "[a-zA-Z]*harging")
    case $is_charging in
        "Charging")
            if [ -f $under_30_flag ]
            then
                rm $under_30_flag
            fi
            if [ -f $under_15_flag ]
            then
                rm $under_15_flag
            fi
            ;;
        "Discharging")
            if [ $charge_level -le 30 ] && [ $charge_level -gt 15 ]
            then
                if [ ! -f $under_30_flag ]
                then
                    touch $under_30_flag
                    notify-send -e -u normal "$under_30_title" "$under_30_message" -i "$assets_folder/$under_30_image"
                fi
            elif [ $charge_level -le 15 ]
            then
                if [ ! -f $under_15_flag ]
                then
                    touch $under_15_flag
                    notify-send -e -u critical "$under_15_title" "$under_15_message" -i "$assets_folder/$under_15_image"
                fi
            fi
            ;;
        "Full")
            # add something here, I have no idea/fantasy right now
            ;;
    esac
    sleep $timesleep
done
