extends LineEdit

signal _Set_Beat(number_value:float)
signal _used(usage:bool)

@onready var cast: AudioStreamPlayer2D = $cast
@onready var cast_ult: AudioStreamPlayer2D = $"../../../../castULT"
@export var sub: bool
@export var flash_duration: float = 0.2  # Duration of each flash in seconds
@export var flash_interval: float = 0.1  # Interval between each flash (for toggling between 
@export var pitchdecrease: float = 0.0
var usage = false
var original_color: Color
var flashing: bool = false

func _process(delta: float) -> void:
	
		
	
	var current_value = int(text.strip_edges())
	if current_value <= 0:
		flash_red()



func _clear():
	print("clear order recieved")
	usage = false
	_used.emit(usage)
	_Set_Beat.emit(0.01)
	text = ""  # Clears the text in the LineEdit


# When text is submitted (Enter pressed), update the progress bar
func _on_text_submitted(new_text: String) -> void:
	if  usage == true:
		var input_value = new_text.strip_edges()  # Remove extra spaces
		var number_value = float(input_value) * 10  # Convert to float
		for group_name in self.get_groups():
			get_tree().call_group(group_name, "_updatenotetype", 1)

		# If the input is a valid number, update the progress bars
		if number_value:  # Check if it's a valid number (not NaN or 0)
			print("Sending signal")
			#for group_name in self.get_groups():
				#get_tree().call_group(group_name, "_Set_Beat", number_value)
			_Set_Beat.emit(number_value)
			
			get_tree().call_group("worldfilter","_more_glow", 10)
			cast.pitch_scale = randf_range(0.9-pitchdecrease, 1.6-pitchdecrease)
			cast.play()
			print("UPDATE TO ", number_value, "!!!!!!")
		else:
			print("Invalid input. Please enter a valid number.")
			# Turn the LineEdit background red
			add_theme_color_override("font_color", Color(0, 0, 0))  # Black text color
			add_theme_color_override("panel", Color(1, 1, 1))  # White panel color

func _unhandled_input(event):
	if event.is_action_pressed("Random Beat") and sub == false:
		_update_number(randi_range(1, 10), self.name, 1)
		_enter(false)

	if event.is_action_pressed("Random Sub Beat"):
		_update_number(randi_range(1, 10), self.name, 1)
		_enter(false)
		

# While text is being changed
func _on_text_changed(new_text: String) -> void:
	if text == "":
		usage = false
		print(self.name, "NOT USED!!")
	else:
		usage = true
	
		
		if text != "0":
			print(self.name, "IS USED!!")
			for group_name in self.get_groups():
				get_tree().call_group(group_name, "_used", usage)
	
	var input_value = new_text.strip_edges()
	var number_value = float(input_value) * 10

	if not number_value:
		add_theme_color_override("font_color", Color(1, 0, 0))  # Red text
		add_theme_color_override("panel", Color(1, 0, 0))  # Red panel
	else:
		if text == "1":
			add_theme_color_override("font_color", Color(0, 1, 1))  # Cyan text
			add_theme_color_override("panel", Color(0.0, 0.2, 0.2))  # Dark cyan background
		else:
			add_theme_color_override("font_color", Color(1, 1, 1))  # White text
			add_theme_color_override("panel", Color(0.2, 0.2, 0.2))  # Dark gray panel

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

# External update to the text
func _update_number(real_value, barName, speed):
	text = str(real_value)
	_on_text_changed(str(real_value))

# Trigger "submit" from code
func _enter(should_submit: int) -> void:
	print("button signal gotten!")
	match should_submit:
		1:
			get_tree().call_group("worldfilter", "_more_glow", 0)
		2:
			get_tree().call_group("worldfilter", "_more_glow", 15)
		3:
			get_tree().call_group("worldfilter", "_more_glow", 30)
		4:
			get_tree().call_group("worldfilter", "_more_glow", 70)
			cast_ult.play()
		_:
			print("Unhandled submit value: ", should_submit)

	_on_text_submitted(text)  # <-- Submit whatever is currently typed
