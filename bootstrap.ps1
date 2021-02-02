Set-ExecutionPolicy Bypass -Scope Process -Force

if (!(Test-Path "$($env:ChocolateyInstall)\choco.exe") -and !(Test-Path "$($env:ChocolateyInstall)\bin\choco.exe")) {
    Write-Output ("Chocolatey: Installing")
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else {
    Write-Output ("Chocolatey: Already installed.")
}

Write-Output ("Installing git...")
choco upgrade git -y
Write-Output ("Finished installing git.")

Push-Location $env:USERPROFILE

If (Test-Path -Path source\github\bootstrap ) {
    Write-Output ("Removing bootstrap folder.")
    Remove-Item source\github\bootstrap -Force -Recurse -ErrorAction SilentlyContinue
}

If (!(Test-Path -Path source\github\) ) {
    Write-Output ("Creating github folder.")
    mkdir source\github\
}

Pop-Location

try {
    if (Get-Command "git") {
        Push-Location ~\source\github
        git clone https://github.com/clperez/bootstrap bootstrap
        Pop-Location

        Push-Location ~\source\github\bootstrap
        Get-ChildItem -Path . -Directory | ForEach-Object { 
            $installPath = Join-Path $_ "Install.ps1"
            if (Test-Path -Path $installPath ) {
                Invoke-Expression -Command $installPath
            }            
        }
        Pop-Location    
    }
}
Catch {
    Write-Output "Please restart your shell and run the command again."
}
