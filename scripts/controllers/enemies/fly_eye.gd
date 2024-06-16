class_name FlyEyeController
extends PlatformerController


var avoid_object_velocity := Vector2.ZERO
var target: PlayerController
@export var collision_raycast: RayCast2D
@export var explosion_damage := 1
@export var knockback_force := 800



func update_direction(axis: float = 0.) -> void:
	if target:
		direction = (target.global_position - global_position).normalized()
		collision_raycast.scale.x = -collision_raycast.scale.y if direction.x < 0 else collision_raycast.scale.y
