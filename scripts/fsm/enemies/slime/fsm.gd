class_name SlimeFSM
extends FSM

@export var controller: SlimeController


var is_turning_around: bool:
	get:
		return controller.collision_ray.is_colliding()
