class_name LifetimeBar
extends BaseBar


@export var item: PickableItem
@export var min_life_time := .5

var lifetime := 0.


var timer: Timer

func _ready():
	lifetime = item.lifetime
	timer = Timer.new()
	timer.wait_time = lifetime
	timer.one_shot = true
	add_child(timer)
	refill()
	timer.start()
	EventBus.time_freezed.connect(_on_time_freezed)
	EventBus.time_unfreezed.connect(_on_time_unfreezed)
	


func _on_time_freezed():
	timer.paused = true


func _on_time_unfreezed():
	timer.paused = false


func _process(_delta):
	current_value_ = remap(timer.time_left, 1, lifetime, min_value, max_value_)
	update()
