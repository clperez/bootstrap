

choco upgrade microsoft-windows-terminal -y

Push-Location "$terminalDir"

$base = (Split-Path $MyInvocation.MyCommand.Path -Parent)
$terminalDir = ((Get-ChildItem -Path "$env:LOCALAPPDATA\Packages\Microsoft.*\LocalState\" -Directory -Force ) | Select-Object -first 1 | Select-Object FullName).FullName
Remove-Item ".\settings.json" -ErrorAction SilentlyContinue
cmd /c mklink /H ".\settings.json" "$base\settings.json"

Pop-Location


