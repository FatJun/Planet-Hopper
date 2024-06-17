extends Area2D


func _process(delta):
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("mouse_left") and not has_overlapping_areas():
		%LevelsCamera.set_target(null)
