import subprocess
import pyautogui
import time
import pygetwindow as gw

def launch_scrcpy():
    """Launch scrcpy to mirror the Android screen from a specific directory."""
    try:
        scrcpy_path = r'C:\Users\r\Downloads\scrcpy-win64-v3.2\scrcpy-win64-v3.2\scrcpy.exe'
        print("Launching scrcpy...")
        subprocess.Popen([scrcpy_path])  # Use subprocess.Popen to launch scrcpy in the background
        time.sleep(2)  # Wait for a moment to ensure scrcpy window has opened
    except Exception as e:
        print(f"Error launching scrcpy: {e}")

def bring_window_to_front(window_title):
    """Bring the specified window to the front."""
    try:
        windows = gw.getWindowsWithTitle(window_title)
        if windows:
            window = windows[0]
            window.activate()  # Bring the window to the front
            print(f"Window '{window_title}' brought to the front.")
        else:
            print(f"No window found with title '{window_title}'.")
    except Exception as e:
        print(f"Error bringing window to front: {e}")

def click_on_app_icon(x, y):
    """Simulate a click on the app icon at the specified coordinates."""
    try:
        print(f"Clicking on app icon at: ({x}, {y})")
        pyautogui.click(x, y)  # Click on the coordinates
        time.sleep(2)  # Wait for the app to open
    except Exception as e:
        print(f"Error clicking on app icon: {e}")
import subprocess
def simulate_back_key():
    """Simulate the press of the back key."""
    try:
        subprocess.run(['adb', 'shell', 'input', 'keyevent', '4'])
        print("Back key simulated.")
    except Exception as e:
        print(f"Error simulating back key: {e}")


def get_foreground_app():
    """Get the package name of the currently active app."""
    try:
        # Run adb command and pipe it through findstr to get the foreground app
        result = subprocess.run('adb shell dumpsys activity activities | findstr "mResumedActivity"', 
                                stdout=subprocess.PIPE, 
                                stderr=subprocess.PIPE, 
                                shell=True, 
                                text=True)

        output = result.stdout

        # Find the line containing the mResumedActivity information
        for line in output.splitlines():
            if "mResumedActivity" in line:
                # Extract the package name (typically in the form of "com.example.app/.MainActivity")
                app_info = line.split(" ")[-2]  # Extract the part before the "/"
                package_name = app_info.split("/")[0]  # Get the package name (before the "/")
                
                # Exclude specific packages
                if package_name == "com.huawei.android.launcher" or package_name == "com.tencent.mm":
                    print(f"Skipping package: {package_name}")
                    simulate_back_key()
                    return None  # Skip the package if it's excluded

                return package_name  # Return the package name if it's not excluded

    except Exception as e:
        print(f"Error getting foreground app: {e}")
    return None



def disable_app(package_name):
    """Disable the specified app using adb."""
    try:
        print(f"Disabling app: {package_name}")

        subprocess.run(['adb', 'shell', f'pm disable-user --user 10 {package_name}'])
    except Exception as e:
        print(f"Error disabling app: {e}")

def monitor_and_disable():
    """Monitor the foreground app and disable it once detected."""
    current_app = get_foreground_app()

    print(f"New app detected: {current_app}")

    if current_app is not None:
        disable_app(current_app)  # Disable the newly detected app
        time.sleep(1)  # Check every second for a new app

def automate_app_launch_and_disable(app_icon_coords):
    """Automate app launch, clicking the app icon, and disabling the app."""
    # Launch scrcpy to mirror the screen
    bring_window_to_front("ANG-AN00")  # 确保 Scrcpy 窗口在最前面
    
    click_on_app_icon(app_icon_coords[0], app_icon_coords[1])

    # 等待应用切换
    time.sleep(0.5)
    # Monitor and disable the app once it's in the foreground
    monitor_and_disable()

coordinates_file = "app_icon_coordinates.json"
import json


def read_coordinates_from_json():
    
    """Read the coordinates from the JSON file."""
    try:
        with open(coordinates_file, 'r') as f:
            app_icon_coordinates = json.load(f)
            print(f"Coordinates loaded from {coordinates_file}")
            return app_icon_coordinates
    except Exception as e:
        print(f"Error reading coordinates from JSON: {e}")
        return {}
if __name__ == '__main__':
    # Define the coordinates of the app icon (you need to adjust this based on your screen resolution)
    app_icon_coordinates = read_coordinates_from_json()
    launch_scrcpy()

    for item in app_icon_coordinates:
        print(app_icon_coordinates[item])
        automate_app_launch_and_disable(app_icon_coordinates[item])
