class_name FlyEyeFSM
extends FSM

@export var time_till_exposion := 5.
@export var controller: FlyEyeController

var hitted := false


@onready var states := {
	IDLE: $IDLE,
	CHASE: $CHASE,
	EXPLOSION: $EXPLOSION,
}

enum {
	IDLE,
	CHASE,
	EXPLOSION,
}

const ANIMATIONS = {
	IDLE: "default",
	CHASE: "default",
	EXPLOSION: "explosion",
}

var explosion_timer: Timer


func _ready():
	explosion_timer = Timer.new()
	explosion_timer.one_shot = true
	explosion_timer.wait_time = time_till_exposion
	add_child(explosion_timer)
	explosion_timer.timeout.connect(_on_explosion_timer_timeout)


func _on_explosion_timer_timeout():
	if cur_state != states[EXPLOSION]:
		change_state(states[EXPLOSION])


func play_anim(animation: int) -> void:
	controller.sprite.play(ANIMATIONS[animation])
	


func _on_agression_zone_body_entered(body):
	if body.is_in_group("player") and cur_state != states[EXPLOSION]:
		controller.target = body
		change_state(states[CHASE])


func _on_burst_zone_body_entered(body):
	if body.is_in_group("player") and cur_state != states[EXPLOSION]:
		hitted = true
		change_state(states[EXPLOSION])
