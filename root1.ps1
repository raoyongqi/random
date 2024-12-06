$rootPath = "/"

# 设置输出文件
$outputFile = "root1.txt"

# 清空输出文件，以确保每次运行脚本时都是新的输出
if (Test-Path $outputFile) {
    Remove-Item $outputFile
}

# 执行 adb shell 命令并列出指定路径下的文件夹权限
$command = "adb shell ls -lR $rootPath"  # ls -lR：递归列出所有文件和目录

# 如果需要指定设备 ID
if ($device_id) {
    $command = "adb -s $device_id shell ls -lR $rootPath"
}

# 获取命令输出
$directories = Invoke-Expression $command

# 跟踪当前路径
$currentPath = $rootPath

# 遍历输出，处理目录权限
$directories | ForEach-Object {
    # 如果输出包含 "Permission denied" 跳过该行
    if ($_ -match "Permission denied") {
        return
    }

    # 解析文件夹的权限
    $permissions = $_.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)
    
    # 判断是否为目录，并且拥有者是否是 root
    if ($permissions[2] -eq "root" -and $permissions[0].StartsWith("d")) {
        # 获取完整的文件夹路径
        $folderName = $permissions[-1]
        $fullPath = Join-Path $currentPath $folderName

        # 将符合条件的目录写入 root1.txt 文件
        Add-Content -Path $outputFile -Value "Directory: $fullPath has root permissions"
    }

    # 如果当前行是目录名称，更新当前路径
    if ($_ -match "^d") {
        $permissions = $_.Split(" ", [System.StringSplitOptions]::RemoveEmptyEntries)
        $folderName = $permissions[-1]
        $currentPath = Join-Path $currentPath $folderName
    }
}

Write-Host "Process completed. Check $outputFile for the list of directories with root permissions."
