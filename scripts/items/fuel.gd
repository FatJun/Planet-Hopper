extends PickableItem


@export var fuel_units := 1


func apply_effect(player: PlayerController):
	player.current_fuel_units += fuel_units
