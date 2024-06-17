extends Node2D


@export var damage := 2
@export var knockback_force := 2000


func explode():
	$Sprite/AnimationPlayer.play("explosion")
	await $Sprite/AnimationPlayer.animation_finished
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(self, damage, knockback_force)
		$Area2D.queue_free()
		call_deferred("explode")
