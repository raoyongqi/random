# 确保 adb 路径正确，若不在环境变量中，请指定 adb 完整路径，例如 "C:\path\to\adb.exe"
$adbPath = "C:\Users\r\Downloads\platform-tools\adb.exe"
  # 或者指定 adb 的完整路径，例如 "C:\adb\adb.exe"

# 要卸载的应用包名列表
$packages = @(
  com.huawei.hwid
  "com.huawei.android.hwouc",
  "com.huawei.hwdockbar",
  "com.huawei.android.tips",
    "com.huawei.hiskytone",
    "com.huawei.filemanager",
    "com.hicloud.android.clone",
    "com.huawei.systemmanager",
    "com.huawei.intelligent",
    "com.huawei.android.findmyphone",
    "com.huawei.welinknow",
    "com.huawei.lives",
    "com.huawei.health",
    "com.huawei.music",
    "com.vmall.client",
    "com.huawei.hwireader",
    "com.huawei.himovie",
    "com.huawei.android.totemweather",
    "com.huawei.hidisk",
    "com.huawei.mycenter",
    "com.huawei.scenepack",
    "com.android.mediacenter",
    "com.huawei.android.thememanager",
    "com.huawei.appmarket",
    "com.huawei.parentcontrol",
    "com.huawei.wallet",
    "com.huawei.phoneservice",
    "com.huawei.hwpolicyservice",
    "com.baidu.input_huawei",
    "com.huawei.vassistant",
    "com.huawei.hisuite",
    "com.huawei.android.hwouc",
    "com.huawei.android.hwpay",
    "com.huawei.skytone",
    "com.huawei.browser",
    "com.huawei.android.pushagent",
    "com.huawei.search"
)

# 执行卸载操作
foreach ($package in $packages) {
    Write-Host "正在卸载 $package ..."
    & $adbPath shell pm uninstall --user 0 $package
    Start-Sleep -Seconds 1 # 等待1秒以防过快执行
}

Write-Host "所有应用卸载完成！"
