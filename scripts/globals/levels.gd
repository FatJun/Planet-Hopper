extends Node


var map: Dictionary = {}
var current := 1
var max_levels := 25
var levels_level = preload("res://scenes/levels.tscn")

func _ready():
	for i in max_levels:
		map[i] = {
			"level": null,
			"finished": false,
		}


func get_current() -> Level:
	return map[current]["level"]


func finish_current_level():
	map[current]["finished"] = true


func get_level(id: int) -> Level:
	return map[id]["level"]


func is_finished(id: int) -> bool:
	return map[id]["finished"]
