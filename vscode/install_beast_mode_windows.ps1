# Get the dotfiles root directory
$Dotfiles = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)

# Define paths
$BeastModeFile = Join-Path $Dotfiles "vscode\beastmode.agent.md"
$SettingsFile = Join-Path $Dotfiles "vscode\settings.json"

# Download the Beast Mode agent file
Invoke-WebRequest -Uri "https://gist.githubusercontent.com/burkeholland/88af0249c4b6aff3820bf37898c8bacf/raw/e1898331f1755aff3265d50e30106b8c6987c4f7/beastmode3.2.chatmode.md" -OutFile $BeastModeFile

# Update settings.json with recommended Beast Mode settings
$content = Get-Content $SettingsFile -Raw
# Remove comments
$content = $content -replace '//.*', ''
# Remove trailing commas
$content = $content -replace ',\s*([}\]])', '$1'
$settings = $content | ConvertFrom-Json
$settings.'chat.tools.autoApprove' = $true
$settings.'chat.agent.maxRequests' = 100
$settings | ConvertTo-Json -Depth 10 | Set-Content $SettingsFile

Write-Host "Beast Mode installed:"
Write-Host "- Agent file downloaded to: $BeastModeFile"
Write-Host "- Settings updated in: $SettingsFile"
Write-Host ""
Write-Host "To use Beast Mode:"
Write-Host "1. Copy $BeastModeFile to .github\agents\beastmode.agent.md in your project workspace"
Write-Host "2. Restart VSCode or reload the window"
Write-Host "3. Select 'Beast Mode' from the agent dropdown in the chat sidebar"