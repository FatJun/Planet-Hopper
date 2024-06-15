class_name PlayerFSM
extends FSM


@export var controller: PlayerController

@onready var states := {
	IDLE: $IDLE,
	RUN: $RUN,
	JUMP: $JUMP,
}

enum {
	IDLE,
	RUN,
	JUMP,
}

const ANIMATIONS = {
	IDLE: "idle",
	RUN: "run",
	JUMP: "jump",
}

var is_moving: bool:
	get = get_is_moving
var is_idle: bool:
	get = get_is_idle
var is_jumping: bool:
	get = get_is_jumping
var is_falling: bool:
	get = get_is_falling


func play_anim(animation: int) -> void:
	controller.sprite.play(ANIMATIONS[animation])


func get_is_moving() -> bool:
	return controller.is_on_floor() and controller.x_axis != 0


func get_is_idle() -> bool:
	return controller.is_on_floor() and controller.x_axis == 0


func get_is_jumping() -> bool:
	return controller.is_on_floor() and controller.get_normalized_vertical_velocity() > 0


func get_is_falling() -> bool:
	return controller.is_on_floor() and controller.get_normalized_vertical_velocity() < 0
