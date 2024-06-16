extends State

@onready var fsm: FlyEyeFSM = get_parent()


func enter():
	fsm.explosion_timer.stop()
	if fsm.hitted:
		fsm.controller.target.take_damage(
			fsm.controller, fsm.controller.explosion_damage, fsm.controller.knockback_force
		)
	fsm.controller.collision.queue_free()
	call_deferred("explode")


func explode():
	fsm.controller.sprite.play("explosion")
	await fsm.controller.sprite.animation_finished
	fsm.controller.queue_free()
