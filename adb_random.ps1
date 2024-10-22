# 固定的前三位
$fixedPart = "12"

$randomPart2 = Get-Random -Minimum 0 -Maximum 10
# 生成最后一位随机数
$randomPart1 = Get-Random -Minimum 0 -Maximum 10

# 生成完整的密码
$password = $fixedPart + $randomPart1 + $randomPart2


# 使用 adb 设置密码，并重定向输出到 $null
& "C:\Users\r\Downloads\platform-tools\tools\adb.exe" shell locksettings set-password $password *>&1 | Out-Null
