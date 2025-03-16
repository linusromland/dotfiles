#!/bin/bash

SWAY_DIR="$(pwd)"
CONFIG_DIR="$HOME/.config/sway"
ASK_FILES=( "monitors" )

if [ "$EUID" -eq 0 ]; then
    echo "Do not run this script as root. Exiting."
    exit 1
fi

mkdir -p "$CONFIG_DIR"

for file in "$SWAY_DIR"/*; do
    filename=$(basename "$file")

    if [[ " ${ASK_FILES[@]} " =~ " $filename " ]] && [ -f "$CONFIG_DIR/$filename" ]; then
        read -p "Import $filename from system before overwriting? (y/n) " choice
        if [[ "$choice" == "y" ]]; then
            cp "$CONFIG_DIR/$filename" "$SWAY_DIR/$filename.imported"
            echo "$filename imported as $filename.imported"
        fi
    fi

    if [[ "$filename" != "sway-import.sh" ]]; then
        cp "$file" "$CONFIG_DIR/$filename"
        echo "$filename copied to $CONFIG_DIR"
    fi

done

echo "Sway configuration updated."

read -p "Do you want to reload Sway? (y/n) " reload_choice
if [[ "$reload_choice" == "y" ]]; then
    swaymsg reload
    echo "Sway reloaded."
fi
