extends PickableItem

@export var heal_amout := 2


func apply_effect(player: PlayerController):
	player.current_health += heal_amout
