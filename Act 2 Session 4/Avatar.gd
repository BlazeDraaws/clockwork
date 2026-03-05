extends Sprite2D
var idle2tween = create_tween()
var idletween = create_tween()
var downedtween = create_tween()
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
			if backing:
				show()
			else:
				hide()
		else:
			if backing:
				hide()
			else:
				show()

func _ready() -> void:
	
	
	
	var mat := self.material as ShaderMaterial
	if mat:
		mat.set("shader_parameter/desaturate_strength", 0.0)
	else:
		push_warning("Material is not a ShaderMaterial.")
	
	idletween.set_trans(Tween.TRANS_SINE)
	idle2tween.set_trans(Tween.TRANS_SINE)
	
	idletween.tween_property(self,"position",start_pos + Vector2(0,+10),1+drag/5)
	idle2tween.tween_property(self,"rotation_degrees",5, 2+drag/5)
	idletween.tween_property(self,"position",start_pos + Vector2(0,0),1+drag/5)
	idle2tween.tween_property(self,"rotation_degrees",0, 2+drag/5)
	
	idletween.set_loops()
	idle2tween.set_loops()

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
	
	
	
	var swingtween = create_tween()
	if beat <= 0:
		
		swingtween.set_trans(Tween.TRANS_SINE)
		swingtween.tween_property(self,"rotation_degrees",0, 0.7+drag/5)
		activeanimation()
	else:
		stopactiveanimation()
		if swinging == true:
			swingtween.play()
			swingtween.EASE_OUT
			swingtween.set_trans(Tween.TRANS_SINE)
			if is_pull_mode:
				swingtween.tween_property(self,"rotation_degrees",10, 0.7+drag/5)
			else:
				swingtween.tween_property(self,"rotation_degrees",-10, 0.7+drag/5)
		else:
			swingtween.tween_property(self,"rotation_degrees",0, 0.7+drag/5)


func activeanimation():
	if free_turn:
		free_turn = false
		idletween.play()
		idle2tween.play()
		idletween.tween_property(self,"position",start_pos + Vector2(0,0),1)
		idle2tween.tween_property(self,"rotation_degrees",0, 2)
		print("_universal_beat_reciever: " + self.name + " playing")



func stopactiveanimation():
	idletween.pause()
	idle2tween.pause()
	reset()
	print("_universal_beat_reciever: " + self.name + " pausing")
	free_turn = true

func reset():
	var reset = create_tween()
	reset.EASE_IN_OUT
	reset.parallel().tween_property(self,"position",start_pos + Vector2(0,0),1)
	reset.parallel().tween_property(self,"rotation_degrees",0, 1)
	reset.kill()
