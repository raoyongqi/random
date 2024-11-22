# 设置 ADB 的路径
$adbPath = "C:\Users\r\Downloads\platform-tools\adb.exe"

# 遍历 user 0 到 user 20
for ($user_id = 0; $user_id -le 11; $user_id++) {
    # 执行卸载命令
    & $adbPath shell pm uninstall --user $user_id com.huawei.scanner
    & $adbPath shell pm disable-user  --user $user_id com.huawei.scanner

    & $adbPath shell pm uninstall --user $user_id com.huawei.search
    & $adbPath shell pm uninstall --user $user_id com.huawei.mediacenter
    & $adbPath shell pm uninstall --user $user_id com.huawei.appmarket
    & $adbPath shell pm uninstall --user $user_id com.huawei.browser
    & $adbPath shell pm uninstall --user $user_id com.huawei.android.hwouc
    & $adbPath shell pm uninstall --user $user_id com.huawei.himovie
    & $adbPath shell pm uninstall --user $user_id com.huawei.gameassistant
    & $adbPath shell pm uninstall --user $user_id com.huawei.music
    & $adbPath shell pm uninstall --user $user_id com.huawei.hwireader
    & $adbPath shell pm uninstall  --user $user_id com.huawei.android.thememanager
    & $adbPath shell pm uninstall--user $user_id com.huawei.wallet
    & $adbPath shell pm uninstall--user $user_id com.huawei.smarthome
    & $adbPath shell pm disable-user  --user $user_id com.huawei.smarthome
    & $adbPath shell pm uninstall  --user $user_id com.huawei.phoneservice
    & $adbPath shell pm uninstall  --user $user_id com.huawei.hidisk
    & $adbPath shell pm disable-user  --user $user_id com.huawei.intelligent
    & $adbPath shell pm uninstall --user $user_id com.huawei.android.totemweather
    & $adbPath shell pm disable-user --user $user_id com.huawei.search

    & $adbPath shell pm disable-user  --user $user_id com.huawei.android.totemweather
    & $adbPath shell pm uninstall  --user $user_id com.huawei.intelligent
    & $adbPath shell pm disable-user   --user $user_id com.huawei.hidisk
    & $adbPath shell pm disable-user   --user $user_id com.huawei.android.findmyphone
    & $adbPath shell pm uninstall  --user $user_id com.huawei.android.findmyphone
    & $adbPath shell pm uninstall  --user $user_id com.huawei.mycenter
    & $adbPath shell pm disable-user  --user $user_id com.huawei.mycenter
    & $adbPath shell pm uninstall --user $user_id com.huawei.educenter
    & $adbPath shell pm uninstall --user $user_id com.huawei.gamebox
    & $adbPath shell pm disable-user  --user $user_id com.huawei.gamebox
    & $adbPath shell pm uninstall --user $user_id  com.huawei.lives
    & $adbPath shell pm uninstall --user $user_id  com.huawei.hiskytone

    & $adbPath shell pm disable-user  --user $user_id  com.huawei.lives
    & $adbPath shell pm disable-user  --user $user_id com.huawei.educenter
    & $adbPath shell pm disable-user  --user $user_id com.huawei.phoneservice
    & $adbPath shell pm disable-user  --user $user_id com.huawei.hwireader
    & $adbPath shell pm disable-user  --user $user_id com.huawei.android.thememanager
    & $adbPath shell pm disable-user  --user $user_id com.huawei.gameassistant
    & $adbPath shell pm disable-user --user $user_id com.huawei.himovie
    & $adbPath shell pm disable-user --user $user_id com.huawei.music
    & $adbPath shell pm disable-user --user $user_id com.huawei.wallet
    & $adbPath shell pm disable-user --user $user_id com.huawei.mediacenter
    & $adbPath shell pm disable-user --user $user_id com.huawei.appmarket
    & $adbPath shell pm disable-user --user $user_id com.huawei.browser
    & $adbPath shell pm disable-user --user $user_id com.huawei.android.hwouc
    & $adbPath shell pm disable-user --user $user_id  com.huawei.hiskytone
}
