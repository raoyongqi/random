import time
import json
from pynput.mouse import Controller, Button

# 创建鼠标控制器
mouse = Controller()

# === 点击函数 ===
def right_click(position):
    print(f"🖱️ 右键点击: {position}")
    mouse.position = position
    time.sleep(0.2)
    mouse.press(Button.right)
    time.sleep(1)
    mouse.release(Button.right)

def left_click(position):
    print(f"🖱️ 左键点击: {position}")
    mouse.position = position
    time.sleep(0.2)
    mouse.press(Button.left)
    time.sleep(0.5)
    mouse.release(Button.left)

# === 主流程 ===
def perform_sequence_batch(positions_dict):
    for key, right_click_position in positions_dict.items():
        print(f"\n▶️ 开始处理 {key}，坐标: {right_click_position}")
        right_click(tuple(right_click_position))

        # 偏移坐标（右 20，下 60）
# 计算偏移位置，先加再判断 y 是否超过 94c1
        x_offset = 30
        y_offset = 70

        new_y = right_click_position[1] + y_offset
        if new_y > 941:
            new_y = 911  # 超过 941 就用 921

        offset_position = (right_click_position[0] + x_offset, new_y)

        time.sleep(1)
        left_click(offset_position)

        # 点击两个固定位置
        time.sleep(2)
        left_click((688, 454))
        time.sleep(1)
        left_click((1049, 724))

        print(f"✅ {key} 处理完成")
        time.sleep(2)

# === 从 JSON 文件读取坐标 ===
def load_positions_from_json(file_path):
    try:
        with open(file_path, 'r') as f:
            return json.load(f)
    except Exception as e:
        print(f"❌ 读取 JSON 文件失败: {e}")
        return {}

# === 执行 ===
if __name__ == '__main__':
    json_file = 'app_icon_coordinates.json'  # 你存放坐标的文件
    positions = load_positions_from_json(json_file)
    if positions:
        for i in range(30):  # 循环 30 次
            perform_sequence_batch(positions)
            
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
    else:
        print("⚠️ 未找到可用的坐标，流程终止。")
