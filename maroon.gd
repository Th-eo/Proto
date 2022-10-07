@tool
extends RichTextEffect

class_name Maroon
var bbcode = "c5"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var color = char_fx.env.get("color", char_fx.color)
	char_fx.color = Color.MAROON
	return true
