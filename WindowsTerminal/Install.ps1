
$base = (Split-Path $MyInvocation.MyCommand.Path -Parent)


choco upgrade microsoft-windows-terminal -y

# copy "$base\settings.xml" 
$terminalDir = ((Get-ChildItem -Path "$env:LOCALAPPDATA\Packages\Microsoft.*\LocalState\" -Directory -Force ) | Select-Object -first 1 | Select-Object FullName).FullName
copy -Path "$base\settings.json" -Destination "$terminalDir\settings.json"
