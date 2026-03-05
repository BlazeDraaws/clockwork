extends AnimatedSprite2D

@onready var animated_sprite_2d: AnimatedSprite2D = $"."

var drag: float = 0.0

func _ready() -> void:
	animated_sprite_2d.set_frame(randi_range(1,3)*4 - 4)
	animated_sprite_2d.play("default")

func _process(delta: float) -> void:
	# Opacity drops from 1.0 (drag = 0) to 0.25 (drag = 3)
	var target_opacity = lerp(0.0, 1.0, drag-2 )
	modulate.a = lerp(modulate.a, target_opacity, delta * 5)  # Smooth transition

func _drag(drag_level):
	print("got drag! drag is", drag_level)
	drag = clamp(drag_level, 0, 3)  # Set instance variable, not a new one
