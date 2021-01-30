
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function gitconfig { git --git-dir="$env:USERPROFILE\.cfg" --work-tree="$env:USERPROFILE" }
function gitstatus { git --git-dir="$env:USERPROFILE\.cfg" --work-tree="$env:USERPROFILE" -uno status}

Set-Alias -Name config -Value gitconfig
Set-Alias -Name status -Value gitstatus