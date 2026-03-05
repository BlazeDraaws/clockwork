extends Button
@export var phase_number: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	for group_name in self.get_groups():
		get_tree().call_group(group_name, "_nextbossphase",phase_number)
