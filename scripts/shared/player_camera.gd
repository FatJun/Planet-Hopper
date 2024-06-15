class_name PlayerCamera
extends Camera2D

@export_category("Zoom")
@export var camera_zoom_multi := 8.
@export var camera_zoom_animation := .05
@export var base_zoom := Vector2(2, 2)

@export_category("Position")
@export var camera_position_animation := .05

@export_category("Shared Settings")
@export var player: PlayerController



func lock_to_target(target: Variant):
	zoom = zoom.lerp(base_zoom, camera_zoom_animation)
	global_position = global_position.lerp(target.global_position, camera_position_animation)


func lock_to_targets(targets: Array[Variant]):
	var total_position := Vector2.ZERO
	var total_scale := Vector2.ZERO
	for target in targets:
		total_position += target.global_position
		total_scale += target.scale
	var average_position = total_position / targets.size()
	var average_scale = total_scale / targets.size()
	var average_zoom = (Vector2.ONE / average_scale) * camera_zoom_multi
	zoom = zoom.lerp(average_zoom, camera_zoom_animation)
	global_position = global_position.lerp(average_position, camera_position_animation)



func _physics_process(_delta):
	var gravity_objects = player.gravity_objects
	if gravity_objects.size() <= 0:
		lock_to_target(self)
	else:
		var targets: Array[Variant] = []
		targets.append_array(gravity_objects.duplicate())
		targets.append(player)
		lock_to_targets(targets)
