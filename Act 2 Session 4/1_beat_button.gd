extends Button

@export var bars_group_name: String = "Beat Progress Bar"  # Group name for your progress bars
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
# Set up the timer for looping
	pass

# Start loop when the button is pressed
func _on_pressed() -> void:
	get_tree().call_group("Beat Progress Bar", "_Next_Beat", 1)
	
	
	get_tree().call_group("Beat Progress Bar", "_Round")
	if audio_player:
		print("-------------------------------------------------PLAYING SOUND")
		print(audio_player)
		audio_player.stop()
		audio_player.pitch_scale = randf_range(0.5, 1.6)
		audio_player.play()
