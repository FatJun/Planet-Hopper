extends AudioStreamPlayer


func _ready():
	finished.connect(play)
