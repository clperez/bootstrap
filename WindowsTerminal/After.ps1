

echo Copying Windows Terminal Settings.json file
$folder = [System.IO.Path]::GetDirectoryName( (Get-ChildItem -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json -Recurse | Select-Object -ExpandProperty FullName))
copy -Force -Path $PSScriptRoot\Settings.json -Destination $folder\Settings.json
