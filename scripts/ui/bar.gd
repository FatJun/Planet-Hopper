class_name BaseBar
extends ProgressBar

var max_value_ := 100.
var current_value_ := 100.


func refill():
	current_value_ = max_value_
	update()


func update():
	var new_value = (current_value_ / max_value_) * max_value
	var tween = create_tween().bind_node(self).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_parallel(true)
	tween.tween_property(self, "value", new_value, 0.2)
	tween.tween_property($SecondaryBar, "value", new_value, 0.25)
