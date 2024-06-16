extends PickableItem


@export var mission_progress = 1


func apply_effect(player: PlayerController):
	player.current_fuel_units += fuel_units
