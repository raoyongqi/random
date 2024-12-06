./adb shell
content query --uri content://sms/ --projection _id,address,body,date
exit
./adb pull /data/local/tmp/sms_output.txt


 ./adb logcat | Select-String-Pattern HwLKSS

 PS C:\Users\r\Downloads\platform-tools> ./adb shell pm suspend --user 10 com.huawei.market
java.lang.IllegalArgumentException: Unknown target package: com.huawei.market
PS C:\Users\r\Downloads\platform-tools> ./adb shell pm suspend --user 10 com.huawei.appmarket
Package com.huawei.appmarket new suspended state: true
PS C:\Users\r\Downloads\platform-tools> ./adb shell pm suspend --user 10 com.huawei.intelligent
Package com.huawei.intelligent new suspended state: true

 adb shell appops set com.tencent.mm CAMERA deny
adb tcpip 5555 