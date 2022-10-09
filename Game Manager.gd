extends Node

@onready var player = get_tree().get_first_node_in_group("player")
@onready var system = get_tree().get_first_node_in_group("system")

func _ready() -> void:
	system.change_hat.connect(update_hat)
	system.change_hair.connect(update_hair)
	system.change_armor.connect(update_armor)
	system.change_haircolor.connect(update_haircolor)
	system.change_body.connect(update_body)
	player.emit_message.connect(emit_message)

func emit_message(msg):
	system.add_message(msg)
	pass

func update_body(index):
	var body = player.find_child("Body", true, false)
	var string = "res://src/assets/sprites/Character/Char_"+str(index).pad_zeros(3)+".png"
	body.set_texture(load(string))
	print(string)
	var msg = "Player updated body to " + Customization.bodies[index] + "."
	system.add_message(msg)

func update_hat(index):
	var hat = player.find_child("Hat", true, false)
	hat.frame = index
	var msg = "Player updated hat to " + Customization.hats[index] + "."
	system.add_message(msg)

func update_hair(index):
	var hair = player.find_child("Hair", true, false)
	hair.frame = index
	var msg = "Player updated hair to " + Customization.hairstyles[index] + "."
	system.add_message(msg)

func update_armor(index):
	var armor = player.find_child("Armor", true, false)
	match index:
		0:
			armor.set_texture(load(""))
		1:
			armor.set_texture(load("res://src/assets/sprites/Character/Armor_001.png"))
	var msg = "Player updated armor to " + Customization.armors[index] + "."
	system.add_message(msg)

func update_haircolor(index):
	var hair = player.find_child("Hair", true, false)
	hair.material.set_shader_parameter("palette", load(Customization.get_haircolor_file(index)))
