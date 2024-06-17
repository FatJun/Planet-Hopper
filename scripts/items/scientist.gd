extends PickableItem


@export var mission_progress = 1


func apply_effect(player: PlayerController):
	player.current_mission_progress += mission_progress

