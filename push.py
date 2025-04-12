import subprocess
import time
from pynput.mouse import Controller, Button

# 启动 scrcpy
scrcpy_path = r'C:\Users\r\Downloads\scrcpy-win64-v3.2\scrcpy-win64-v3.2\scrcpy.exe'
subprocess.Popen([scrcpy_path])

# 等待 scrcpy 启动并确保窗口显示
time.sleep(3)  # 等待3秒钟确保 scrcpy 启动并且显示

#
# 创建鼠标控制对象
mouse = Controller()

# 目标拖动位置
target_pos = (811, 973)
target_pos2 = (1031, 967)
# 长按并拖动到目标位置的函数
def long_press_and_drag(start_pos, target_pos, target_pos2):
    print(f"长按位置: {start_pos}")
    
    # 确保鼠标先停留在起始位置，不立即触发任何滚动行为
    mouse.position = start_pos  # 移动鼠标到起始位置
    time.sleep(0.2)  # 稍作停留，避免触发不必要的事件
    
    # 现在开始按下鼠标
    mouse.press(Button.left)  # 按下鼠标左键
    time.sleep(1)  # 保持按下 1 秒钟

    # 拖动到目标位置
    print(f"拖动到目标位置: {target_pos}")
    
    # 逐步移动鼠标，避免跳跃
    current_pos = start_pos
    steps = 10  # 步骤数，用于平滑移动
    step_x = (target_pos[0] - start_pos[0]) / steps
    step_y = (target_pos[1] - start_pos[1]) / steps

    for i in range(steps):
        current_pos = (current_pos[0] + step_x, current_pos[1] + step_y)
        mouse.position = current_pos
        time.sleep(0.02)  # 每一步之间的间隔

    # 确保最终位置准确
    mouse.position = target_pos
    time.sleep(0.5)  # 确保鼠标已到达目标位置

    # 释放鼠标
    mouse.release(Button.left)  # 释放鼠标左键
    time.sleep(1)  # 确保鼠标释放后停留一段时间
    
    print(f"长按位置: {start_pos}")
    
    # 确保鼠标先停留在起始位置，不立即触发任何滚动行为
    mouse.position = start_pos  # 移动鼠标到起始位置
    time.sleep(0.2)  # 稍作停留，避免触发不必要的事件
    
    # 现在开始按下鼠标
    mouse.press(Button.left)  # 按下鼠标左键
    time.sleep(1)  # 保持按下 1 秒钟

    # 拖动到目标位置
    print(f"拖动到目标位置: {target_pos}")
    
    # 逐步移动鼠标，避免跳跃
    current_pos = start_pos
    steps = 10  # 步骤数，用于平滑移动
    step_x = (target_pos[0] - start_pos[0]) / steps
    step_y = (target_pos[1] - start_pos[1]) / steps

    for i in range(steps):
        current_pos = (current_pos[0] + step_x, current_pos[1] + step_y)
        mouse.position = current_pos
        time.sleep(0.02)  # 每一步之间的间隔

    # 确保最终位置准确
    mouse.position = target_pos2
    time.sleep(0.5)  # 确保鼠标已到达目标位置

    # 释放鼠标
    mouse.release(Button.left)  # 释放鼠标左键
    time.sleep(1)  # 确保鼠标释放后停留一段时间

import json

def load_positions(filename):
    try:
        with open(filename, 'r') as file:
            positions = json.load(file)
            return positions
    except Exception as e:
        print(f"加载 JSON 文件时出错: {e}")
        return {}

positions = load_positions("app_icon_coordinates1.json")
# 执行 500 次长按并拖动
for _ in range(500):  # 重复 500 次
    for key, pos in positions.items():
        long_press_and_drag(pos, target_pos,target_pos2)
print("操作完成")
