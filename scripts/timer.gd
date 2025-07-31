extends Timer

@export var progressBar: ProgressBar

func _process(delta):
	progressBar.value = time_left
