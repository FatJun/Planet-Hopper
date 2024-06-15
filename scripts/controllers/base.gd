class_name BaseController
extends CharacterBody2D



@export_category("Physics Settings")
@export var speed := 200.
@export var friction := 0.3
@export var acceleration := 0.3

@export_category("External Exports")
@export var collision: CollisionShape2D
@export var sprite: AnimatedSprite2D
