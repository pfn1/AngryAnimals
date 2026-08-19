class_name LevelBase
extends Node


@onready var start_position: Marker2D = $StartPosition

const ANIMAL = preload("uid://hry4tlce2bq2")


var prev_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_animal()
	SignalHub.animalDelete.connect(spawn_animal)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func spawn_animal() -> void:
	var new_animal: Animal = ANIMAL.instantiate()
	new_animal.position = start_position.position
	#new_animal.freeze = true
	call_deferred("add_child", new_animal)

	
