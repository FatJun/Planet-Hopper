extends Node


var map: Dictionary = {}
var finished_levels := 0
var current := 1
var max_levels := 15
var levels_level = preload("res://scenes/levels.tscn")
var winning_scene = preload("res://scenes/winning_scene.tscn")

func reset():
	_ready()
	current = 1
	finished_levels = 0

func _ready():
	for i in max_levels:
		map[i + 1] = {
			"level": null,
			"finished": false,
		}


func get_current() -> Level:
	return map[current]["level"]


func finish_current_level():
	finished_levels += 1
	map[current]["finished"] = true
	if finished_levels >= max_levels:
		get_tree().change_scene_to_packed(winning_scene)


func get_level(id: int) -> Level:
	return map[id]["level"]


func next_level() -> Level:
	for i in max_levels:
		if i >= max_levels:
			return map[i]["level"]
		if not is_finished(i + 1):
			return map[i + 1]["level"]
	return get_current()


func is_finished(id: int) -> bool:
	return map[id]["finished"]
