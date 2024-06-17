extends Camera2D

@export var scroll_speed := 500.


func _process(delta):
	var direction = global_position.direction_to(get_global_mouse_position())
	var velocity: Vector2 = direction * scroll_speed * delta
	global_position.x += velocity.x
