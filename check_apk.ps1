# Get the package list for user 0 and user 10
$user0_packages = & adb shell pm list packages --user 0
$user10_packages = & adb shell pm list packages --user 10

# Extract the package names (remove the "package:" prefix)
$user0_packages = $user0_packages -replace "package:", ""
$user10_packages = $user10_packages -replace "package:", ""

# Compare the two lists and find the apps that exist in user 0 but not in user 10
$user0_extra = $user0_packages | Where-Object { $_ -notin $user10_packages }

# Output the results
if ($user0_extra.Count -gt 0) {
    Write-Output "Apps present in User 0 but not in User 10:"
    $user0_extra
} else {
    Write-Output "User 0 and User 10 have the same set of apps."
}
