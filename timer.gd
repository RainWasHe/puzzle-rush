extends Node
class_name Stopwatch

var time = 0.0
@export var stopped = false

func _process(delta: float) -> void:
	if stopped:
		return
	time += delta
	print(time)
