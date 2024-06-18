extends Control


var first_scene = preload("res://scenes/levels/lvl_1_d1s1_1.tscn")


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		start_the_game()


func start_the_game():
	EventBus.start_the_game.emit()
	get_tree().change_scene_to_packed(first_scene)
	
