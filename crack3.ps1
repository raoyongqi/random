# Fixed first three digits
$fixedPart = "12"

# Define the log file path
$logFilePath = ".\log.txt"

# Check if the file exists, if not, create it
if (-not (Test-Path $logFilePath)) {
    Write-Host "Log file does not exist, creating log.txt..." -ForegroundColor Yellow
    New-Item -Path $logFilePath -ItemType File
} else {
    # Clear the contents of the file
    Clear-Content $logFilePath
}

# Loop to generate the last two digits in reverse (from 99 to 00)
for ($randomPart1 = 7; $randomPart1 -ge 0; $randomPart1--) {
    for ($randomPart2 = 7; $randomPart2 -ge 0; $randomPart2--) {
        # Generate the complete password
        $password = "$fixedPart$randomPart1$randomPart2"
        
        # Prepare test information to log
        $logMessage = "Trying password: $password"
        $logMessage | Out-File -Append -FilePath $logFilePath

        # Use adb to clear the lock settings
        $command = & "C:\Users\r\Downloads\platform-tools\adb.exe" shell locksettings clear --old $password 2>&1

        # Log actual adb response for debugging
        $adbOutput = "ADB Output: $command"
        $adbOutput | Out-File -Append -FilePath $logFilePath

        # Check the output to determine success
        if ($command -like "*Lock credential cleared*" -or $command -like "*successful*") {
            $successMessage = "Correct password, lock settings cleared: $password"
            $successMessage | Out-File -Append -FilePath $logFilePath
            Write-Host $successMessage -ForegroundColor Green
            break 2  # Exit both loops
        } elseif ($command -like "*Request throttled*") {
            # Increase wait time after each throttle
            $waitTime = 30  # Exponential backoff
            $throttleMessage = "Request throttled, waiting $waitTime seconds to retry..."
            $throttleMessage | Out-File -Append -FilePath $logFilePath
            Write-Host $throttleMessage -ForegroundColor Yellow
            Start-Sleep -Seconds $waitTime  # Wait for the specified time
            $randomPart2++  # Retry the same password (keep the same combination)
        } else {
            # Log unmatched cases
            $unmatchedMessage = "Unmatched output: $command"
            $unmatchedMessage | Out-File -Append -FilePath $logFilePath
            Write-Host $unmatchedMessage -ForegroundColor Red
        }
    }

    # Reset retry count after each outer loop iteration
}
