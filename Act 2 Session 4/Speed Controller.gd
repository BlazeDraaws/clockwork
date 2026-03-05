extends Button

@onready var default_text = text
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var Global = false
@export var set_speed_to = 1.0

var active := false

func _on_pressed() -> void:
	if Global:
		for node in get_tree().get_nodes_in_group("Player Speed Buttons"):
			if node != self and not node.Global and node.has_method("_on_pressed") and node.set_speed_to == set_speed_to:
				node._on_pressed()
				
	else:
		if active:
			# Deactivate and reset speed to 1.0
			_deactivate()
			for group_name in get_groups():
				if group_name != "SpeedButtons":
					get_tree().call_group(group_name, "_toggle_speed", 1.0)
		else:
			# Deactivate siblings
			for sibling in get_parent().get_children():
				if sibling != self and sibling is Button and sibling.has_method("_deactivate"):
					sibling._deactivate()
			_activate()

		if audio_player:
			audio_player.stop()
			if active:
				audio_player.pitch_scale = randf_range(1.0, 1.2)
			else:
				audio_player.pitch_scale = randf_range(0.8, 1)
			audio_player.play()

func _activate():
	active = true
	text = "Speeding!"
	self_modulate = Color(0, 1, 1) if set_speed_to > 1 else Color(1, 0, 0) if set_speed_to < 1 else Color(1, 1, 1)

	for group_name in get_groups():
		if group_name != "SpeedButtons":
			get_tree().call_group(group_name, "_toggle_speed", set_speed_to)

func _deactivate():
	active = false
	text = default_text
	self_modulate = Color(1, 1, 1)
