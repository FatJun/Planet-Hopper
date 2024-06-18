class_name LizardController
extends PlatformerController


@export_category("AI Settings")
@export var vision_zone: Area2D
@export var collision_ray: RayCast2D
@export_range(-1., 1., 1.) var x_axis := 1.

@export_category("Attack Settings")
@export var collision_damage := 3
@export var knockback_force := 1200.

var enemies_in_vision_zone: Array[PlayerController] = []


func update_to_face_direction():
	update_direction(x_axis)
	flip(x_axis)


func flip(axis: float = 0.) -> void:
	if not axis:
		return
	sprite.flip_h = axis > 0
	vision_zone.scale.x = -vision_zone.scale.y if axis < 0 else vision_zone.scale.y
	collision_ray.scale.x = -collision_ray.scale.y if axis < 0 else collision_ray.scale.y


func _on_vision_zone_body_entered(body):
	if body.is_in_group("player"):
		enemies_in_vision_zone.append(body)


func _on_vision_zone_body_exited(body):
	if body.is_in_group("player"):
		enemies_in_vision_zone.erase(body)


func _on_damage_area_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(self, collision_damage, knockback_force)
