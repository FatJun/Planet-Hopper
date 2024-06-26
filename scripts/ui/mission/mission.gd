class_name MissionUI
extends TextureRect

var one_stack_size := 32

func _ready():
	texture.pause = false


func update(value: int):
	if value <= 0:
		visible = false
	else:
		visible = true
	set_deferred("size", Vector2(value * one_stack_size, size.y))
