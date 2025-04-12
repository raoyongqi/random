
from pynput.mouse import Controller
import time

# 创建鼠标控制器
mouse = Controller()

# 等待一会（可选）
time.sleep(1)

# 设置目标位置
target_position = (1363, 290)

# 移动鼠标到指定位置
mouse.position = target_position
print(f"✅ 鼠标已移动到: {target_position}")

# 等待一点时间再滚动
time.sleep(0.5)

# 模拟鼠标滚轮滚动（向下滚 5 单位）
mouse.scroll(0, -7)  # 如果想向上滚，就把 -5 改成 5

print("🔃 鼠标滚轮向下滚动 5 单位")
