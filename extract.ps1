# Set the ADB path
$adbPath = "C:\Users\r\Downloads\platform-tools\adb.exe"
$outputDir = "apk"

# Create the folder to store APKs if it doesn't exist
if (-Not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Force -Path $outputDir
}

# Get all installed package names and extract APKs
$packageNames = & $adbPath shell pm list packages

foreach ($package in $packageNames) {
    # Remove 'package:' prefix
    $packageName = $package -replace "package:", ""

    # Get the APK path for the package
    $apkPath = & $adbPath shell pm path $packageName
    $apkPath = $apkPath -replace "package:", ""

    if ($apkPath) {
        # Pull the APK file to the local directory
        Write-Host "Extracting APK for $packageName..."
        & $adbPath pull $apkPath "$outputDir\$packageName.apk"
    }
}

Write-Host "All APK files have been extracted to the $outputDir directory."
