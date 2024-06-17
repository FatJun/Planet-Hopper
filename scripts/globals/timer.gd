extends Node


var timer: Timer
@export var max_time := 15 * 60


func _ready():
	timer = Timer.new()
	timer.wait_time = max_time
	timer.one_shot = true
	add_child(timer)
	timer.start()
