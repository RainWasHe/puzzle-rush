extends TextureProgressBar
@export var timer: Timer
func _ready():
	max_value = timer.wait_time
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(visible):
		value = timer.time_left
