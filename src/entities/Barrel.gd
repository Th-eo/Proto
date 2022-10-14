extends "res://src/entities/Entity_Base.gd"

var activated = false
var damage = 50
var crit_rate = 1
var crit_damage = 1
var damage_type = "Fire"
var knockback_strength = 250

func _ready() -> void:
	$BarrelTriggerSmoke.set_emitting(false)

func handle_hit(damage, crit_rate, crit_damage, damage_type, knockback_strength, attacker):
	barrelTrigger()

func barrelDie():
	pass

func barrelTrigger():
	$BarrelAnimationPlayer.play("triggered")
	activated = true

func _on_barrel_animation_player_animation_finished(anim_name: StringName) -> void:
	$HitBox/CollisionShape2d.disabled = false
	for x in 12:
		var smoke = death_anim.instantiate()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		smoke.position.x = position.x + rng.randf_range(-42, 42)
		smoke.position.y = position.y + rng.randf_range(-42, 42)
		get_tree().root.add_child(smoke)
		smoke.set_emitting(true)


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_hurtbox") or area.is_in_group("player_hurtbox"):
		var attacker = self
		area.get_owner().handle_hit(damage, crit_rate, crit_damage, damage_type, knockback_strength, attacker)
		queue_free()
