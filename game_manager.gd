extends Node

@onready var player = get_tree().get_first_node_in_group("player")
@onready var system = get_tree().get_first_node_in_group("system")

func _ready() -> void:
	system.change_hat.connect(update_hat)
	system.change_hair.connect(update_hair)
	system.change_armor.connect(update_armor)
	system.change_haircolor.connect(update_haircolor)

func update_hat(index):
	var hat = player.find_child("Hat", true, false)
	match index:
		0:
			hat.set_texture(load(""))
		1:
			hat.set_texture(load("res://assets/sprites/Hats.png"))

func update_hair(index):
	var hair = player.find_child("Hair", true, false)
	match index:
		0:
			hair.set_texture(load(""))
		1:
			hair.set_texture(load("res://assets/sprites/Hairstyles.png"))
			hair.frame = 1
		2: 
			hair.set_texture(load("res://assets/sprites/Hairstyles.png"))
			hair.frame = 2
		3:
			hair.set_texture(load("res://assets/sprites/Hairstyles.png"))
			hair.frame = 3

func update_armor(index):
	var armor = player.find_child("Armor", true, false)
	match index:
		0:
			armor.set_texture(load(""))
		1:
			armor.set_texture(load("res://assets/sprites/Armor_001.png"))

func update_haircolor(index):
	var hair = player.find_child("Hair", true, false)
	hair.material.set_shader_parameter("ison", true)
	match index:
		0: # Sienna
			hair.material.set_shader_parameter("palette", load("res://assets/sprites/palettes/sienna.png"))
		1: # Amber
			hair.material.set_shader_parameter("palette", load("res://assets/sprites/palettes/amber.tres"))
		2: # Pink Quartz
			hair.material.set_shader_parameter("palette", load("res://assets/sprites/palettes/pinkquartz.png"))
		3: # Ash
			hair.material.set_shader_parameter("palette", load("res://assets/sprites/palettes/ash.png"))
		4: # Emerald
			hair.material.set_shader_parameter("palette", load("res://assets/sprites/palettes/emerald.png"))
		5: # Saphire
			hair.material.set_shader_parameter("palette", load("res://assets/sprites/palettes/sapphire.png"))


