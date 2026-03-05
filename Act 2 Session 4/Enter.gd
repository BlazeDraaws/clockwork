extends Button

enum NoteType { LIGHT = 1, STANDARD = 2, HEAVY = 3, ULT = 4 }

@export var note_type: NoteType = NoteType.LIGHT

func get_note_type() -> int:
	return note_type


func _ready() -> void:
	# Connect this button's pressed signal to its own function
	self.connect("pressed", Callable(self, "_on_button_pressed"))

func _on_button_pressed() -> void:
	for group_name in self.get_groups():
		get_tree().call_group(group_name, "_enter", note_type)
		get_tree().call_group(group_name, "_updatenotetype", note_type)
	print("Button was pressed! ", self.name)
