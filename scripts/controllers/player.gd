class_name PlayerController
extends PlatformerController

signal fuel_units_changed
signal health_changed
signal mission_progress_changed
signal dead

@export_category("JetPack Settings")
@export var max_fuel_units := 4
@export var min_fuel_units := 0
@export var _current_fuel_units := 0
@export var jetpack_force := 60
@export var jetpack_accel := .2
@export var jetpack_working_time := 1.5
@export var jetpack_particles: JetpackBurstParticles

@export_category("Mission Progress")
@export var max_mission_progress := 0
@export var min_mission_progress := 0
@export var space_ship: SpaceShip


@export_category("Health Settings")
@export var max_health := 5
@export var min_health := 0

@export var anim_player: AnimationPlayer
@export var take_damage_sound: AudioStreamPlayer

var in_landing_zone := true
var jetpack_timer: Timer
var jetpack_is_reloading := false
var jetpack_velocity := Vector2.ZERO
var current_fuel_units: int:
	get = get_current_fuel_units,
	set = set_current_fuel_units

var _current_mission_progress := 0
var current_mission_progress: int:
	get = get_current_mission_progress,
	set = set_current_mission_progress

var _current_health = self.max_health
var current_health: int:
	get = get_current_health,
	set = set_current_health
var is_can_use_jetpack: bool:
	get:
		return current_fuel_units > 0 and not jetpack_is_reloading


var knockback_velocity := Vector2.ZERO

var x_axis := 0.


func _ready():
	super._ready()
	jetpack_timer = Timer.new()
	jetpack_timer.one_shot = true
	add_child(jetpack_timer)
	space_ship.landing_zone.body_entered.connect(_on_landing_zone_entered)
	space_ship.landing_zone.body_exited.connect(_on_landing_zone_exited)
	jetpack_timer.timeout.connect(cancel_jetpack)
	if _current_mission_progress >= max_mission_progress:
		space_ship.activate()



func _on_landing_zone_entered(body):
	if body == self:
		in_landing_zone = true


func _on_landing_zone_exited(body):
	if body == self:
		in_landing_zone = false


func set_current_mission_progress(new_value: int) -> void:
	_current_mission_progress = clamp(new_value, min_mission_progress, max_mission_progress)
	if _current_mission_progress >= max_mission_progress:
		space_ship.activate()
	mission_progress_changed.emit()


func get_current_mission_progress() -> int:
	return _current_mission_progress


func set_current_health(new_value: int) -> void:
	_current_health = clamp(new_value, min_health, max_health)
	health_changed.emit()
	if current_health <= 0:
		dead.emit()


func get_current_health() -> int:
	return _current_health


func reset_jumps():
	super.reset_jumps()
	jetpack_is_reloading = false


func set_current_fuel_units(new_value: int) -> void:
	_current_fuel_units = clamp(new_value, min_fuel_units, max_fuel_units)
	fuel_units_changed.emit()


func apply_gravity():
	super.apply_gravity()
	jetpack_particles.set_gravity(gravity_direction)
	if not jetpack_timer.is_stopped():
		gravity_velocity /= 2
		jetpack_velocity = -gravity_velocity + (up_direction * jetpack_force)


func update_velocity():
	super.update_velocity()
	velocity += jetpack_velocity
	velocity += knockback_velocity
	knockback_velocity = knockback_velocity.lerp(Vector2.ZERO, air_friction)


func get_current_fuel_units() -> int:
	return _current_fuel_units


func apply_jetpack() -> void:
	assert(is_can_use_jetpack)
	current_fuel_units -= 1
	jetpack_is_reloading = true
	jetpack_particles.emitting = true
	jetpack_timer.start()


func cancel_jetpack() -> void:
	jetpack_velocity = Vector2.ZERO
	jetpack_particles.emitting = false
	jetpack_timer.stop()


func take_damage(obj: Node2D, value: int, knockback_force: float):
	var knockback_direction = -global_position.direction_to(obj.global_position)
	knockback_velocity = knockback_direction * knockback_force
	current_health -= value
	take_damage_sound.play()


func update_x_axis():
	x_axis = Input.get_axis("left", "right")


func update_to_face_direction():
	update_direction(x_axis)
	flip(x_axis)
