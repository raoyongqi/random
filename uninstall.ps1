# Set the path to the adb tool
$adbPath = "C:\Users\r\Downloads\platform-tools\adb.exe"

# Check if adb is available
if (-Not (Test-Path $adbPath)) {
    Write-Host "ADB not found. Please check the path setting!"
    exit
}

# Check connected devices
Write-Host "Checking connected devices..."
$deviceList = & $adbPath devices
if ($deviceList -match "device$") {
    Write-Host "Device connected successfully."
} else {
    Write-Host "No device detected. Please check the device connection."
    exit
}

# Get all installed packages
Write-Host "Listing all installed packages..."
$allPackages = & $adbPath shell pm list packages  # Only user-installed apps (excluding system apps)

if ($allPackages) {
    Write-Host "Found the following user-installed packages:"
    $allPackages | ForEach-Object {
        # Extract package name
        $packageName = $_ -replace "package:", ""
        
        Write-Host "Uninstalling user app: $packageName ..."
        
        # Uninstall the user app
        & $adbPath shell pm uninstall --user 0 $packageName
    }
    Write-Host "All user-installed apps have been processed!"
} else {
    Write-Host "No user-installed apps found."
}

# End of script
Write-Host "Script execution completed!"
