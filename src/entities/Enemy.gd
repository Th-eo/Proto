extends "res://src/entities/Entity_Base.gd"

enum STATE {
	IDLE,
	WANDER,
	CHASE,
	STRAFE,
	RETURN,
	ATTACK,
}
var state = STATE.IDLE

var target = null
var target_position = Vector2()
var spawn_position
var direction = Vector2()
var last_state = null
var o_speed = speed

func _ready() -> void:
	spawn_position = global_position
	state = STATE.IDLE

func _process(delta: float) -> void:
	if target == null:
		state = STATE.WANDER

func move(delta: float):
	if state != last_state: 
		last_state = state
		print(STATE.keys()[state])
	match state:
		STATE.IDLE: # Look for player
			pass
		STATE.WANDER: # ?
			pass
		STATE.CHASE: # Chasing player
			pass
		STATE.STRAFE: # Within player distance, keep self at radius for a while
			pass
		STATE.RETURN: # Return to spawn box
			pass
		STATE.ATTACK:
			pass
	move_and_slide()

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
		var final_velocity = attacker.position.direction_to(position) * knockback_strength
		velocity = final_velocity
		var tween = create_tween()
		tween.tween_property(self, "velocity", Vector2(0,0), 0.25)
	GameManager.show_damage(final_damage, global_position, crit_sucess)


func _on_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("player_hurtbox"):
		state = STATE.CHASE
		target = GameManager.player


func _on_detection_area_exited(area: Area2D) -> void:
	state = STATE.RETURN
	target = null
