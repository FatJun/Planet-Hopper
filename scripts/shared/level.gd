class_name Level
extends Node2D


@export_range(1, 25) var id: int
@export var next_levels: Array[int] = []
@export var scene: PackedScene
@export var area: Area2D
@export var key_sprite: Sprite2D
@export var locked_frame: NinePatchRect


func _ready():
	Levels.map[id]["level"] = self
	area.mouse_entered.connect(overed_on)
	area.mouse_exited.connect(overed_off)
	area.input_event.connect(lock_on)
	overed_off()
	unfocus()


func lock_on(viewport, event: InputEvent, shape_idx):
	if event.is_action("mouse_left"):
		%LevelsCamera.set_target(self)

func _process(delta):
	if %LevelsCamera.target == self:
		if not Levels.is_finished(id):
			focus()
	else:
		unfocus()


func focus():
	key_sprite.visible = true


func unfocus():
	key_sprite.visible = false


func overed_on():
	locked_frame.visible = true
	locked_frame.texture.pause = false


func overed_off():
	locked_frame.visible = false
	locked_frame.texture.pause = true
	
