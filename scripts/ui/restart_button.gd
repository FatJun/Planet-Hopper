extends Sprite2D

@export var player_ui: PlayerUI
@export var color_rect: ColorRect


func _ready():
	color_rect.visible = false
	visible = false
	player_ui.player.dead.connect(_on_dead)


func _on_dead():
	visible = true
	color_rect.visible = true
