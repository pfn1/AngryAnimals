class_name GameUi
extends Control

@onready var vb_complete: VBoxContainer = $VbComplete
@onready var music: AudioStreamPlayer = $Music
@onready var attempt_count: Label = $MarginContainer/VBoxContainer/AttemptHorizontalContainer/AttemptCount
@onready var levelvalue: Label = $MarginContainer/VBoxContainer/LevelHorizontalContainer/Levelvalue


const MAIN = preload("uid://dwtd3gppj3ncn")

var _total_cups: int = 0
var _current_cups: int = 0
var _attempts: int = -1

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_packed(MAIN)
		

func _ready() -> void:
	get_tree().paused = false
	_total_cups = get_tree().get_nodes_in_group(Cup.GROUP_NAME).size()
	SignalHub.cup_destroyed.connect(remove_cup)
	SignalHub.attempt_made.connect(on_attempts_made)
	on_attempts_made()

func on_attempts_made():
	_attempts += 1
	attempt_count.text = "%02d" % _attempts


func remove_cup() -> void:
	_current_cups += 1
	if _current_cups == _total_cups:
		vb_complete.show()
		music.play()
		ScoreManager.set_score_for_current_Level(_attempts)
		get_tree().paused = true
		
