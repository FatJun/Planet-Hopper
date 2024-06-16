extends State

@onready var fsm: FlyEyeFSM = get_parent()


func enter():
	fsm.explosion_timer.start()


func ph_update(_delta: float) -> void:
	fsm.controller.update_direction()
	fsm.controller.update_movement_physics()
	fsm.controller.update_velocity()
	fsm.controller.move_and_slide()
