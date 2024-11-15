# 固定的第一位
$fixedPart = "1"

# 生成后面的三位数
$randomPart1 = Get-Random -Minimum 0 -Maximum 10
$randomPart2 = Get-Random -Minimum 0 -Maximum 10
$randomPart3 = Get-Random -Minimum 0 -Maximum 10

# 生成完整的密码
$password = $fixedPart + $randomPart1 + $randomPart2 + $randomPart3

# 使用 adb 设置密码，并重定向输出到 $null
& "C:\Users\r\Downloads\platform-tools\adb.exe" shell locksettings set-password $password *>&1 | Out-Null
