extends PickableItem


@export var freeze_duration := 5.


func apply_effect(player: PlayerController):
	EventBus.freeze_time(freeze_duration)
