extends AnimationPlayer


func _ready():
	EventBus.started_fly_away.connect(func(): play("fade-in"))
