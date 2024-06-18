extends Node


signal time_freezed
signal time_unfreezed
signal started_fly_away
signal start_the_game

var freeze_timer: Timer


func _ready():
	freeze_timer = Timer.new()
	freeze_timer.one_shot = true
	add_child(freeze_timer)
	freeze_timer.timeout.connect(_on_freeze_timer_timeout)


func freeze_time(duration: float):
	freeze_timer.wait_time = duration
	time_freezed.emit()
	freeze_timer.start()


func _on_freeze_timer_timeout():
	time_unfreezed.emit()
