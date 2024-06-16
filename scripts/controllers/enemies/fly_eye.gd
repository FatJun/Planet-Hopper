class_name FlyEyeController
extends PlatformerController


var avoid_object_velocity := Vector2.ZERO
var target: PlayerController
@export var explosion_damage := 1
@export var knockback_force := 800



func update_direction(axis: float = 0.) -> void:
	if target:
		direction = (target.global_position - global_position).normalized()
