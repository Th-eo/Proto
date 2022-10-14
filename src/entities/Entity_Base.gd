extends CharacterBody2D

enum DAMAGE_TYPE {
	PHYSICAL,
	FIRE,
	WATER,
	ELECTRIC,
	EARTH,
}

@export var display_name: = "Entity"

@export var max_hp: int = 100
@export var cur_hp: int = 100
@export var max_mp: int = 50
@export var cur_mp: int = 50

@export var might: int = 15
@export var endurance: int = 15
@export var dexterity: int = 15
@export var wisdom: int = 15

@export var attack_power = 1
@export var defense_power = 0.05

@export var speed: int = 200
var knockback: Vector2 = Vector2(0,0)
var control_disabled = false


@export var death_anim = preload("res://src/particles/DieSmoke.tscn")

func _ready() -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	move(_delta)

func die():
	GameManager.camera_shake(0.1, 80)
	var anim = death_anim.instantiate()
	anim.global_position = global_position
	get_tree().root.add_child(anim)
	anim.set_emitting(true)
	queue_free()

func move(delta: float):
	#velocity = velocity + knockback
	move_and_slide()

func attack():
	pass

func get_stats():
	pass

func handle_hit(damage, crit_rate, crit_damage, damage_type, knockback_strength, attacker):
	pass

func crit_roll(crit_rate):
	var rng = randf()
	if crit_rate > rng:
		return true
	else:
		return false

func update_hp():
	var new_val = 0 
	new_val += cur_hp #/ max_hp 
	var tween = create_tween()
	var bar = $HPBar/Bar
	tween.tween_property(bar, "value", new_val, 0.2)
	if cur_hp <= 0:
		die()

func flash():
	$Character.material.set_shader_parameter("flash_modifier", 1)
	await get_tree().create_timer(.05).timeout
	$Character.material.set_shader_parameter("flash_modifier", 0)
