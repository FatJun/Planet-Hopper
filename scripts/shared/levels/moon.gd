class_name Moon
extends Marker2D


@export var rotation_speed: float = 30

var target_rotation: float = 0.0


func _process(delta):
	target_rotation += deg_to_rad(rotation_speed) * delta
	rotation = lerp_angle(rotation, target_rotation, 0.1)
