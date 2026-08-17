class_name Animal
extends RigidBody2D

@onready var label: Label = $Label

var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _is_dragging: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_start = position
	#_drag_start = get_global_mouse_position()
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Freeze:%s\nContactCount:%d\nSleeping:%s" % [
		freeze,
		get_contact_count(),
		sleeping
	]
