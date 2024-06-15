class_name PlayerController
extends PlatformerController

var x_axis := 0.


func update_to_face_direction():
	update_direction(x_axis)
	flip(x_axis)
