extends Control

@onready var chatLog = get_node("VBoxContainer/HBoxContainer3/RichTextLabel")
@onready var inputField = get_node("VBoxContainer/HBoxContainer/LineEdit")
var placeholder_text = "Press [ENTER] to type."

signal change_hat
signal change_hair
signal change_armor
signal change_haircolor
signal change_body

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.physical_keycode == KEY_ENTER:
			inputField.grab_focus()
			inputField.placeholder_text = ""
		if event.pressed and event.physical_keycode == KEY_ESCAPE:
			inputField.release_focus()
			inputField.text = ""
			inputField.placeholder_text = placeholder_text

func add_message(text):
	chatLog.append_text(text)
	chatLog.newline()
	chatLog.scroll_to_line(chatLog.get_line_count())

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text != "":
		var time = Time.get_time_dict_from_system()
		var time_return = str(time.hour).pad_zeros(2) +":"+str(time.minute).pad_zeros(2)+":"+str(time.second).pad_zeros(2)
		new_text = "[color=1E90FF][" + time_return + "][/color] " + new_text
		add_message(new_text)
		inputField.text = ""

func _on_armor_option_item_selected(index: int) -> void:
	emit_signal("change_armor", index)

func _on_hat_option_item_selected(index: int) -> void:
	emit_signal("change_hat", index)
	
func _on_hairstyle_option_item_selected(index: int) -> void:
	emit_signal("change_hair", index)

func _on_color_option_item_selected(index: int) -> void:
	emit_signal("change_haircolor", index)

func _on_line_edit_focus_entered() -> void:
	pass # Replace with function body.

func _on_body_option_item_selected(index: int) -> void:
	emit_signal("change_body", index)
