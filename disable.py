import os
import chardet
import subprocess

# 自动检测文件编码
with open('packages.txt', 'rb') as file:
    raw_data = file.read()
    result = chardet.detect(raw_data)  # 检测文件编码
    encoding = result['encoding']

# 使用检测到的编码重新打开文件
with open('packages.txt', 'r', encoding=encoding) as file:
    lines = file.readlines()

# 提取并打印包名
package_names = []
for line in lines:
    # 去除空白字符和换行符
    line = line.strip()
    # 分割字符串并提取包名（'|' 后的部分）
    if '|' in line:
        package_name = line.split('|')[1].strip()  # 取 '|' 后的部分作为包名
        package_names.append(package_name)

adb_path = r"C:\Users\r\Downloads\platform-tools\adb.exe"
user_id = "10"


ps1_file = 'disable_packages.ps1'

with open(ps1_file, 'w') as ps1:
    for package in package_names:

        adb_command = f'"{adb_path}" shell pm disable-user --user {user_id} {package}'
        
        result = subprocess.run(adb_command, capture_output=True, text=True, shell=True)
        
        # 检查错误信息，如果包含 "Unknown package" 则跳过输出
        if "Unknown package" not in result.stderr:
            print(result.stdout)
            ps1.write(f'\n# 禁用{package}\n')
            ps1.write(f'& {adb_command}\n')

    print(f"PowerShell脚本已生成：{ps1_file}")
