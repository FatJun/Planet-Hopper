extends Sprite2D

@export var player_ui: PlayerUI
var control: Control


func _ready():
	control = get_parent()
	control.visible = false
	player_ui.player.dead.connect(_on_dead)


func _on_dead():
	control.visible = true
