#!/bin/zsh

# Get the dotfiles root directory
DOTFILES=$(realpath "$(dirname "$0")/..")

# Initialize and update submodules
cd "$DOTFILES"
git submodule update --init --recursive

# Define source and target paths
SOURCE="$DOTFILES/vimrc/vimrcs/basic.vim"
TARGET="$HOME/.vimrc"

# Remove existing target if it exists (symlink or file)
if [ -L "$TARGET" ] || [ -f "$TARGET" ]; then
    rm "$TARGET"
fi

# Create the symlink
ln -s "$SOURCE" "$TARGET"

echo "Successfully symlinked vimrc:"
echo "Source: $SOURCE"
echo "Target: $TARGET"