class_name SpaceShip
extends Node2D


@export var landing_zone: Area2D


func _ready():
	$Sprite2D.visible = false



func activate():
	$Sprite2D.visible = true
	$AnimatedSprite2D.play("fly")


func go_to_levels():
	await $AnimatedSprite2D/AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(Levels.levels_level)


func fly_away():
	EventBus.started_fly_away.emit()
	$Sprite2D.visible = false
	$AnimatedSprite2D.play("fly")
	$AnimatedSprite2D/AnimationPlayer.play("fly_away")
	Levels.finish_current_level()
	call_deferred("go_to_levels")
	
