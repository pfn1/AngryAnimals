extends Node

signal animalDelete

signal cup_destroyed

signal attempt_made

func emit_animal_delete() -> void:
	animalDelete.emit()

func emit_cup_destroyed() -> void:
	cup_destroyed.emit()
	
func emit_attempt_made() -> void:
	attempt_made.emit()
