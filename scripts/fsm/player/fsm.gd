class_name PlayerFSM
extends FSM


@export var controller: PlayerController


@onready var states := {
	IDLE: $IDLE,
	RUN: $RUN,
	JUMP: $JUMP,
	FALL: $FALL,
	JETPACK: $JETPACK,
	DEATH: $DEATH,
	ENTER_IN_SPACESHIP: $ENTER_IN_SPACESHIP,
}

enum {
	IDLE,
	RUN,
	JUMP,
	FALL,
	JETPACK,
	DEATH,
	ENTER_IN_SPACESHIP,
}

const ANIMATIONS = {
	IDLE: "idle",
	RUN: "run",
	JUMP: "jump",
	FALL: "fall",
	JETPACK: "jetpack",
	DEATH: "",
	ENTER_IN_SPACESHIP: "",
}

var is_moving: bool:
	get:
		return controller.is_on_floor() and controller.x_axis != 0
var is_idle: bool:
	get:
		return controller.is_on_floor() and controller.x_axis == 0
var is_jumping: bool:
	get:
		return not controller.is_on_floor() and controller.get_normalized_vertical_velocity() > 0
var is_falling: bool:
	get:
		return not controller.is_on_floor() and controller.get_normalized_vertical_velocity() < 0
var is_entering_in_spaceship: bool:
	get:
		return (
			controller.in_landing_zone 
			and controller.current_mission_progress >= controller.max_mission_progress 
			and Input.is_action_just_pressed("enter_in_spaceship")
		)


func play_anim(animation: int) -> void:
	controller.sprite.play(ANIMATIONS[animation])


func _process(delta):
	super._process(delta)
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()


func _on_player_dead():
	change_state(states[DEATH])
