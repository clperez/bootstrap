choco upgrade vscode -y

Write-Output Installing extensions ...

code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension eamodio.gitlens
code --install-extension HookyQR.beautify
code --install-extension humao.rest-client
code --install-extension Ionide.Ionide-fsharp
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-dotnettools.csharp
code --install-extension ms-python.python
code --install-extension ms-vscode-remote.remote-wsl
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.powershell
code --install-extension redhat.java
code --install-extension Shan.code-settings-sync
code --install-extension VisualStudioExptTeam.vscodeintellic
code --install-extension vscjava.vscode-java-debug
code --install-extension vscjava.vscode-java-dependency
code --install-extension vscjava.vscode-java-pack
code --install-extension vscjava.vscode-java-test
code --install-extension vscjava.vscode-maven
code --install-extension bbenoist.vagrant
code --install-extension DotJoshJohnson.xml
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-ssh-edit
code --install-extension HookyQR.beautify

Write-Output Finished installing vscode extensions

Write-Output Deploying configuration files ...
Push-Location "~\AppData\Roaming\Code\User"
Remove-Item .gitconfig -ErrorAction SilentlyContinue
Remove-Item .gitignore -ErrorAction SilentlyContinue

cmd /c mklink /H ".\keybindings.json" "$base\keybindings.json"
cmd /c mklink /H ".\settings.json" "$base\settings.json"
Pop-Location
Write-Output Finished deploying configuration files.
