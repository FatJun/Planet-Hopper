extends RichTextLabel


@export var base_text = "Planet saved %s/%s"


func _process(delta):
	text = base_text % [Levels.finished_levels, Levels.max_levels]
