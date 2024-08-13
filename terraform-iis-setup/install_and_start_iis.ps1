# Check if IIS is installed
if (-not (Get-WindowsFeature -Name Web-Server).Installed) {
    # Install IIS and include management tools
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
    Write-Host 'IIS Installed Successfully!'
} else {
    Write-Host 'IIS is already installed.'
}

# Start IIS service
iisreset /start
Write-Host 'IIS Server Started Successfully!'
