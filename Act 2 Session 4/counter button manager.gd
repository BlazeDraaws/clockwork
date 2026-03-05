extends Node

@onready var main_text_box: LineEdit = $Counter  # The main text box
@onready var bonus_text_box: LineEdit = $HBoxContainer2/Bonus  # The bonus text box
@onready var add_button: Button = $"HBoxContainer2/Add Modifier"
@onready var clear_value: Button = $"HBoxContainer2/Clear Value"
@onready var dice_1: Button = $HBoxContainer/Dice
@onready var dice_2: Button = $HBoxContainer/Dice2
@onready var dice_3: Button = $HBoxContainer/Dice3
@onready var dice_4: Button = $HBoxContainer/Dice4
@onready var dice_5: Button = $HBoxContainer/Dice5
@onready var dice_6: Button = $HBoxContainer/Dice6


@export var dice_max_values: Array = [4, 6, 8, 10, 12, 20]  # Max values for each dice


func _on_dice_button_pressed(dice_index: int) -> void:
	var max_value = dice_max_values[dice_index]  # Get the max value for the selected dice
	print(max_value)
	main_text_box._get_random_from_max_value(max_value)  # Update the main text box with the random value

func _ready() -> void:
	# Connect the button press signal to the function
#	checkmark.toggled.connect(_on_checkmark_toggled)
	add_button.pressed.connect(_on_add_button_pressed)
	clear_value.pressed.connect(_clear_value_pressed)
	dice_1.pressed.connect(self._on_dice_button_pressed.bind(0))  # 6-sided dice
	dice_2.pressed.connect(self._on_dice_button_pressed.bind(1))  # 10-sided dice
	dice_3.pressed.connect(self._on_dice_button_pressed.bind(2))  # 12-sided dice
	dice_4.pressed.connect(self._on_dice_button_pressed.bind(3))  # 20-sided dice
	dice_5.pressed.connect(self._on_dice_button_pressed.bind(4))  # 100-sided dice
	dice_6.pressed.connect(self._on_dice_button_pressed.bind(5))  # Another 6-sided dice
# Function to handle the button press
func _on_add_button_pressed() -> void:
	# Get the values from the text boxes
	var main_value = float(main_text_box.text)
	var bonus_value = float(bonus_text_box.text)
	
	# Add the bonus value to the main value
	main_value += bonus_value
	
	# Update the main text box with the new value
	main_text_box.text = str(main_value)

func _clear_value_pressed() -> void:
	main_text_box.usage = false
	main_text_box.text = ""  # Clears the text in the LineEdit

var bool_value: bool = false  # Boolean to track checkbox state

# Function to handle the CheckBox toggle
func _on_checkmark_toggled(checked: bool) -> void:
	bool_value = checked  # Update the boolean value based on whether the checkbox is checked
	_update_textbox()  # Update the text in the LineEdit

# Function to update the main text box based on the boolean value
func _update_textbox() -> void:
	if bool_value:
		main_text_box.usage = true
	else:
		main_text_box.add_theme_color_override("font_color", Color(0, 0, 0))
		main_text_box.usage = false
