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


func play_animation(animation_name: String):
	controller.sprite.play(animation_name)


func get_is_moving():
	return controller.is_on_floor() and controller.x_axis != 0


func get_is_idle():
	return controller.is_on_floor() and controller.x_axis == 0
