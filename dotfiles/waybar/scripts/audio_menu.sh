#!/usr/bin/env bash

notify-send "Getting list of available audio outputs..."

# Get a list of available sinks (audio outputs) and format for display
output_list=$(pactl -f json list sinks | jq -r '.[].description')
declare -a icon_list=$(pactl -f json list sinks | jq -r '.[].properties."device.icon_name"')

# create icon map
declare -A icon_map
icon_map=(
	["audio-card-analog-usb"]=""
	["audio-card-analog-pci"]=""
	["audio-headphones-bluetooth"]="󰋋 "
)

# Combine descriptions and icons into Rofi format
menu_items=()
readarray -t descriptions <<< "$output_list"
readarray -t icons <<< "$icon_list"
for i in "${!descriptions[@]}"; do
    menu_items+=("${icon_map[${icons[i]}]} ${descriptions[$i]}\n")
done

# Use rofi to select an audio output device
chars="󰋋󰂯"

raw_chosen_output=$(echo -e "${menu_items[*]}" | rofi -dmenu -i -theme-str '@import "audio.rasi"' -show-icons)
chosen_output=$(echo "$raw_chosen_output" | sed "s/[$chars]//g" | xargs)

# Exit if no selection was made
if [ -z "$chosen_output" ]; then
    exit
fi

# Extract the index of the chosen output
output_index=$(pactl -f json list sinks | jq -r --arg desc "$chosen_output" '.[] | select(.description == $desc) | .index')
card_name=$(pactl -f json list sinks | jq -r --arg desc "$chosen_output" '.[] | select(.description == $desc) | .properties."device.name"')

# Get available profiles for the selected output
profiles=$(pactl -f json list cards | jq -r --arg name "$card_name" '.[] | select(.properties."device.name" == $name) | .profiles | keys[]')

# Use rofi to select a profile for the selected output
chosen_profile=$(echo -e "$profiles" | rofi -dmenu -i -theme-str '@import "audio.rasi"' -p "Select Profile")

# Switch to the selected output
pactl set-default-sink "$output_index"
notify-send "Audio Output" "Switched to: $(echo "$chosen_output" | cut -d' ' -f2-)"

# Apply the chosen profile if one is selected
if [ -n "$chosen_profile" ]; then
    pactl set-card-profile "$card_name" "$chosen_profile"
    notify-send "Audio Profile" "Switched profile to: $chosen_profile"
fi
