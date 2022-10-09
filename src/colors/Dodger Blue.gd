@tool
extends RichTextEffect

class_name DodgerBlue
var bbcode = "c2"

func _process_custom_fx(char_fx: CharFXTransform) -> bool:
	var color = char_fx.env.get("color", char_fx.color)
	char_fx.color = Color.DODGER_BLUE
	return true
