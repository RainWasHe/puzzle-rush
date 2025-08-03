extends TextureProgressBar
class_name TimerBar

@export var timer: Timer
func _ready():
	if(get_tree().current_scene.has_meta("time")):
		timer.wait_time = get_tree().current_scene.get_meta("time")
	max_value = timer.wait_time
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(visible):
		value = timer.time_left
