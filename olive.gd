@tool
extends RichTextEffect

class_name Olive
var bbcode = "c4"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var color = char_fx.env.get("color", char_fx.color)
	char_fx.color = Color.OLIVE
	return true
