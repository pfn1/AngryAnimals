class_name Cup
extends StaticBody2D

@onready var dissappear_animation: AnimationPlayer = $DissappearAnimation


const GROUP_NAME: String = "Cup"

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)
	

func die() -> void:
	dissappear_animation.play("disappear")
	


func on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "disappear":
		SignalHub.emit_cup_destroyed()
		queue_free()
	 # Replace with function body.
