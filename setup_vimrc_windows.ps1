# Get the dotfiles root directory
$Dotfiles = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

# Initialize and update submodules
Push-Location $Dotfiles
git submodule update --init --recursive
Pop-Location

# Define source and target paths
$Source = Join-Path $Dotfiles "vimrc\vimrcs\basic.vim"
$Target = Join-Path $env:USERPROFILE "_vimrc"

# Remove existing target if it exists (symlink or file)
if (Test-Path $Target) {
    Remove-Item $Target -Force
}

# Create the symlink
New-Item -ItemType SymbolicLink -Path $Target -Target $Source

Write-Host "Successfully symlinked vimrc:"
Write-Host "Source: $Source"
Write-Host "Target: $Target"