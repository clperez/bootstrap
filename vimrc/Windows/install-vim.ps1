param(
    # Where my source lives
    [string] $sourceCodePath = ''
)

if ($sourceCodePath -eq '') {
    $sourceCodePath = Split-Path (Split-Path (Split-Path (Split-Path $MyInvocation.MyCommand.Path -Parent) -Parent) -Parent) -Parent
}

$vimRcRepoPath = "$Env:USERPROFILE\vimfiles\symlink-repos\vimrc"
$vimfiles = "$Env:USERPROFILE\vimfiles"
$vimInstallPath = (Get-ChildItem -Path "$Env:ChocolateyToolsLocation\vim\vim*" -Directory -Force | Select-Object -first 1 | Select-Object FullName ).FullName
# $vimInstallPath = "$Env:ChocolateyToolsLocation\vim\vim82"
$ripgrepInstallPath = "Env:ChocolateyInstall\bin"

Write-Output "sourceCodePath = $sourceCodePath"
Write-Output "vimRcRepoPath = $vimRcRepoPath"
Write-Output "vimfiles = $vimfiles"
Write-Output "vimInstallPath = $vimInstallPath"

# Prepare ~\vimfiles directory
Remove-Item $vimfiles -Recurse -Force -ErrorAction SilentlyContinue
mkdir "$vimfiles\symlink-repos"

Push-Location "$vimfiles\symlink-repos"

# Remove the junction path or else git clone doesn't work
Remove-Item "$sourceCodePath\vimrc" -Recurse -Force -ErrorAction SilentlyContinue

# Clone this repo on the same drive as ~\vimfiles because symlinks only work on the same drive
git clone https://github.com/clperez/vimrc
 
# Create a junction to the place where all my other source code lives
Remove-Item ".\vimrc\" -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Junction -Path ".\vimrc\" -Target "$sourceCodePath\github\vimrc"
 
Pop-Location

# Get my vimrc from GitHub and symlink it to where Vim looks for it
Push-Location ~\
Remove-Item _vimrc -ErrorAction SilentlyContinue
Remove-Item _gvimrc -ErrorAction SilentlyContinue
 
cmd /c mklink /H _vimrc "$vimRcRepoPath\_vimrc"
cmd /c mklink /H _gvimrc "$vimRcRepoPath\Windows\_gvimrc"
 
mkdir .vim\undodir 

# Write-Host 'Installing and configuring Vim...' -ForegroundColor Green
if ((Test-Path $vimInstallPath)) {
    Write-Host 'Vim already installed. Skipped.' -ForegroundColor Magenta
}
else {
    choco install vim --limit-output --force -y 
}
 
# Write-Host 'Installing and configuring Ripgrep...' -ForegroundColor Green
if ((Test-Path $ripgrepInstallPath)) {
    Write-Host 'ripGrep already installed. Skipped.' -ForegroundColor Magenta
}
else {
    choco install ripgrep --limit-output --force -y 
}
 

mkdir "$vimfiles\autoload"
(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim', "$vimfiles\autoload\plug.vim")
 
Pop-Location

Set-Location $Env:SystemDrive 
Push-Location "$vimInstallPath"
# .\gvim.exe +PlugInstall +qa
 
# Write-Host "Installing fonts for vim and powerline..." -NoNewLine
# $FONTS = 0x14
# $objShell = New-Object -ComObject Shell.Application
# $objFolder = $objShell.Namespace($FONTS)
# $objFolder.CopyHere("$vimRcRepoPath\resources\PragmataPro.ttf")
# $objFolder.CopyHere("$vimRcRepoPath\resources\Inconsolata for Powerline.otf")
# $objFolder.CopyHere("$vimRcRepoPath\resources\PragmataPro for Powerline.ttf")
# Write-Host "done."
# 
# Write-Host 'Installing powerline for vim...' -ForegroundColor Green
Pop-Location
# c:
# cd \python27\scripts
# pip install powerline-status
# 
# $uri = 'https://raw.githubusercontent.com/powerline/powerline/master/powerline/bindings/vim/plugin/powerline.vim'
# (New-Object Net.WebClient).DownloadFile($uri, 'C:\Program Files (x86)\vim\vim80\plugin\powerline.vim')
# 
# # npm packages for vim syntastic javascript checker
# npm install -g eslint
# npm install -g eslint-plugin-react
# npm install -g babel-eslint
# npm install -g eslint-config-defaults
# 
# # Fuzzy file finder, can be used within Vim
# choco install fzf
# 
