extends State

@onready var fsm: FlyEyeFSM = get_parent()
@export var scream_sound: AudioStreamPlayer2D
@export var fly_sound: AudioStreamPlayer2D


func enter():
	fly_sound.play()
	scream_sound.play()
	fsm.explosion_timer.start()
	fly_sound.finished.connect(fly_sound.play)


func ph_update(_delta: float) -> void:
	fsm.controller.update_direction()
	fsm.controller.update_movement_physics()
	fsm.controller.update_velocity()
	fsm.controller.move_and_slide()


func exit():
	fly_sound.finished.disconnect(fly_sound.play)
	scream_sound.stop()
