extends Button

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var Global := false

var is_next: bool = false
var default_text := text

func _on_pressed() -> void:
	if Global:
		for node in get_tree().get_nodes_in_group("Player Swing Buttons"):
			if node != self and not node.Global and node.has_method("_on_pressed"):
				node._on_pressed()
	else:
		if is_next:
			for group_name in get_groups():
				get_tree().call_group(group_name, "_toggle_swing")
			text = default_text
			self_modulate = Color(1, 1, 1)
		else:
			for sibling in get_parent().get_children():
				if sibling != self and sibling is Button and sibling.has_method("_reset_swing"):
					sibling._reset_swing()

			for group_name in get_groups():
				get_tree().call_group(group_name, "_toggle_swing")
			text = "Swinging!"
			self_modulate = Color(1, 0.9, 0.5)

		is_next = !is_next

		if audio_player:
			print("PLAYING SOUND")
			audio_player.stop()
			audio_player.pitch_scale = randf_range(0.9, 1.1)
			audio_player.play()

func _reset_swing():
	is_next = false
	text = default_text
	self_modulate = Color(1, 1, 1)
