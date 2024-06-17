class_name LevelsCamera
extends Camera2D

signal target_changed


@export var scroll_speed := 500.
var camera_move := 0.
var mouse_position := Vector2.ZERO
var camera_pos := Vector2.ZERO
var camera_speed := 5000.
var lerp_speed := .1
var zoom_multiply := 1.5
var target: Variant = null
@onready var default_y = self.global_position.y


func _ready():
	call_deferred("set_deafault_position")

func set_deafault_position():
	global_position = Levels.get_current().global_position


func _unhandled_input(event: InputEvent):
	if event.is_action("enter_in_spaceship") and target:
		if not Levels.is_finished(target.id):
			Levels.current = target.id
			get_tree().change_scene_to_packed(target.scene)


func set_target(new_target: Variant):
	if target != new_target:
		target_changed.emit()
	target = new_target


func _process(delta):
	if target:
		zoom = zoom.lerp(Vector2.ONE * zoom_multiply, lerp_speed)
		global_position = global_position.lerp(target.global_position, lerp_speed)
		return 
	if global_position.y != default_y:
		global_position.y = lerpf(global_position.y, default_y, lerp_speed)
	if zoom != Vector2.ONE:
		zoom = zoom.lerp(Vector2.ONE, lerp_speed)
	var x_axis = Input.get_axis("left", "right")
	if x_axis:
		var velocity: float = camera_speed * x_axis * delta
		global_position.x = lerpf(global_position.x, global_position.x + velocity, lerp_speed)
		return
