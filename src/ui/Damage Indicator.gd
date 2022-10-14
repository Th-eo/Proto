extends Node2D

@onready var label = $RichTextLabel

func show_damage(number, crit):
	self.position.x += 50
	self.position.y -= 15
	if crit == true:
		label.set_text(str(number)+"[i] ![/i]")
	else:
		label.set_text(str(number))
	$AnimationPlayer.play("show_damage")
	await $AnimationPlayer.animation_finished
	queue_free()

func _process(_delta: float) -> void:
	pass
