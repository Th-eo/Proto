extends "res://src/entities/Entity_Base.gd"

signal emit_message
var update_sprite = true
@onready var sprite = $SpriteContainer/Body
@onready var anim_player = $SpriteContainer/AnimationPlayer

func _process(_delta: float) -> void:
	$SpriteContainer/Armor.frame = $SpriteContainer/Body.frame
	$SpriteContainer/Armor.visible = true

func _ready() -> void:
	anim_player.play("idle")

func _physics_process(_delta: float) -> void:
	move()

func move():
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

func attack():
	emit_signal("emit_message", "Player attacked.")
	update_sprite = false
	anim_player.play("cast")
	await get_tree().create_timer(.25).timeout
	update_sprite = true

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
		attack()

