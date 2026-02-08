#!/bin/zsh

# Get the directory of this script
SCRIPT_DIR=$(dirname "$0")

# Get the dotfiles root directory
DOTFILES=$(realpath "$SCRIPT_DIR/..")

# Define source and target paths
SOURCE="$DOTFILES/vscode/settings.json"
TARGET_DIR="$HOME/Library/Application Support/Code/User"
TARGET="$TARGET_DIR/settings.json"

# Ensure the target directory exists
mkdir -p "$TARGET_DIR"

# Remove existing target if it exists (symlink or file)
if [ -L "$TARGET" ] || [ -f "$TARGET" ]; then
    rm "$TARGET"
fi

# Create the symlink
ln -s "$SOURCE" "$TARGET"

echo "Successfully symlinked VSCode settings:"
echo "Source: $SOURCE"
echo "Target: $TARGET"