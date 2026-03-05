# Inside your Camera2D.gd or Camera3D.gd script
extends Camera2D

var shake_time = 0.0
var shake_strength = 0.0

func _process(delta):
	if shake_time > 0:
		shake_time -= delta
		offset = Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
	else:
		offset = Vector2.ZERO  # Reset when done
		shake_time = 0.0
		shake_strength = 0.0


func _more_glow(strength):
	
	shake_time = 0.2
	shake_strength += strength/20 + 0.5
	print("shaking!! " , shake_strength)
