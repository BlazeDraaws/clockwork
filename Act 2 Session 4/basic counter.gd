extends LineEdit

@export var flash_duration: float = 0.2  # Duration of each flash in seconds
@export var flash_interval: float = 0.1  # Interval between each flash (for toggling between red and original color)
signal _update_number(real_value, current_group, speed)
var original_color: Color
var flashing: bool = false
var usage: bool = false

func _ready() -> void:
	# Get the original font color (default color of the text in the LineEdit)
	original_color = get_theme_color("font_color")  # Retrieve the original font color

func flash_red() -> void:
	if flashing:
		return  # If it's already flashing, do nothing

	flashing = true
	var flash_count = int(flash_duration / flash_interval)  # How many times to toggle the color

	# Loop to flash the red color
	for i in range(flash_count):
		if i % 2 == 0:
			# Set the color to red
			add_theme_color_override("font_color", Color(1, 0, 0))  # Red
		else:
			# Set it back to the original color
			add_theme_color_override("font_color", original_color)  # Original color

		await(get_tree().create_timer(flash_interval).timeout)  # Wait for the next interval

	flashing = false  # Finished flashing, reset flashing state
	
func _process(delta: float) -> void:
	if text == "":
		usage = false
	else:
		usage = true
		
	var current_value = float(text.strip_edges())
	if float(text) == 0 and usage == true:
		flash_red()
		print("STOP!!! sincerely counter")
		get_tree().call_group("Next Beat Button","_Stop")

func _Next_Beat(beats_to_skip) -> void:
	if  usage == true:
		var current_text = text.strip_edges()  # Get the current text
		var current_number = float(current_text)  # Convert it to integer

		current_number -= beats_to_skip
		_update_number.emit(current_number, self.name,1)
		text = str(current_number)  # Update the LineEdit with the new number

func _Prev_Beat() -> void:
	if  usage == true:
		var current_text = text.strip_edges()  # Get the current text
		var current_number = float(current_text)  # Convert it to integer

		current_number += 1  # Decrease by 1
	
		text = str(current_number)  # Update the LineEdit with the new number

func _clear():
	usage = false
	text = ""  # Clears the text in the LineEdit

# Function to get a random number between 1 and the max value (passed as an argument) and add it to the text box
func _get_random_from_max_value(max_value: float) -> void:
	# Make sure max_value is valid
	if max_value > 0:
		var random_value = randi_range(1, max_value)  # Get a random value between 1 and max_value
		var current_value = float(text.strip_edges())  # Get the current value from the text box

		# Add the random value to the current text box value
		current_value += random_value

		# Update the text box with the new value
		text = str(current_value)

		print("Random value (1 to ", max_value, "):", random_value)
		print("Updated value:", current_value)
	else:
		print("Invalid max value!")
