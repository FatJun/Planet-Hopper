extends Moon


func _process(delta):
	var current_level := Levels.get_current()
	global_position = current_level.global_position
	super._process(delta)
