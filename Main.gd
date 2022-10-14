extends Node2D

signal scene_changed

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
		emit_signal("scene_changed")
