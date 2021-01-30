# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

function gitconfig { git --git-dir="$env:USERPROFILE\.cfg" --work-tree="$env:USERPROFILE" }
function gitstatus { git --git-dir="$env:USERPROFILE\.cfg" --work-tree="$env:USERPROFILE" -uno status }


Set-Alias -Name config -Value gitconfig
Set-Alias -Name status -Value gitstatus

$env:SVN_URL = "https://subversion/svn/nlyte"
$env:SVN_NAE = "$env:SVN_URL/nae/"
$env:SVN_NAO = "$env:SVN_URL/nao/"
$env:SVN_NAE_REL = "$env:SVN_NAE/releases"
$env:SVN_CARLOS = "$env:SVN_URL/developers/carlos"

# Powershell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
	param($commandName, $wordToComplete, $cursorPosition)
	dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
		[System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
	}
	
}

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox