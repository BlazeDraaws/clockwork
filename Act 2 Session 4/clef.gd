extends Sprite2D

@export var grey_color: Color = Color(0.5, 0.5, 0.5, 0.2)  # Grey with low opacity
@export var white_color: Color = Color(1, 1, 1, 1)  # White with full opacity
@onready var progress_bar: TextureProgressBar = $".."

@export var hover_duration: float = 0.3  # How long the hover lasts
@export var hover_intensity: float = 1  # How much the sprite hovers up and down
@export var jiggle_angle: float = 0.5  # The maximum degrees for jiggleover

var has_chimed = false
var is_hovering = false
var hover_time = 0.0  # Timer to track hover duration
var rotation_velocity = 0.0  # The amount of rotation for jiggle
var hover_position = Vector2()  # Store the original position
var original_rotation = 0.0  # Store the original rotation

func _ready() -> void:
	# Initially set the sprite to grey with low opacity
	self.modulate = grey_color
	
	hover_position = position  # Store the initial position
	original_rotation = rotation  # Store the initial rotation

# Update sprite color based on progress bar value
func _process(_delta: float) -> void:
	# Calculate the progress as a value between 0 and 1 (0 = 0%, 1 = 100%)
	var progress = progress_bar.value / progress_bar.max_value *20

	# Apply exponential easing, so it's grey for most of the time
	var exponential_factor = pow(progress, 1)  # This makes the transition slower at first
	
	# Interpolate between grey and white based on the progress with exponential easing
	modulate = grey_color.lerp(white_color, 1.0 - exponential_factor)  # Slow transition to white

	# Check if the progress reaches 100% (when the hover effect should start)
	if progress >= 1.0:
		if not is_hovering:
			is_hovering = true
			hover_time = hover_duration  # Reset hover duration



	if is_hovering:
		hover_time -= _delta  # Decrease hover time each frame
		if hover_time <= 0:
			is_hovering = false  # Hovering ends after time is up


		# Hovering effect: Move the sprite up and down
		var hover_amount = sin(Time.get_ticks_msec() / 100.0 * hover_intensity) * 5.0
		position = hover_position + Vector2(0, hover_amount)  # Move sprite up and down

		# Jiggle effect: Rotate sprite slightly left and right
		rotation = sin(Time.get_ticks_msec() / 100.0 * jiggle_angle) * 0.05

	else:
		# Slowly return the sprite to its original position and rotation
		position = position.lerp(hover_position, 0.001)  # Smooth position interpolation
		rotation = lerp_angle(rotation, original_rotation, 0.001)  # Smooth rotation interpolation back to the original
