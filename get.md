./adb shell dumpsys activity activities | findstr "mResumedActivity"

 ./adb logcat | Select-String  "HwLKSS"

PS C:\Users\r\Downloads\platform-tools> ./adb shell pm suspend --user 10 com.huawei.camera
Package com.huawei.camera new suspended state: true
PS C:\Users\r\Downloads\platform-tools> ./adb shell pm suspend --user 10 com.huawei.filemanager
Package com.huawei.camera new suspended state: true
adb shell pm disable-user --user 10 moe.shizuku.privileged.api