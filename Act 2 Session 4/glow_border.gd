extends Sprite2D

func _ready() -> void:
	# Set the initial opacity to 0
	self.modulate.a = 0.0

# Function to be called when the beat is set (triggered by other event)
func _Set_Beat(number_value):
	# Set the opacity to 100% immediately, and start fading it back to 0
	print("GLOWING")
	self.modulate.a = 1.0

# Update the fade process over time
func _process(delta: float) -> void:

		

		

		# When fade is done, stop the process
		if self.modulate.a > 0.01:
			self.modulate.a = lerp(self.modulate.a, 0.0, delta * 5)
			
		else:
			self.modulate.a = 0
