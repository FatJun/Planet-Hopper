class_name JetpackBurstParticles
extends GPUParticles2D


@export_category("Gravity Force")
@export var gravity_force := 90.


func set_gravity(direction: Vector2):
	var gravity_direction = Vector3(direction.x, direction.y, 0)
	process_material.gravity = gravity_direction * gravity_force


func emit():
	emitting = true
