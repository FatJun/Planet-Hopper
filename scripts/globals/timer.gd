extends Node


var timer: Timer
@export var max_time := 15 * 60
var game_over_scene = preload("res://scenes/game_over_scene.tscn")


func _ready():
	timer = Timer.new()
	timer.wait_time = max_time
	timer.one_shot = true
	add_child(timer)
	EventBus.time_freezed.connect(func(): timer.paused = true)
	EventBus.time_unfreezed.connect(func(): timer.paused = false)
	timer.timeout.connect(func(): get_tree().change_scene_to_packed(game_over_scene))
	EventBus.start_the_game.connect(func(): timer.start())
