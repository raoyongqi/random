import subprocess

# 检查是否连接了设备
def check_device():
    result = subprocess.run(['adb', 'devices'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, encoding='utf-8')
    if "device" in result.stdout:
        print("Device connected.")
    else:
        print("No device connected.")

# 查看 data/local/tmp/Music 目录下的文件数量
def count_files_in_music():
    # 列出目录下的所有文件
    result = subprocess.run(['adb', 'shell', 'ls', '/data/local/tmp/Music'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, encoding='utf-8')
    
    if result.returncode == 0:
        if result.stdout:  # 确保 stdout 不为空
            files = result.stdout.splitlines()  # 将输出按行分割
            file_count = len(files)
            print(f"Number of files in /data/local/tmp/Music: {file_count}")
        else:
            print("No files found or the directory is empty.")
    else:
        print("Error:", result.stderr)

check_device()
count_files_in_music()
