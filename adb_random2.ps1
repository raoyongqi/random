# 固定的前三位
$fixedPart = "12"

$randomPart2 = Get-Random -Minimum 0 -Maximum 3
$randomPart1 = Get-Random -Minimum 0 -Maximum 3

# 生成完整的密码
$password = $fixedPart + $randomPart1 + $randomPart2

# 执行 adb 命令并捕获输出（包括标准输出和标准错误输出）
$output = & "C:\Users\r\Downloads\platform-tools\adb.exe" shell locksettings set-password $password 2>&1
$output -contains "Password set to"
if ($output -contains "Password set to") {

} else {

}

# 检查是否包含旧密码错误信息
if ($output -contains "Old password '' didn't match") {
    Write-Host "Password change failed: Old password doesn't match"
    # 抛出异常或其他需要的处理
    throw "Old password didn't match"
}

# 检查是否没有设备连接
if ($output -contains "adb.exe: no devices/emulators found") {
    Write-Host "No devices or emulators found"
    # 抛出异常或其他需要的处理
    throw "No devices or emulators found"
}

# 如果没有错误，重定向输出到 $null
