class_name Projectile
extends Area2D


@export var max_lifetime := 15.
@export var damage := 3
@export var speed := 200
@export var sprite: AnimatedSprite2D
@export var knockback_force := 800.

var gravity_objects: Array[GravityObject] = []
var gravity_direction_ := Vector2.ZERO
var direction := Vector2.ZERO
var life_timer: Timer
var axis := 0.


func _ready():
	life_timer = Timer.new()
	life_timer.one_shot = true
	life_timer.wait_time = max_lifetime
	add_child(life_timer)
	life_timer.start()
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	body_entered.connect(_on_body_entered)
	life_timer.timeout.connect(_on_life_timer_timeout)


func _physics_process(delta):
	process_gravity()
	rotation = gravity_direction_.orthogonal().angle()
	direction = Vector2.RIGHT.rotated(rotation)
	position += (direction * axis) * speed * delta


func process_gravity() -> void:
	var local_general_gravity_direction_force := Vector2.ZERO
	for gravity_object in gravity_objects:
		var local_gravity_direction := gravity_object.get_direction_to_center_of_mass(self)
		local_general_gravity_direction_force += local_gravity_direction
	gravity_direction_ = local_general_gravity_direction_force.normalized()


func destroy():
	set_physics_process(false)
	sprite.play("explosion")
	await sprite.animation_finished
	queue_free()


func _on_life_timer_timeout():
	call_deferred("destroy")


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.take_damage(self, damage, knockback_force)
	call_deferred("destroy")
	


func _on_area_entered(area: Area2D):
	if area.is_in_group(Gravity.GRAVITY_ZONE_GROUP):
		gravity_objects.append(area.get_parent())


func _on_area_exited(area: Area2D):
	if area.is_in_group(Gravity.GRAVITY_ZONE_GROUP):
		gravity_objects.erase(area.get_parent())
