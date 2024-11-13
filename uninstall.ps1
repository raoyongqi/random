# Set the path to the adb tool
$adbPath ="C:\Users\r\Downloads\platform-tools\adb.exe"

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
$allPackages = & $adbPath shell pm list packages

if ($allPackages) {
    Write-Host "Found the following installed packages:"
    $allPackages | ForEach-Object {
        # Extract package name
        $packageName = $_ -replace "package:", ""
        Write-Host $packageName
    }

    # Ask if the user wants to uninstall all user-installed apps
    $uninstallAll = Read-Host "Do you want to uninstall all user-installed apps? (Y/N)"
    if ($uninstallAll -eq "Y") {
        Write-Host "Uninstalling user-installed apps..."
        $allPackages | ForEach-Object {
            # Extract package name
            $packageName = $_ -replace "package:", ""
            
            # If it is a user app, uninstall it
            $isUserApp = & $adbPath shell pm list packages -3 | Select-String $packageName
            if ($isUserApp) {
                Write-Host "Uninstalling user app: $packageName ..."
                & $adbPath shell pm uninstall $packageName
            }
            # If it is a system app, disable it
            else {
                Write-Host "Disabling system app: $packageName ..."
                & $adbPath shell pm disable-user --user 0 $packageName
            }
        }
        Write-Host "All applications have been processed!"
    } else {
        Write-Host "Uninstall operation cancelled."
    }
} else {
    Write-Host "No installed apps found."
}

# End of script
Write-Host "Script execution completed!"
