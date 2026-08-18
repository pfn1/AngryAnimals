class_name Animal
extends RigidBody2D

#region /// On ready Node variables
@onready var label: Label = $Label
@onready var arrow: Sprite2D = $Arrow
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var kick_sound: AudioStreamPlayer2D = $KickSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound

#endregion

#region /// Constants
const DRAG_LIMIT_MAX: Vector2 = Vector2 (0, 60)
const DRAG_LIMIT_MIN: Vector2 = Vector2 (-60, 0)
const IMPULSE_MULT: float = 25.0
const IMPULSE_MAX: float = 2000
#endregion

#region /// Script variables
var _object_start: Vector2 = Vector2.ZERO #starting position of animal
var _mouse_drag_start: Vector2 = Vector2.ZERO #starting position of mounse
var _is_dragging: bool = false
var _dragged_vector: Vector2 #resulting vector after dragging mouse
var _arrow_scale_x: float = 0.0

#endregion

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("drag_input") and _is_dragging:
		call_deferred("start_release")
		


func _ready() -> void:
	_object_start = position
	_arrow_scale_x = arrow.scale.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var debug_str = "FR: %s CC: %d SL: %s\n" % [
		freeze,
		get_contact_count(),
		sleeping
	]
	debug_str += "is_dragging: %s\n drag_start: %.0f, %.0f\n" %[
		_is_dragging, _mouse_drag_start.x, _mouse_drag_start.y
	]
	
	debug_str += "drag_Vector: %.0f, %.0f\n" %[
		_dragged_vector.x, _dragged_vector.y
	]
	
	debug_str += "Impulse: %.0f, %.0f\n" %[
		calculate_impulse().x, calculate_impulse().y
	]
	
	debug_str += "ImpulseMaxLength: %.0f" %[
		calculate_impulse().length()
	]
	
	label.text = debug_str
	
func _physics_process(_delta: float) -> void:
	if _is_dragging:
		handle_dragging()

func calculate_impulse() -> Vector2:
	return _dragged_vector * IMPULSE_MULT * -1

func handle_dragging() -> void:
	var new_dragged_vector: Vector2 = get_global_mouse_position() - _mouse_drag_start
	new_dragged_vector = new_dragged_vector.clamp(DRAG_LIMIT_MIN, DRAG_LIMIT_MAX)
	
	var vector_diff: Vector2 = new_dragged_vector - _dragged_vector
	if vector_diff.length() > 0:
		stretch_sound.play()
		
	scale_arrow()
	_dragged_vector = new_dragged_vector
	position = _object_start + _dragged_vector

#initializes the drag position starts
#trigger the physics if _is_dragging = true
func start_dragging() -> void:
	_is_dragging = true
	_mouse_drag_start = get_global_mouse_position()
	arrow.show()
	#position = get_global_mouse_position()

func start_release() -> void:
	launch_sound.play()
	arrow.hide()
	_is_dragging = false
	freeze = false
	apply_central_impulse(calculate_impulse())
	
func scale_arrow() -> void:
	var impulse_len: float = calculate_impulse().length()
	var percentage: float =  clamp(impulse_len / IMPULSE_MAX, 0.0, 1.0)
	arrow.scale.x = lerpf(_arrow_scale_x, _arrow_scale_x * 2, percentage)
	arrow.rotation = (_object_start - position).angle()
	
func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("drag_input"):
		input_event.disconnect(_on_input_event)
		start_dragging()
	
