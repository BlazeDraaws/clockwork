extends Button

var is_looping: bool = false

@onready var audio_player: AudioStreamPlayer2D = $"jinge up 2"
@onready var jingleup: AudioStreamPlayer2D = $"jingle up"
@onready var audio_player2: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var timer: Timer = $"Timer"  # Timer node for looping
@export var bars_group_name: String = "Beat Progress Bar"  # Group name for your progress bars

func _ready() -> void:
# Set up the timer for looping
	timer.timeout.connect(_on_timer_timeout)

# Start loop when the button is pressed
func _on_pressed() -> void:
	_start_loop()
	if audio_player2:
		print("PLAYING SOUND")
		print(audio_player2)
		audio_player2.stop()
		audio_player2.pitch_scale = randf_range(0.5, 1.6)
		audio_player2.play()



# Function to start the loop
func _start_loop():
	if not is_looping:
		is_looping = true
		timer.start()

# Handle the timer timeout, called repeatedly
func _on_timer_timeout() -> void:
	if is_looping:
		print("Button Looping... (beat)")
		# Trigger the beat action for each progress bar
		get_tree().call_group("Beat Progress Bar", "_Next_Beat")

var frametimer = 0

# Stop the loop when any progress bar hits 0
func _Stop() -> void:
	print("Progress Bar reached 0! Stopping the button.")
	is_looping = false
	timer.stop()
func _final_chime() -> void:
	if audio_player:
		print("PLAYING SOUND")
		print(audio_player)
		
		frametimer = 15
		
		audio_player.pitch_scale = randf_range(0.8, 1.5)
		audio_player.play()

	if jingleup:
		print("PLAYING SOUND")
		print(jingleup)
		
		
		jingleup.pitch_scale = randf_range(0.9, 1.1)
		jingleup.play()

func _process(delta: float) -> void:
	if frametimer > 1 and frametimer < 10:
		get_tree().call_group("Beat Progress Bar", "_Round")
		print("---------------------------------------------------------------rounding!")
	if frametimer > 0:
		frametimer -= 1
		print("timer", frametimer )
