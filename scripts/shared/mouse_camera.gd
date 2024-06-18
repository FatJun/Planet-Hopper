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
	if zoom != Vector2.ONE:
		zoom = zoom.lerp(Vector2.ONE, lerp_speed)
	var axis = Input.get_vector("left", "right", "up", "down")
	if axis:
		var velocity: Vector2 = camera_speed * axis * delta
		global_position = global_position.lerp(global_position + velocity, lerp_speed)
