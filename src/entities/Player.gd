extends "res://src/entities/Entity_Base.gd"

signal emit_message
@onready var sprite = $Character
@onready var anim_player = $AnimationPlayer
@onready var weapon = $Weapon
var xscale = scale.x
var yscale = scale.y
var xflip = false
@onready var weapon_path = preload("res://src/entities/Weapon_Base.tscn")

func _process(_delta: float) -> void:
	pass

func _ready() -> void:
	$HPBar.visible = false

func _physics_process(_delta: float) -> void:
	if control_disabled != true: 
		move(_delta)
	else: 
		move_and_slide()
	

func move(delta: float):
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	if direction.length() > 1.0:
		direction = direction.normalized()
	velocity = speed * direction
	var colliding = move_and_slide()
	if colliding == false and velocity != Vector2.ZERO:
		anim_player.play("walk")
	else:
		anim_player.play("idle")
	if direction.x > 0:
			xflip = false
	elif direction.x < 0:
			xflip = true
	try_flip()
	#print(velocity, knockback)

func try_flip():
	if xflip:
		$Character.flip_h = true
	else:
		$Character.flip_h = false


func attack():
	var distance = get_global_mouse_position()-self.get_global_position()
	var angle = distance.angle()
	if angle >= 1.5 or angle <= -1.5:
		xflip = true
	else: xflip = false
	try_flip()
	var mouse = get_viewport().get_mouse_position()
	#if mouse.x < position.x:
	#	pass#weapon.scale.x *= -1
	control_disabled = true
	velocity = Vector2(0, 0)
	anim_player.play("cast")
	weapon.locate()
	weapon.get_node("AnimationPlayer").play("swing")
	await weapon.get_node("AnimationPlayer").animation_finished
	weapon.get_node("AnimationPlayer").play("RESET")
	control_disabled = false

func _unhandled_input(event):
	if control_disabled == true:
		pass
	else:
		if event.is_action_pressed("attack"):
			attack()

func handle_hit(damage, crit_rate, crit_damage, damage_type, knockback_strength, attacker):
	var final_damage = damage
	var crit_sucess = crit_roll(crit_rate)
	if crit_sucess:
		final_damage *= crit_damage
		knockback_strength *= 1.5
		GameManager.emit_message(str(display_name) + " has taken [color=e54f59]"+ str(final_damage) + " critical damage[/color].")
	else:
		GameManager.emit_message(str(display_name) + " has taken "+ str(final_damage) + " damage.")
	if final_damage > 0:
		cur_hp -= final_damage
		flash()
	if cur_hp != max_hp:
		$HPBar.visible = true
	update_hp()
	if knockback_strength != 0:
		control_disabled = true
		var final_velocity = attacker.position.direction_to(position) * knockback_strength
		velocity = final_velocity
		print(attacker.name)
		var tween = create_tween()
		tween.tween_property(self, "velocity", Vector2(0,0), 0.25)
		await tween.finished
		control_disabled = false
	GameManager.show_damage(final_damage, global_position, crit_sucess)
