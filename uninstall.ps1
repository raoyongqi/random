# Set the path to the adb tool
$adbPath = "C:\Users\r\Downloads\platform-tools\adb.exe"
$apkBackupDir = "C:\Users\r\Desktop\apk2"  # 备份文件夹路径

# 检查 ADB 是否可用
if (-Not (Test-Path $adbPath)) {
    Write-Host "ADB not found. Please check the path setting!"
    exit
}

# 检查设备连接状态
Write-Host "Checking connected devices..."
$deviceList = & $adbPath devices
if ($deviceList -match "device$") {
    Write-Host "Device connected successfully."
} else {
    Write-Host "No device detected. Please check the device connection."
    exit
}

# 检查设备是否连接到网络
Write-Host "Checking if device is connected to a network..."
$networkStatus = & $adbPath shell "getprop gsm.network.type"
if ($networkStatus -match "NONE") {
    Write-Host "Device is not connected to a network. Stopping the uninstallation process."
    exit
} else {
    Write-Host "Device is connected to the network. Proceeding with the script."
}

# 创建 apk2 目录（如果不存在）
if (-Not (Test-Path $apkBackupDir)) {
    Write-Host "Creating backup directory: $apkBackupDir"
    New-Item -Path $apkBackupDir -ItemType Directory
}

# 获取所有已安装的包
Write-Host "Listing all installed packages..."
$allPackages = & $adbPath shell pm list packages  # 获取所有已安装的包

if ($allPackages) {
    Write-Host "Found the following user-installed packages:"
    $allPackages | ForEach-Object {
        # 提取包名
        $packageName = $_ -replace "package:", ""

        # 获取 APK 路径
        $apkPath = & $adbPath shell pm path $packageName

        if ($apkPath) {
            # 提取 APK 文件到 apk2 目录
            $apkFile = $apkPath -replace "package:", ""
            $localApkPath = Join-Path $apkBackupDir ($packageName + ".apk")

            # 使用 adb pull 将 APK 从设备中提取到本地文件夹
            Write-Host "Pulling APK: $apkFile to $localApkPath"
            & $adbPath pull $apkFile $localApkPath

            Write-Host "Uninstalling user app: $packageName ..."

            # 卸载该用户应用
            & $adbPath shell pm uninstall --user 12 $packageName
        } else {
            Write-Host "Failed to find APK for package $packageName"
        }
    }
    Write-Host "All user-installed apps have been processed!"
} else {
    Write-Host "No user-installed apps found."
}

# 结束脚本
Write-Host "Script execution completed!"
