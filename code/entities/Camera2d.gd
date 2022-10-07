extends Camera2D

@export var min_zoom := 1.0
@export var max_zoom := 8.0
@export var zoom_factor := 0.2
@export var zoom_duration := 0.2

var zoom_level := 3.0

func _ready() -> void:
	zoom = Vector2(3, 3)

func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		zoom_level = (zoom_level - zoom_factor)
		set_zoom_level(zoom_level)
	if event.is_action_pressed("zoom_out"):
		zoom_level = (zoom_level + zoom_factor)
		set_zoom_level(zoom_level)

func set_zoom_level(value: float) -> void:
	zoom_level = clamp(value, min_zoom, max_zoom)
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(zoom_level, zoom_level), zoom_duration).from_current().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
