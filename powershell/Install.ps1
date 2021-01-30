
$version="7.0.4"
$psFileName="PowerShell-$version-win-x64.msi"
$psInstallerUrl="https://github.com/PowerShell/PowerShell/releases/download/v$version/$psFileName"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
(New-Object System.Net.WebClient).DownloadFile($psInstallerUrl,$psFileName)
Write-Output "Installing powershell $psFileName"
msiexec.exe /package "$psFileName" /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
