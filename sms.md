./adb shell
content query --uri content://sms/ --projection _id,address,body,date
exit
./adb pull /data/local/tmp/sms_output.txt