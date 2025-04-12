import time
from pynput.mouse import Controller, Button
import subprocess

scrcpy_path = r'C:\Users\r\Downloads\scrcpy-win64-v3.2\scrcpy-win64-v3.2\scrcpy.exe'
subprocess.Popen([scrcpy_path])

# 等待 scrcpy 启动并确保窗口显示
time.sleep(3)  # 等待3秒钟确保 scrcpy 启动并且显示

# 创建鼠标控制对象
mouse = Controller()

# 定义起始位置和目标位置
start_pos = (1164,800)
end_pos = (1164, 177)

# 模拟从下往上的滑动
def swipe_up(start_pos, end_pos, steps=30):
    print(f"从 {start_pos} 滑动到 {end_pos}")
    
    # 确保鼠标停留在起始位置
    mouse.position = start_pos
    time.sleep(0.2)  # 稍作停留，避免触发不必要的事件

    # 按住鼠标左键
    mouse.press(Button.left)
    
    # 计算步长
    step_x = (end_pos[0] - start_pos[0]) / steps
    step_y = (end_pos[1] - start_pos[1]) / steps
    
    # 逐步向上滑动
    current_pos = start_pos
    for i in range(steps):
        current_pos = (current_pos[0] + step_x, current_pos[1] + step_y)
        mouse.position = current_pos
        time.sleep(0.02)  # 每一步之间的间隔，控制滑动速度
    
    # 确保最终位置准确
    mouse.position = end_pos
    time.sleep(0.5)  # 确保鼠标已到达目标位置

    # 释放鼠标
    mouse.release(Button.left)
    time.sleep(1)  # 确保鼠标释放后停留一段时间

# 执行从下往上的滑动
swipe_up(start_pos, end_pos)

print("滑动操作完成")
