# A BoxStarter script for use with http://boxstarter.org/WebLauncher
# Updates a Windows machine and installs a range of developer tools

# Show more info for files in Explorer

Set-WindowsExplorerOptions -EnableShowProtectedOSFiles  -EnableShowFileExtensions -EnableShowFullPathInTitleBar

# Enable remote desktop
Enable-RemoteDesktop

# WLS 
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Small taskbar
Set-TaskbarOptions -Size Small -Combine Always

# Allow running PowerShell scripts
Update-ExecutionPolicy Unrestricted

# Allow unattended reboots
$Boxstarter.RebootOk=$true
$Boxstarter.NoPassword=$false
$Boxstarter.AutoLogin=$true

# Update Windows and reboot if necessary
Install-WindowsUpdate -AcceptEula
if (Test-PendingReboot) { Invoke-Reboot }

## Install Visual Studio 2019
## cinst visualstudio2019community --package-parameters "--pasive --locale en-UK"
## 
## cinst visualstudio2019-workload-netcoretools --package-parameters "--pasive --locale en-UK"
## cinst visualstudio2019-workload-netweb --package-parameters "--pasive --locale en-UK"
## cinst visualstudio2019-workload-nativedesktop --package-parameters "--pasive --locale en-UK"
## cinst visualstudio2019-workload-manageddesktop --package-parameters "--pasive --locale en-UK"
## cinst visualstudio2019-workload-netcrossplat --package-parameters "--pasive --locale en-UK"
## cinst visualstudio2019-workload-nativemobile --package-parameters "--pasive --locale en-UK"
## cinst visualstudio2019-workload-nativegame --package-parameters "--pasive --locale en-UK"
## cinst visualstudio2019-workload-universal --package-parameters "--pasive --locale en-UK"
## cinst visualstudio2019-workload-managedgame --package-parameters "--pasive --locale en-UK"
## if (Test-PendingReboot) { Invoke-Reboot }
#
#cinst visualstudio2019buildtools
#cinst visualstudio2019-workload-vctools
#if (Test-PendingReboot) { Invoke-Reboot }
#
## VS 2015 extensions
## cinst webessentials2015
## cinst resharper -version 2016.1.1
## if (Test-PendingReboot) { Invoke-Reboot }
#
## MS SQL Server
## cinst mssqlserver2014express
## cinst mssqlservermanagementstudio2014express
## if (Test-PendingReboot) { Invoke-Reboot }
#
## Java & IntelliJ IDEA
## cinst jdk8
## cinst sbt
## cinst intellijidea-ultimate -version 14.1
#
## Dev tools
#cinst dotnetcore-sdk
#cinst git-credential-manager-for-windows
#cinst tortoisegit
#cinst unetbootin
cinst beyondcompare
cinst beyondcompare-integration
cinst sysinternals
## cinst gitkraken
## cinst python2
## cinst nodejs
## cinst atom
## cinst notepadplusplus
cinst sublimetext3
cinst vscode
## cinst fiddler4
## cinst rdcman
#
## Browsers
cinst googlechrome
cinst googledrive
## cinst firefox
#
## Other essential junk
cinst 7zip
cinst 7zip.install
cinst winscp

##cinst filezilla
##cinst wincdemu
##cisnt synergy
cinst adobereader
##cinst dropbox
#
## Fun
##cinst vlc
##cinst spotify
##cinst steam
#cinst obs
#cinst emule

#if (Test-PendingReboot) { Invoke-Reboot }
#
## Configure windows Hyper-V virtualization
cinst Microsoft-Hyper-V-All -source windowsFeatures
if (Test-PendingReboot) { Invoke-Reboot }
#
## Keep it off for now.
## cinst docker-desktop
## if (Test-PendingReboot) { Invoke-Reboot }
#
# Cleanup
del C:\eula*.txt
del C:\install.*
del C:\vcredist.*
del C:\vc_red.*


echo *****************************************************
echo Running RunAfter scripts
echo *****************************************************
dir -Directory -Path $PSScriptRoot | Select-Object -ExpandProperty FullName | ForEach-Object {
    if (Test-Path -Path $_\RunAfter.ps1)
    {
        & "$_\RunAfter.ps1"
    }
}