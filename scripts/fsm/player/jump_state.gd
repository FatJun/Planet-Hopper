extends State


@onready var fsm: PlayerFSM = get_parent()


func enter() -> void:
	fsm.controller.apply_jump()
	fsm.play_anim(fsm.JUMP)


func pr_update(_delta: float) -> void:
	fsm.controller.update_x_axis()


func ph_update(_delta: float) -> void:
	if Input.is_action_just_released("jump"):
		if not fsm.controller.jetpack_timer.is_stopped():
			fsm.controller.cancel_jetpack()
	if Input.is_action_just_pressed("jump") and fsm.controller.is_can_jump:
		fsm.change_state(fsm.states[fsm.JUMP])
	elif fsm.is_moving:
		fsm.change_state(fsm.states[fsm.RUN])
	elif fsm.is_idle:
		fsm.change_state(fsm.states[fsm.IDLE])
	fsm.controller.update_to_face_direction()
	fsm.controller.update_all_physics()
	fsm.controller.move_and_slide()
