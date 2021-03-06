choco upgrade git -y

$base = (Split-Path $MyInvocation.MyCommand.Path -Parent)

Push-Location ~\
Remove-Item .gitconfig -ErrorAction SilentlyContinue
Remove-Item .gitignore -ErrorAction SilentlyContinue

cmd /c mklink /H ".\.gitconfig" "$base\.gitconfig"
cmd /c mklink /H ".\.gitignore" "$base\.gitignore"
Pop-Location