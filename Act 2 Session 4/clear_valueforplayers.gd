extends Button

@onready var clear_value: Button = self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	clear_value.pressed.connect(_clear_value_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _clear_value_pressed() -> void:
	print("clear order sent")
	for group_name in self.get_groups():
		get_tree().call_group(group_name, "_clear")
