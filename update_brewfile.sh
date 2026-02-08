#!/bin/zsh

echo "Updating Brewfile..."

# Get the script directory
SCRIPT_DIR=$(dirname "$0")

# Change to macos directory and dump Brewfile
cd "$SCRIPT_DIR/macos"
brew bundle dump --force

echo "Brewfile updated at $SCRIPT_DIR/macos/Brewfile"