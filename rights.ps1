# PowerShell script to grant permissions to com.huawei.hisuite using ADB

# List of permissions to grant
$permissions = @(
    "android.permission.READ_PHONE_STATE",
    "android.permission.READ_PRIVILEGED_PHONE_STATE",
    "android.permission.ACCESS_CACHE_FILESYSTEM",
    "android.permission.RECOVERY",
    "android.permission.REBOOT",
    "com.huawei.android.permission.PROTECTAREA",
    "com.huawei.permission.MANAGE_USE_SECURITY",
    "android.permission.INTERNET",
    "android.permission.WAKE_LOCK",
    "com.huawei.hicloud.permission.hicloudLogin",
    "android.permission.GET_ACCOUNTS",
    "android.permission.READ_CONTACTS",
    "android.permission.WRITE_CONTACTS",
    "android.permission.READ_SMS",
    "android.permission.WRITE_SMS",
    "android.permission.SEND_SMS",
    "android.permission.RECEIVE_SMS",
    "com.huawei.hisuite.permission.SMS_SEND_RESULT",
    "android.permission.UPDATE_APP_OPS_STATS",
    "android.permission.READ_CALENDAR",
    "android.permission.WRITE_CALENDAR",
    "android.permission.WRITE_EXTERNAL_STORAGE",
    "android.permission.SET_WALLPAPER",
    "android.permission.WRITE_MEDIA_STORAGE",
    "android.permission.GET_PACKAGE_SIZE",
    "android.permission.INSTALL_PACKAGES",
    "android.permission.DELETE_PACKAGES",
    "com.huawei.hisuite.permission.INSTALL_APP_RESULT",
    "android.permission.REQUEST_INSTALL_PACKAGES",
    "android.permission.REQUEST_DELETE_PACKAGES",
    "com.android.packageinstaller.permission.REQUEST_DELETE_PACKAGES",
    "android.permission.READ_FRAME_BUFFER",
    "com.huawei.KoBackup.permission.ACCESS",
    "android.permission.ACCESS_KEYGUARD_SECURE_STORAGE",
    "com.hicloud.android.clone.permission.ACCESS",
    "com.huawei.permission.sec.MDM.v2",
    "com.android.providers.media.permission.SCAN_FOLDER",
    "android.permission.PEERS_MAC_ADDRESS",
    "android.permission.NETWORK_SETTINGS",
    "com.huawei.parentcontrol.permission.provider",
    "huawei.android.permission.HW_SIGNATURE_OR_SYSTEM",
    "com.huawei.hisuite.permission.DISCONNECT",
    "com.huawei.permission.sec.ACCESS_UDID",
    "com.huawei.permission.ACCESS_HW_KEYSTORE",
    "com.huawei.android.powerkit.permission.BIND",
    "android.permission.START_ACTIVITIES_FROM_BACKGROUND",
    "com.huawei.dataprivacycenter.permission.LAUNCH_DATA_PRIVACY_CENTER",
    "android.permission.READ_EXTERNAL_STORAGE",
    "android.permission.ACCESS_MEDIA_LOCATION"
)

# Loop through each permission and grant it to the app
foreach ($permission in $permissions) {
    Write-Host "Granting permission: $permission"
    ./adb shell pm grant com.huawei.hisuite $permission
    Start-Sleep -Seconds 1  # Optional: add a slight delay between commands
}

Write-Host "All permissions granted to com.huawei.hisuite."
