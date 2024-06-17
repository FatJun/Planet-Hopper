extends State

@onready var fsm: LizardFSM = get_parent()


func enter() -> void:
	fsm.play_anim(fsm.IDLE)


func ph_update(_delta: float) -> void:
	if fsm.is_moving:
		fsm.change_state(fsm.states[fsm.RUN])
	elif fsm.is_attacking:
		fsm.change_state(fsm.states[fsm.ATTACK])
	fsm.controller.update_to_face_direction()
	fsm.controller.update_all_physics()
	fsm.controller.move_and_slide()
