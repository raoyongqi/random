import subprocess
import pygetwindow as gw
import time
from pynput.mouse import Listener
from PIL import ImageGrab
import json

# 文件名
output_file = 'coordinates.txt'

# 创建或清空文件
with open(output_file, 'w') as f:
    f.write("记录的鼠标点击坐标:\n")

# 启动 scrcpy
scrcpy_path = r'C:\Users\r\Downloads\scrcpy-win64-v3.2\scrcpy-win64-v3.2\scrcpy.exe'
subprocess.Popen([scrcpy_path])

# 等待 scrcpy 启动并确保窗口显示
time.sleep(3)  # 等待更长时间，确保 scrcpy 已经完全启动

# 获取 Scrcpy 窗口的位置和大小
def get_scrcpy_window():
    try:
        # 获取所有标题包含 'scrcpy' 的窗口
        windows = gw.getWindowsWithTitle('ANG-AN00')  # 修改为更通用的标题匹配
        if windows:
            scrcpy_window = windows[0]  # 假设只打开一个 Scrcpy 窗口
            return scrcpy_window.left, scrcpy_window.top, scrcpy_window.width, scrcpy_window.height, scrcpy_window._hWnd
        else:
            print("未找到 Scrcpy 窗口，请确保 Scrcpy 正在运行。")
            return None
    except Exception as e:
        print(f"获取 Scrcpy 窗口失败: {e}")
        return None

# 判断窗口是否在最上层
def is_window_on_top(window_handle):
    try:
        # 获取所有窗口的句柄
        windows = gw.getAllWindows()
        # 排序窗口，按 Z-Order 排序
        windows_on_top = sorted(windows, key=lambda w: w._hWnd)
        return windows_on_top[-1]._hWnd == window_handle
    except Exception as e:
        print(f"获取窗口堆叠顺序失败: {e}")
        return False

# 点击计数器
click_count = 0
click_positions = {}  # 存储点击坐标

# 检查像素颜色是否是 (215, 215, 215)
def is_position_valid(x, y):
    try:
        screenshot = ImageGrab.grab(bbox=(x, y, x + 1, y + 1))
        pixel_color = screenshot.getpixel((0, 0))  # 获取该像素的颜色
        print(f"点击位置 ({x}, {y}) 的像素颜色: {pixel_color}")
        return pixel_color  
    except Exception as e:
        print(f"获取像素颜色失败: {e}")
        return False

def on_click(x, y, button, pressed):
    global click_count
    if pressed and click_count < 2:
        scrcpy_window = get_scrcpy_window()  
        if scrcpy_window:
            left, top, width, height, window_handle = scrcpy_window

            # 判断 Scrcpy 窗口是否在最上层
            if is_window_on_top(window_handle):
                # 检查鼠标是否在 Scrcpy 窗口内
                if left <= x <= left + width and top <= y <= top + height:
                    if is_position_valid(x, y):
                        click_count += 1

                        if click_count == 1:
                            click_positions['1'] = (x, y)
                            print(f"第 1 次点击: ({x}, {y})")
                        elif click_count == 2:
                            click_positions['2'] = (x, y)
                            print(f"第 2 次点击: ({x}, {y})")
                            print("已经记录了2次点击，开始计算另外两个位置...")

                            # 退出监听器
                            listener.stop()  # 在记录了 2 次点击后停止监听

# 设置鼠标监听器
with Listener(on_click=on_click) as listener:
    print("请点击鼠标两次，记录坐标...")
    listener.join()  # 开始监听鼠标事件

# 输出四个坐标到文件
with open(output_file, 'a') as f:
    f.write("\n点击的坐标如下:\n")
    f.write(f"test_positions = {click_positions}\n")  # 将字典以 Python 格式写入文件

print(f"完整的点击坐标: {click_positions}")  # 打印到控制台
