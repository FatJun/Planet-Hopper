extends State


@onready var fsm: PlayerFSM = get_parent()


func enter() -> void:
	fsm.controller.visible = false
	fsm.controller.collision.disabled = true
	fsm.controller.space_ship.fly_away()