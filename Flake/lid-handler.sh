#!/bin/sh

LID_STATE=$(cat /proc/acpi/button/lid/LID/state | awk '{print $2}')

if [ "$LID_STATE" = "closed" ]; then
    hyprctl dispatch movecurrentworkspacetomonitor
    hyprctl keyword monitor "eDP-1, disable"
    echo "disabling laptop monitor"
else
    sleep 1 && hyprctl keyword monitor "eDP-1, preferred,auto,auto"
    echo "laptop lid opened"
fi
