class_name PickableItem
extends Node2D


@export var lifetime := 5.
@export var lifetime_bar: LifetimeBar
@export var pickable_zone: Area2D
@export var collision: CollisionShape2D
@export var anim_player: AnimationPlayer


func _ready():
	lifetime_bar.timer.timeout.connect(_on_lifetime_timeout)
	pickable_zone.body_entered.connect(_on_entered_pickable_zone)


func apply_effect(_player: PlayerController):
	pass


func destroy():
	anim_player.play("item/destroy")
	lifetime_bar.queue_free()
	collision.disabled = true
	await anim_player.animation_finished
	queue_free()


func _on_lifetime_timeout():
	destroy()


func pickup(player: PlayerController):
	anim_player.play("item/pickup")
	lifetime_bar.queue_free()
	collision.disabled = true
	apply_effect(player)
	await anim_player.animation_finished
	queue_free()


func _on_entered_pickable_zone(body):
	if body.is_in_group("player"):
		call_deferred("pickup", body)
