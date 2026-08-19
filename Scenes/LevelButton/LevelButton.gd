extends TextureButton

@export var level_number: int = 1
@onready var level_label: Label = $MarginContainer/VB/LevelLabel
@onready var score_label: Label = $MarginContainer/VB/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = str(level_number)
	score_label.text = "%4d" % ScoreManager.get_level_best(level_number)

func _on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)

func _on_mouse_exited() -> void:
	scale = Vector2(1.0, 1.0)

func _on_pressed() -> void:
	ScoreManager.level_selected = level_number
	get_tree().change_scene_to_file("res://Scenes/LevelBase/Level%d.tscn" % level_number)
