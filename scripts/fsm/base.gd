class_name FSM
extends Node


@export var cur_state: State


func change_state(new_state: State) -> void:
	cur_state.exit()
	new_state.enter()
	cur_state = new_state


func _physics_process(delta: float) -> void:
	cur_state.ph_update(delta)


func _process(delta: float) -> void:
	cur_state.pr_update(delta)
