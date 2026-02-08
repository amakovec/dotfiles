#!/bin/zsh

SCRIPT_DIR=$(dirname "$0")
EXT_FILE="$SCRIPT_DIR/extensions.txt"

if [ "$1" = "export" ]; then
    code --list-extensions > "$EXT_FILE"
    python3 -c "
import json
import os
ext_file = '$EXT_FILE'
settings_file = '$SCRIPT_DIR/settings.json'
with open(ext_file) as f:
    extensions = [line.strip() for line in f if line.strip()]
with open(settings_file) as f:
    settings = json.load(f)
settings['remote.SSH.defaultExtensions'] = extensions
with open(settings_file, 'w') as f:
    json.dump(settings, f, indent=4)
"
    echo "Extensions exported to $EXT_FILE and settings.json updated"
elif [ "$1" = "import" ]; then
    if [ ! -f "$EXT_FILE" ]; then
        echo "Extensions file not found: $EXT_FILE"
        exit 1
    fi
    while IFS= read -r ext; do
        if [ -n "$ext" ]; then
            code --install-extension "$ext"
        fi
    done < "$EXT_FILE"
    echo "Extensions imported from $EXT_FILE"
else
    echo "Usage: $0 {export|import}"
    exit 1
fi