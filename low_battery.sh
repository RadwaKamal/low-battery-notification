#!/bin/bash

function notify {
    battery_percentage=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
                    | grep 'percentage'`
    percentage=`echo "${battery_percentage//[!0-9]}"`
    if [ "$percentage" -lt "$1" ] 
        then
            notify-send -u critical \
            -i notification-battery-low \
            "Battery is low" "only $percentage% left"
            sleep 1000s
    fi
}

while true
do
    battery_state=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state'`
    state=`echo ${battery_state#*:}`
    echo $state
    if [ "$state" == "discharging" ]
        then
        notify 90 
        sleep 5s
    fi
sleep 5s
done
