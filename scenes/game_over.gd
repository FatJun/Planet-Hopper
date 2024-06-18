extends Control



func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("restart") and visible:
		Levels.reset()
		EventBus.start_the_game.emit()
		get_tree().change_scene_to_packed(Levels.levels_level)
