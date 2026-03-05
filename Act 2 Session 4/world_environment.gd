extends WorldEnvironment

var default_gi = environment.glow_intensity
var default_ac = environment.adjustment_contrast
var default_ab = environment.adjustment_brightness

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	environment.glow_intensity = lerp(environment.glow_intensity, default_gi, delta * 5)
	environment.adjustment_contrast = lerp(environment.adjustment_contrast, default_ac, delta * 5)
	environment.adjustment_brightness = lerp(environment.adjustment_brightness, default_ab, delta * 5)


# Example function to increase glow intensity
func _more_glow(amount: float) -> void:
	if environment:  # Check if the WorldEnvironment has an Environment resource
		var glow_enabled = environment.glow_enabled
		if glow_enabled:
			print("glow has glown")
			environment.glow_intensity += amount
			environment.glow_intensity = clamp(environment.glow_intensity, 0.0, 100.0)  # Prevent crazy values
			environment.adjustment_contrast += amount/500
			environment.adjustment_contrast = clamp(environment.adjustment_contrast, 0.0, 1.2)  # Prevent crazy values
			environment.adjustment_brightness += amount/300
			environment.adjustment_brightness = clamp(environment.adjustment_brightness, 0.0, 2.0)  # Prevent crazy values
			

func _darkness(amount: float) -> void:
	if environment:  # Check if the WorldEnvironment has an Environment resource
		print("dark has dark")
		environment.glow_intensity += amount
		environment.glow_intensity = clamp(environment.glow_intensity, 0.0, 100.0)  # Prevent crazy values
		environment.adjustment_contrast += amount/500
		environment.adjustment_contrast = clamp(environment.adjustment_contrast, 0.0, 1.2)  # Prevent crazy values
		environment.adjustment_brightness -= amount/100
		environment.adjustment_brightness = clamp(environment.adjustment_brightness, 0.0, 2.0)  # Prevent crazy values

func _stilldark(amount: float) -> void:
	if environment:  # Check if the WorldEnvironment has an Environment resource
		print("dark has dark")
		default_ab = 1-amount*0.0003
		default_ac = 1+amount*0.0001
		environment.glow_intensity += amount
		environment.glow_intensity = clamp(environment.glow_intensity, 0.0, 100.0)  # Prevent crazy values
		environment.adjustment_contrast += amount/500
		environment.adjustment_contrast = clamp(environment.adjustment_contrast, 0.0, 1.2)  # Prevent crazy values
		environment.adjustment_brightness -= amount/100
		environment.adjustment_brightness = clamp(environment.adjustment_brightness, 0.0, 2.0)  # Prevent crazy values
