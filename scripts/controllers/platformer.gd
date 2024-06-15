class_name PlatformerController
extends BaseController


@export_category("Gravity Settings")
@export var mass := 45.
@export var air_friction := 0.25
@export var gravity_zone: GravityZone

@export_category("Jump Settings")
@export var max_jumps_in_row := 1
@export var jump_force := 1000



var gravity_direction: Vector2:
	get = get_gravity_direction
var is_can_jump: bool:
	get = get_is_can_jump

var direction := Vector2.ZERO
var movement_velocity := Vector2.ZERO

var gravity_objects: Array[GravityObject] = []
var gravity_direction_force := Vector2.ZERO
var gravity_velocity := Vector2.ZERO

var jump_velocity := Vector2.ZERO
var jumps_in_row := 0


func _ready():
	gravity_zone.area_entered.connect(_on_area_entered)
	gravity_zone.area_exited.connect(_on_area_exited)


func update_direction(axis: float = 0.) -> void:
	direction = Vector2.RIGHT.rotated(rotation) * axis


func flip(axis: float = 0.) -> void:
	if not axis:
		return
	sprite.flip_h = axis < 0


func get_is_can_jump() -> bool:
	return is_on_floor() or max_jumps_in_row > jumps_in_row


func get_normalized_vertical_velocity() -> float:
	return up_direction.dot(velocity.normalized())


func process_gravity() -> void:
	var local_general_gravity_direction_force := Vector2.ZERO
	for gravity_object in gravity_objects:
		var distance_to_gravity_object := global_position.distance_to(gravity_object.global_position)
		var local_gravity_direction := gravity_object.get_direction_to_center_of_mass(self)
		var local_gravity_force = Gravity.GRAVITY_FORCE * (gravity_object.mass * mass) / pow(distance_to_gravity_object, 2)
		local_general_gravity_direction_force += local_gravity_direction * local_gravity_force
	gravity_direction_force = local_general_gravity_direction_force


func apply_gravity():
	up_direction = -gravity_direction
	rotation = gravity_direction.orthogonal().angle()
	jump_velocity = jump_velocity.lerp(Vector2.ZERO, air_friction)
	gravity_velocity = gravity_direction_force


func apply_movement() -> void:
	if direction:
		movement_velocity = movement_velocity.lerp(direction * speed, acceleration)
	else:
		movement_velocity = movement_velocity.lerp(Vector2.ZERO, friction)


func apply_jump() -> void:
	assert(is_can_jump)
	jumps_in_row += 1
	jump_velocity = up_direction * jump_force


func update_velocity():
	velocity = gravity_velocity + movement_velocity + jump_velocity


func get_gravity_direction() -> Vector2:
	return gravity_direction_force.normalized()


func update_movement_physics():
	apply_movement()


func update_gravity_physics():
	process_gravity()
	apply_gravity()


func update_all_physics():
	update_movement_physics()
	update_gravity_physics()
	update_velocity()


func _on_area_entered(area: Area2D):
	if area.is_in_group(Gravity.GRAVITY_ZONE_GROUP):
		gravity_objects.append(area.get_parent())


func _on_area_exited(area: Area2D):
	if area.is_in_group(Gravity.GRAVITY_ZONE_GROUP):
		gravity_objects.erase(area.get_parent())
