extends Node

@onready var player = get_tree().get_first_node_in_group("player")
@onready var system = get_tree().get_first_node_in_group("system")
@onready var world_scene = get_tree().get_first_node_in_group("world")
@onready var damage_numbers = preload("res://src/ui/Damage Indicator.tscn")

func _ready() -> void:
	if system != null:
		pass
	if player != null:
		player.emit_message.connect(emit_message)
	world_scene.scene_changed.connect(reset)

func reset():
	pass

func emit_message(msg):
	if system != null:
		system.add_message(msg)
	pass

func show_damage(damage, pos, crit):
	var numbers = damage_numbers.instantiate()
	numbers.global_position = pos
	get_tree().root.add_child(numbers)
	if crit == true:
		numbers.set_modulate(Color(0.9, 0.31, 0.35, 1))
	numbers.show_damage(damage, crit)

func camera_shake(time, strength):
	player.get_node("Camera2d").shake_amount = strength
	player.get_node("Camera2d").shake_duration = time
	player.get_node("Camera2d").set_process(true)
