extends Marker2D


var min_distance = 350
var max_ping_time = 8
var visible_time = 4
var visible_timer: Timer
var ping_timer: Timer
var red_distance := 4000
var cant_change_visible := false


func _ready():
	visible_timer = Timer.new()
	ping_timer = Timer.new()
	visible_timer.one_shot = true
	ping_timer.one_shot = true
	visible_timer.wait_time = visible_time
	add_child(visible_timer)
	add_child(ping_timer)
	ping_timer.timeout.connect(
		func():
			visible_timer.start()
			if not cant_change_visible:
				visible = true
	)
	visible_timer.timeout.connect(
		func():
			ping_timer.wait_time = randf() * max_ping_time
			ping_timer.start()
			visible = false
	)
	visible = false
	ping_timer.wait_time = randf() * max_ping_time
	ping_timer.start()


func _process(delta):
	if Levels.current < Levels.max_levels:
		var level: Level = Levels.next_level()
		var distance: float = global_position.distance_to(level.global_position)
		$Ping.modulate.r = remap(distance, 0, red_distance, 0, 1)
		$Ping.modulate.g = remap(distance, 0, red_distance, 1, 0)
		
		look_at(level.global_position)
		if global_position.distance_to(level.global_position) < min_distance:
			visible = false
			cant_change_visible = true
		else:
			cant_change_visible = false
	else:
		visible = false
