extends Button

@export var Action: String
@export var Colour_Toggle: bool
@export var Colour: Color
signal _action(ID)
signal _KeyOut(Colour)

func _ready() -> void:
	text = Action

func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if Colour_Toggle:
		_KeyOut.emit(Colour)
	else:
		_action.emit(Action)
