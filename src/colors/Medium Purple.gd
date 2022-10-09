@tool
extends RichTextEffect

class_name MediumPurple
var bbcode = "c3"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var color = char_fx.env.get("color", char_fx.color)
	char_fx.color = Color.MEDIUM_PURPLE
	return true
