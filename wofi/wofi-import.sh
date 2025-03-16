#!/bin/bash

WOFI_DIR="$(pwd)"
CONFIG_DIR="$HOME/.config/wofi"

if [ "$EUID" -eq 0 ]; then
    echo "Do not run this script as root. Exiting."
    exit 1
fi

mkdir -p "$CONFIG_DIR"

for file in "$WOFI_DIR"/*; do
    filename=$(basename "$file")

    if [[ "$filename" != "wofi-import.sh" ]]; then
        cp "$file" "$CONFIG_DIR/$filename"
        echo "$filename copied to $CONFIG_DIR"
    fi

done

echo "Wofi configuration updated."
