class_name PlayerCamera
extends Camera2D

@export_category("Offset")
@export var max_camera_offset := 150.
@export var camera_offset_delay := .05

@export_category("Shared Settings")
@export var player: PlayerController
@export var anim_player: AnimationPlayer


func lock_to_targets(targets: Array[Variant]):
	var total_position := Vector2.ZERO
	for target in targets:
		total_position += target.global_position
	var average_position = total_position / targets.size()
	var new_offset = average_position - global_position
	if new_offset.length() > max_camera_offset:
		new_offset = new_offset.normalized() * max_camera_offset
	offset = offset.lerp(new_offset, camera_offset_delay)


func _physics_process(_delta):
	if player.gravity_objects.size() > 0:
		lock_to_targets(player.gravity_objects)
