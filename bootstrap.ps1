Set-ExecutionPolicy Bypass -Scope Process -Force

if (!(Test-Path "$($env:ChocolateyInstall)\choco.exe") -and !(Test-Path "$($env:ChocolateyInstall)\bin\choco.exe")) {
    Write-Output ("Chocolatey: Installing")
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Output ("Chocolatey: Already installed.")
}

Write-Output ("Installing git...")
choco upgrade git -y
Write-Output ("Finished installing git.")

if (!(Test-Path -Path ".\source\github\bootstrap" )) {
    mkdir ".\source\github\bootstrap"
    git clone https://github.com/clperez/bootstrap ".\source\github\bootstrap"
    Push-Location ".\source\github\bootstrap"
}
else {
    Push-Location ".\source\github\bootstrap"
    git pull origin master
}

Get-ChildItem -Path . -Directory | ForEach-Object { 
    $installPath = Join-Path $_ "Install.ps1"
    if (Test-Path -Path $installPath ) {
        Invoke-Expression -Command $installPath
    }
}
