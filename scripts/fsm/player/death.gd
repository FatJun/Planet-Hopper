extends State


@onready var fsm: PlayerFSM = get_parent()


func enter() -> void:
	call_deferred("death")


func death():
	fsm.controller.visible = false
	fsm.controller.collision.disabled = true
