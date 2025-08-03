extends State

@export var fall_state: State
@export var move_state: State
@export var idle_state: State

@onready var timer: Timer = $"../../Control/CanvasLayer/TimerBar".timer
@export var stopwatch: Stopwatch
@export var greyscale: ColorRect
var rewind: bool = false

var lastVelocities: Array
var maxVelocity: Vector2

func enter() -> void:
	if(!stopwatch.stopped):
		greyscale.visible = true
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
		var animation = parent.rewind_actions["animation"].pop_back()
		var flip_h = parent.rewind_actions["flip_h"].pop_back()
		var frame = parent.rewind_actions["frame"].pop_back()
		if(parent.rewind_actions["position"].is_empty()):
			parent.collision_shape.set_deferred("disabled", false)
			rewind = false
			parent.global_position = position
			parent.rotation = rotation
			parent.animationSprite.animation = animation
			parent.animationSprite.frame = frame
			parent.animationSprite.flip_h = flip_h
			parent.velocity += maxVelocity / 2
			maxVelocity = Vector2(0, 0)
			
			timer.wait_time = timer.wait_time - (stopwatch.time + 0.5)
			stopwatch.time = 0.0
			timer.start()
			parent.rewindingPoint.visible = false
			greyscale.visible = false
			if(parent.is_on_floor()):
				var movement = Input.get_axis("move_left", "move_right")
				if(movement != 0):
					return move_state
				else:
					return idle_state
			return fall_state
		parent.animationSprite.flip_h = flip_h
		parent.animationSprite.animation = animation
		parent.animationSprite.frame = frame
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
