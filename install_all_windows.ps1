Write-Host "Starting all-in-one dotfiles installer..."
Write-Host "Note: Homebrew installation is macOS only - skipping on Windows"

# Get the script directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Symlink VSCode settings
Write-Host "Symlinking VSCode settings..."
& "$ScriptDir\vscode\symlink_windows.ps1"

# Export VSCode extensions (this also updates settings.json)
Write-Host "Exporting VSCode extensions..."
& "$ScriptDir\vscode\manage_extensions_windows.ps1" -Action export

# Setup vimrc
Write-Host "Setting up vimrc..."
& "$ScriptDir\vscode\setup_vimrc_windows.ps1"

# Install Beast Mode
Write-Host "Installing Beast Mode..."
& "$ScriptDir\vscode\install_beast_mode_windows.ps1"

Write-Host "All installations complete!"
Write-Host ""
Write-Host "Next steps:"
Write-Host "1. Copy $ScriptDir\vscode\beastmode.agent.md to .github\agents\beastmode.agent.md in your project workspaces"
Write-Host "2. Restart VSCode to apply all changes"
Write-Host "3. For vim, the vimrc is now symlinked"