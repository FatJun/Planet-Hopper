extends State

@onready var fsm: SlimeFSM = get_parent()


func ph_update(_delta: float) -> void:
	if fsm.is_turning_around:
		fsm.controller.x_axis = -fsm.controller.x_axis
	fsm.controller.update_to_face_direction()
	fsm.controller.update_all_physics()
	fsm.controller.move_and_slide()
