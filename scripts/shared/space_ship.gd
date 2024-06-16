class_name SpaceShip
extends Node2D


@onready var landing_zone: Area2D = $Area2D


func _ready():
	$Sprite2D.visible = false



func activate():
	$Sprite2D.visible = true
	$AnimatedSprite2D.play("fly")


func fly_away():
	$Sprite2D.visible = false
	$AnimatedSprite2D.play("fly")
	$AnimatedSprite2D/AnimationPlayer.play("fly_away")
