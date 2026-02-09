param([string]$Action)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ExtFile = Join-Path $ScriptDir "extensions.txt"

# Check if VSCode CLI is available
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Host "Error: VSCode CLI (code command) not found. Please install VSCode and enable 'code' command in PATH."
    exit 1
}

if ($Action -eq "export") {
    code --list-extensions | Out-File -FilePath $ExtFile -Encoding UTF8
    $extensions = Get-Content $ExtFile | Where-Object { $_.Trim() -ne "" }
    $SettingsFile = Join-Path $ScriptDir "settings.json"
    $content = Get-Content $SettingsFile -Raw
    # Remove comments
    $content = $content -replace '//.*', ''
    # Remove trailing commas
    $content = $content -replace ',\s*([}\]])', '$1'
    $settings = $content | ConvertFrom-Json
    $settings.'remote.SSH.defaultExtensions' = $extensions
    $settings | ConvertTo-Json -Depth 10 | Set-Content $SettingsFile
    Write-Host "Extensions exported to $ExtFile and settings.json updated"
} elseif ($Action -eq "import") {
    if (-not (Test-Path $ExtFile)) {
        Write-Host "Extensions file not found: $ExtFile"
        exit 1
    }
    Get-Content $ExtFile | ForEach-Object {
        if ($_.Trim() -ne "") {
            code --install-extension $_.Trim()
        }
    }
    Write-Host "Extensions imported from $ExtFile"
} else {
    Write-Host "Usage: .\manage_extensions_windows.ps1 -Action {export|import}"
    exit 1
}