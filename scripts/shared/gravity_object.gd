class_name GravityObject
extends StaticBody2D


@export_category("Gravity Settings")
## Mass of the object use for calculate the gravity
@export var mass := 1.


func get_direction_to_center_of_mass(obj: Node2D) -> Vector2:
	return obj.global_position.direction_to(global_position)
