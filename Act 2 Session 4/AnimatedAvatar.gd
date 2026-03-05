extends AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

#var idle2tween = create_tween()
#var idletween = create_tween()
#var downedtween = create_tween()
var free_turn: bool = true
var start_pos = position
var dragtween: Tween
var mat := self.material as ShaderMaterial
var desaturation = 0.0
var drag = 0.0
var opacity = 1.0
@export var backing: bool = false

func _downed(downed):
		if downed:
			self.stop()
			animation_player.play("DownedTween")
			self.play("Downed")
		else:
			self.stop()
			self.play("Idle")

func _ready() -> void:
	var mat := self.material as ShaderMaterial
	if mat:
		mat.set("shader_parameter/desaturate_strength", 0.0)
	else:
		push_warning("Material is not a ShaderMaterial.")

func _process(delta: float) -> void:
	if mat:
		mat.set("shader_parameter/desaturate_strength", desaturation)
		mat.set("shader_parameter/opacity", opacity)

func _universal_beat_reciever(beat, swinging, is_pull_mode, speed, dragset, notetype, usage, current_group):
	print("[" + current_group + "] _universal_beat_reciever: " + self.name + " recieved Info! ", swinging, is_pull_mode, beat)
	drag = dragset
	var dragtween = create_tween()
	var clamped_drag = clamp(drag, -2,4)
	dragtween.tween_property(self,"desaturation", clamped_drag/4, 5.0)

func _PlayerAnim(animID):
		if animation != animID:
			play(animID)
			animation_player.play(animID)

func reset():
	#var reset = create_tween()
	#reset.EASE_IN_OUT
	#reset.parallel().tween_property(self,"position",start_pos + Vector2(0,0),1)
	#reset.parallel().tween_property(self,"rotation_degrees",0, 1)
	#reset.kill()
	pass
