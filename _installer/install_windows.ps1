$CFG_DIR = $PSScriptRoot

if (! ($env:PATH -contains $CFG_DIR\bin)) {
	# Setting PATH variable...
	setx PATH "$CFG_DIR\bin;$CFG_DIR\opt;$env:PATH"
}

# Installing Chocolatey...
echo "Guide: https://chocolatey.org/install#individual"

# This command must returns "AllSigned" to install Chocolatey from PowerShell
Get-ExecutionPolicy
Set-ExecutionPolicy Bypass -Scope Process

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Installing packages
choco install fd ripgrep

