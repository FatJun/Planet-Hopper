extends Camera2D

var speed := 500.


func _process(delta):
	global_position += Vector2.RIGHT * speed * delta
