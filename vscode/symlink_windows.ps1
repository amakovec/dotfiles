# Get the directory of this script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Get the dotfiles root directory
$Dotfiles = Split-Path -Parent $ScriptDir

# Define source and target paths
$Source = Join-Path $Dotfiles "vscode\settings.json"
$TargetDir = Join-Path $env:APPDATA "Code\User"
$Target = Join-Path $TargetDir "settings.json"

# Ensure the target directory exists
if (-not (Test-Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force
}

# Remove existing target if it exists (symlink or file)
if (Test-Path $Target) {
    Remove-Item $Target -Force
}

# Create the symlink
New-Item -ItemType SymbolicLink -Path $Target -Target $Source

Write-Host "Successfully symlinked VSCode settings:"
Write-Host "Source: $Source"
Write-Host "Target: $Target"