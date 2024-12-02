# Set the path to adb tool
$adbPath = "C:\Users\r\Downloads\platform-tools-latest-windows\platform-tools\adb.exe"  # Replace with your adb tool path
$userId = "10"  # The user ID you want to operate on

# Check if the device is connected
$deviceConnected = & $adbPath devices | Select-String "device"

if ($null -eq $deviceConnected) {  # Modify this line
    Write-Host "No device found!"
    exit
}

Write-Host "Device is connected, fetching the list of installed apps..."

# Get the list of all installed app package names for the specified user
$packages = & $adbPath shell pm list packages --user $userId -d | ForEach-Object { $_.Trim().Replace("package:", "") }

if ($packages.Count -eq 0) {
    Write-Host "No disabled app packages found!"
    exit
}

# Iterate through each package and enable/unsuspend it
foreach ($package in $packages) {
    Write-Host "Restoring app: $package"

    # Enable the app
    & $adbPath shell pm enable --user $userId $package

    # Unsuspend the app (allow running in background)
    & $adbPath shell cmd appops set --user $userId $package RUN_IN_BACKGROUND allow
}

Write-Host "All disabled apps have been restored."
