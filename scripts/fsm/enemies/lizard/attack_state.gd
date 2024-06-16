extends State

@export_category("Attack Settings")
@export var attack_speed := 2.
@export var muzzle: Marker2D
@export var Projectile: PackedScene

@onready var fsm: LizardFSM = get_parent()

var attack_timer: Timer
var prev_axis: float


func enter() -> void:
	attack_timer = Timer.new()
	attack_timer.one_shot = true
	attack_timer.wait_time = attack_speed
	add_child(attack_timer)
	
	prev_axis = fsm.controller.x_axis
	fsm.controller.x_axis = 0.
	
	fsm.play_anim(fsm.ATTACK)
	fsm.controller.sprite.animation_finished.connect(_on_animation_finished)
	attack_timer.timeout.connect(_on_attack_timer_timeout)


func ph_update(_delta: float) -> void:
	if not fsm.is_attacking:
		if fsm.is_idle:
			return fsm.change_state(fsm.states[fsm.IDLE])
		elif fsm.is_moving:
			return fsm.change_state(fsm.states[fsm.RUN])
	fsm.controller.update_to_face_direction()
	fsm.controller.update_all_physics()
	fsm.controller.move_and_slide()


func _on_animation_finished():
	fsm.play_anim(fsm.IDLE)
	var projectile = Projectile.instantiate()
	projectile.axis = prev_axis
	add_child(projectile)
	projectile.global_transform = muzzle.global_transform
	attack_timer.start()


func _on_attack_timer_timeout():
	fsm.play_anim(fsm.ATTACK)


func exit() -> void:
	attack_timer.timeout.disconnect(_on_attack_timer_timeout)
	fsm.controller.sprite.animation_finished.disconnect(_on_animation_finished)
	remove_child(attack_timer)
	fsm.controller.x_axis = prev_axis
