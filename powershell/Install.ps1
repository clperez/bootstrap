
Write-Output Installing Windows Terminal ...
$version = "7.0.4"
$psFileName = "PowerShell-$version-win-x64.msi"
$psInstallerUrl = "https://github.com/PowerShell/PowerShell/releases/download/v$version/$psFileName"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
(New-Object System.Net.WebClient).DownloadFile($psInstallerUrl, $psFileName)
Write-Output "Installing powershell $psFileName"
msiexec.exe /package "$psFileName" /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
Write-Output Finished installing Windows Terminal.

Write-Output Deploying Windows Terminal settings ...
Push-Location "~\Documents"
$base = (Split-Path $MyInvocation.MyCommand.Path -Parent)
Remove-Item ".\WindowsPowerShell" -ErrorAction SilentlyContinue
#cmd /c mklink /H ".\WindowsPowerShell" "$base\settings.json"
New-Item -ItemType Junction -Path ".\WindowsPowerShell\" -Target "$base\WindowsPowerShell\"
Pop-Location
Write-Output Finished deploying Windows Terminal settings.

Write-Output Install posh-git and ohmyposh ...
Install-Module posh-git -Scope CurrentUser -AllowClobber -SkipPublisherCheck
Install-Module oh-my-posh -Scope CurrentUser -AllowClobber -SkipPublisherCheck
Write-Output Finished installing posh-git and ohmyposh

Write-Output Installing coding fonts ...
Invoke-WebRequest -useb get.scoop.sh | Invoke-Expression
scoop bucket add nerd-fonts
scoop install sudo
sudo scoop install Cascadia-Code
Write-Output Finished installing coding fonts ...