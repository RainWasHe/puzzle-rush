extends State

@export var fall_state: State
@export var move_state: State
@export var idle_state: State

@onready var timer: Timer = $"../../Control/CanvasLayer/TimerBar".timer
@export var stopwatch: Stopwatch
var rewind: bool = false

var lastVelocities: Array
var maxVelocity: Vector2

func enter() -> void:
	if(!stopwatch.stopped):
		stopwatch.stopped = true
		parent.rewindingPoint.visible = false
		lastVelocities = parent.rewind_actions["velocity"].duplicate()
		var maxVelocityRaw := lastVelocities.slice(lastVelocities.size() - 5, lastVelocities.size())
		var maxVelocityLength = 0
		for vector: Vector2 in maxVelocityRaw:
			if maxVelocityLength < vector.length_squared():
				maxVelocityLength = vector.length_squared()
				maxVelocity = vector
		timer.stop()
		rewind = true
		parent.collision_shape.set_deferred("disabled", true)
	else:
		stopwatch.stopped = false
		parent.rewindingPoint.global_position = parent.global_position
		parent.rewindingPoint.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_physics(delta) -> State:
	if(stopwatch.stopped):
		var position = parent.rewind_actions["position"].pop_back()
		var rotation = parent.rewind_actions["rotation"].pop_back()
		if(parent.rewind_actions["position"].is_empty()):
			parent.collision_shape.set_deferred("disabled", false)
			rewind = false
			parent.global_position = position
			parent.rotation = rotation
			parent.velocity += maxVelocity / 2
			maxVelocity = Vector2(0, 0)
			
			timer.wait_time = timer.wait_time - stopwatch.time
			stopwatch.time = 0.0
			timer.start()
			parent.rewindingPoint.visible = false
			
			if(parent.is_on_floor()):
				var movement = Input.get_axis("move_left", "move_right")
				if(movement != 0):
					return move_state
				else:
					return idle_state
			return fall_state

		parent.rotation = rotation
		parent.global_position = position
		return null
	else:
		if(parent.is_on_floor()):
			var movement = Input.get_axis("move_left", "move_right")
			if(movement != 0):
				return move_state
			else:
				return idle_state
		return fall_state
