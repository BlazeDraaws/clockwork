extends Button

@export var downedstatus: bool = false



func _on_pressed() -> void:
	downedstatus = !downedstatus
	for group_name in self.get_groups():
		get_tree().call_group(group_name, "_downed", downedstatus)
	if downedstatus:
		text = "Downed"
	else:
		text = "Alive"
