#!/bin/zsh

echo "Starting all-in-one dotfiles installer..."

# Disable automatic period insertion on double-space
echo "Disabling automatic period insertion on double-space..."
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Get the script directory
SCRIPT_DIR=$(dirname "$0")

# Install Homebrew packages
echo "Installing Homebrew packages..."
cd "$SCRIPT_DIR/macos"
brew bundle install

# Symlink VSCode settings
echo "Symlinking VSCode settings..."
"$SCRIPT_DIR/vscode/symlink_macos.sh"

# Export VSCode extensions (this also updates settings.json)
echo "Exporting VSCode extensions..."
"$SCRIPT_DIR/vscode/manage_extensions_macos.sh" export

# Setup vimrc
echo "Setting up vimrc..."
"$SCRIPT_DIR/vscode/setup_vimrc_macos.sh"

# Install Beast Mode
echo "Installing Beast Mode..."
"$SCRIPT_DIR/vscode/install_beast_mode_macos.sh"

echo "All installations complete!"
echo ""
echo "Next steps:"
echo "1. Copy $SCRIPT_DIR/vscode/beastmode.agent.md to .github/agents/beastmode.agent.md in your project workspaces"
echo "2. Restart VSCode to apply all changes"
echo "3. For vim, the vimrc is now symlinked"