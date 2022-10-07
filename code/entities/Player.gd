extends CharacterBody2D

@export var speed := 200
var update_sprite = true
@onready var sprite = $SpriteContainer/Character
@onready var anim_player = $SpriteContainer/AnimationPlayer

func _process(_delta: float) -> void:
	$SpriteContainer/Armor.frame = $SpriteContainer/Character.frame
	$SpriteContainer/Armor.visible = true

func _ready() -> void:
	anim_player.play("idle")

func _physics_process(_delta: float) -> void:
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	if direction.length() > 1.0:
		direction = direction.normalized()
	velocity = speed * direction
	var colliding = move_and_slide()
	if colliding == false and velocity != Vector2.ZERO and update_sprite == true:
		anim_player.play("walk")
	elif update_sprite == true:
		anim_player.play("idle")

func _unhandled_input(event):
	if event.is_action_pressed("move_right"):
		$SpriteContainer.scale = Vector2(1, 1)
	elif event.is_action_pressed("move_left"):
		$SpriteContainer.scale = Vector2(-1, 1)
	elif get_global_mouse_position().x > get_global_position().x:
		$SpriteContainer.scale = Vector2(1, 1)
	elif get_global_mouse_position().x < get_global_position().x:
		$SpriteContainer.scale = Vector2(-1, 1)
	if event.is_action_pressed("attack"):
		update_sprite = false
		await get_tree().create_timer(.25).timeout
		update_sprite = true

