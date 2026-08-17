extends RigidBody2D

@onready var label: Label = $Label

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		freeze = false
		
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	label.text = "Freeze:%s\nContactCount:%d\nSleeping:%s" % [
		freeze,
		get_contact_count(),
		sleeping
	]
		
	pass


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#print("INPUT EVENT: %s" % event)
	if event is InputEventMouseMotion and event:
		position =  get_global_mouse_position()
	pass # Replace with function body.


func _on_body_entered(body: Node) -> void:
	print("Body Entered:")

	pass # Replace with function body.
