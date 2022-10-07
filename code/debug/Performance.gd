extends Label

func _process(delta):
	set_text("FPS: " + str(Performance.get_monitor(Performance.TIME_FPS)))
