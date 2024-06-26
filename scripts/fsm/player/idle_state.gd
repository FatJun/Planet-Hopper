extends State


@onready var fsm: PlayerFSM = get_parent()


func enter() -> void:
	fsm.controller.reset_jumps()
	fsm.play_anim(fsm.IDLE)


func pr_update(_delta: float) -> void:
	fsm.controller.update_x_axis()


func ph_update(_delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		if fsm.controller.is_can_jump:
			fsm.change_state(fsm.states[fsm.JUMP])
		elif fsm.controller.is_can_use_jetpack:
			fsm.change_state(fsm.states[fsm.JETPACK])
	elif fsm.is_falling:
		fsm.change_state(fsm.states[fsm.FALL])
	elif fsm.is_entering_in_spaceship:
		fsm.change_state(fsm.states[fsm.ENTER_IN_SPACESHIP])
	elif fsm.is_moving:
		fsm.change_state(fsm.states[fsm.RUN])
	fsm.controller.update_to_face_direction()
	fsm.controller.update_all_physics()
	fsm.controller.move_and_slide()
