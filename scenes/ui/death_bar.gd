class_name DeathBar
extends BaseBar


func _ready():
	refill()


func _process(_delta):
	current_value_ = remap(GlobalTimer.timer.time_left, 1, GlobalTimer.max_time, min_value, max_value_)
	modulate.r = remap(current_value_, 0, GlobalTimer.max_time, 0, 1)
	modulate.g = remap(current_value_, 0, GlobalTimer.max_time, 1, 0)
	update()
