class_name LizardFSM
extends FSM


@export var controller: LizardController


@onready var states := {
	IDLE: $IDLE,
	RUN: $RUN,
	ATTACK: $ATTACK,
}

enum {
	IDLE,
	RUN,
	ATTACK,
}

const ANIMATIONS = {
	IDLE: "idle",
	RUN: "run",
	ATTACK: "attack",
}

var is_moving: bool:
	get:
		return controller.x_axis != 0
var is_idle: bool:
	get:
		return controller.x_axis == 0
var is_attacking: bool:
	get:
		return controller.enemies_in_vision_zone.size() > 0
var is_turning_around: bool:
	get:
		return controller.collision_ray.is_colliding()

func play_anim(animation: int) -> void:
	controller.sprite.play(ANIMATIONS[animation])
	
