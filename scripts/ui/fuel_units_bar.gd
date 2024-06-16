extends AnimatedSprite2D


@export var player_ui: PlayerUI

@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready():
	player_ui.player.fuel_units_changed.connect(update)
	update()


func update():
	frame = player_ui.player.current_fuel_units
	anim_player.play("player_ui/pop")
