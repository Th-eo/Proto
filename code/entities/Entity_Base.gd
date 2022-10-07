extends CharacterBody2D

@export var max_hp: int = 100
@export var max_mp: int = 50
@export var might: int = 15
@export var endurance: int = 15
@export var dexterity: int = 15
@export var wisdom: int = 15

@export var speed: int = 200

func _ready() -> void:
	pass # Replace with function body.
	
func _physics_process(_delta: float) -> void:
	move()

func die():
	queue_free()

func move():
	move_and_slide()

func get_stats():
	pass
