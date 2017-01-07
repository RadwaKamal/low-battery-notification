#!/bin/bash

function notify {
    battery_status=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
                    | grep 'percentage'`
    percent=`echo "${battery_status//[!0-9]}"`
    if [ "$percent" -lt "$1" ] 
        then
            notify-send -u critical \
            -i notification-battery-low \
            "Battery is low" "only $percent% left"
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
