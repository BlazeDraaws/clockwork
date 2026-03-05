extends AnimatedSprite2D
var type = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play("light")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _universal_beat_reciever(beat, swinging, is_pull_mode, speed, drag, notetype, usage, current_group):
	print("[" + current_group + "] _universal_beat_reciever: " + self.name + " recieved Info!")
	type = notetype
	
	pass

func _enter(notetype):
	type = notetype
	_notetype()

func _notetype():
	match type:
		1:
			self.stop()
			self.play("light")
		2:
			self.stop()
			self.play("standard")
		3:
			self.stop()
			self.play("heavy")
		4:
			self.stop()
			self.play("ult")


func _on_animation_finished() -> void:
	print("_universal_beat_reciever: " + self.name + " animation finished")
	if type == 4:
		self.play("ult_loop")
