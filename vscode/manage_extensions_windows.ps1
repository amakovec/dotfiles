param([string]$Action)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ExtFile = Join-Path $ScriptDir "extensions.txt"

if ($Action -eq "export") {
    code --list-extensions | Out-File -FilePath $ExtFile -Encoding UTF8
    $extensions = Get-Content $ExtFile | Where-Object { $_.Trim() -ne "" }
    $SettingsFile = Join-Path $ScriptDir "settings.json"
    $settings = Get-Content $SettingsFile | ConvertFrom-Json
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