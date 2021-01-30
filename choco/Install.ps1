# echo *****************************************************
# echo Install Nuget Package provider
# echo *****************************************************
# Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
# 
# echo *****************************************************
# echo Running RunBefore scripts
# echo *****************************************************
# dir -Directory -Path $PSScriptRoot | Select-Object -ExpandProperty FullName | ForEach-Object {
#     if (Test-Path -Path $_\RunBefore.ps1)
#     {
#         & "$_\RunBefore.ps1"
#     }
# }
# 
# echo *****************************************************
# echo Installing posh-git and oh-my-posh modules
# echo *****************************************************
# Install-Module posh-git -Scope CurrentUser -AllowClobber -SkipPublisherCheck
# Install-Module oh-my-posh -Scope CurrentUser -AllowClobber -SkipPublisherCheck
# 
# echo *****************************************************
# echo Installing Delugia Nerd font
# echo *****************************************************
# iwr -useb get.scoop.sh | iex
# scoop bucket add nerd-fonts
# scoop install sudo
# sudo scoop install Delugia-Nerd-Font
# 
# echo *****************************************************
# echo Import chocolatey module, and install DevEnv
# echo *****************************************************
# Import-Module Boxstarter.Chocolatey
# New-PackageFromScript -Source $PSScriptRoot\Devenv.ps1 -PackageName Carlos.Devenv
# Install-BoxstarterPackage -Package Carlos.Devenv
# 

Set-ExecutionPolicy Bypass -Scope Process -Force

if (!(Test-Path "$($env:ChocolateyInstall)\choco.exe") -and !(Test-Path "$($env:ChocolateyInstall)\bin\choco.exe")) {
    Write-Output ("Chocolatey: Installing")
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Output ("Chocolatey: Already installed.")
}


