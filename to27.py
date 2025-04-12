import pygetwindow as gw
import subprocess
import time
import json
from pynput.mouse import Listener

# Global dictionary to store the coordinates for a 2x7 grid
app_icon_coordinates = {}

# File to save the coordinates
coordinates_file = "app_icon_coordinates.json"

# Placeholder for the reference coordinates (top-left corner and the next point in the grid)
first_click_coordinates = None
second_click_coordinates = None


def on_click(x, y, button, pressed):
    """Record the coordinates of the click."""
    global first_click_coordinates, second_click_coordinates, app_icon_coordinates

    if pressed:
        if not first_click_coordinates:
            first_click_coordinates = (x, y)  # First click (1,1) of the grid
            print(f"First click recorded at: {first_click_coordinates}")
        elif not second_click_coordinates:
            second_click_coordinates = (x, y)  # Second click (2,2) of the grid
            print(f"Second click recorded at: {second_click_coordinates}")
        
        # Once both clicks are recorded, calculate the grid positions
        if first_click_coordinates and second_click_coordinates:
            generate_coordinates_matrix()

            # After calculating and generating the matrix, save it
            print("Coordinates matrix generated. Saving to file...")
            with open(coordinates_file, 'w') as f:
                json.dump(app_icon_coordinates, f, indent=4)
            print("Coordinates saved.")
            return False  # Stop the listener after generating and saving the coordinates

def generate_coordinates_matrix():
    """Generate a 2x7 matrix of coordinates based on two reference points."""
    global first_click_coordinates, second_click_coordinates, app_icon_coordinates

    # Calculate the distance between the first two clicks
    x_distance = second_click_coordinates[0] - first_click_coordinates[0]
    y_distance = second_click_coordinates[1] - first_click_coordinates[1]

    # Generate the 2x7 grid of coordinates
    for row in range(7):  # 2 rows
        for col in range(2):  # 7 columns
            x = first_click_coordinates[0] + col * x_distance
            y = first_click_coordinates[1] + row * y_distance
            app_icon_coordinates[f"{row + 1}-{col + 1}"] = (x, y)

def start_recording_coordinates():
    """Start listening for mouse clicks to record coordinates."""
    print("Please click on two app icons to define the grid. Recording the coordinates...")
    with Listener(on_click=on_click) as listener:
        listener.join()  # Start listening for mouse clicks

def automate_app_launch_and_disable():
    """Automate app launch, clicking the app icon, and disabling the app."""
    # Launch scrcpy to mirror the screen

    # Start the coordinate recording
    start_recording_coordinates()

if __name__ == '__main__':
    # Automate the process
    automate_app_launch_and_disable()
