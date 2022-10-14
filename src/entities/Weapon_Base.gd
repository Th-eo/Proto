extends Node2D

enum {
	PHYSICAL,
	FIRE,
	WATER,
	ELECTRIC,
	EARTH,
}

@export var damage = 10
@export var crit_rate = 0.25
@export var crit_damage = 2.0
@export var damage_type = PHYSICAL
@export var knockback_strength = 200

@export var radius = 10

signal hit_enemy

func locate():
	var distance = get_global_mouse_position()-self.get_global_position()
	rotation = distance.angle()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_hurtbox"):
		damage *= get_owner().attack_power
		var attacker = get_owner()
		area.get_owner().handle_hit(damage, crit_rate, crit_damage, damage_type, knockback_strength, attacker)
		
