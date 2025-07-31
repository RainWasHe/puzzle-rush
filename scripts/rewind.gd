extends State

@export var fall_state: State
@export var move_state: State
@export var idle_state: State

@onready var timer: Timer = $"../../Timer"
var rewind: bool = false

var lastVelocities: Array
var maxVelocity: Vector2

func enter() -> void:
	lastVelocities = parent.rewind_actions["velocity"].duplicate()
	var maxVelocityRaw := lastVelocities.slice(lastVelocities.size() - 10, lastVelocities.size())
	var maxVelocityLength = 0
	for vector: Vector2 in maxVelocityRaw:
		if maxVelocityLength < vector.length_squared():
			maxVelocityLength = vector.length_squared()
			maxVelocity = vector
	print(maxVelocity)
	timer.stop()
	rewind = true
	parent.collision_shape.set_deferred("disabled", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_physics(delta) -> State:
	var position = parent.rewind_actions["position"].pop_back()
	var rotation = parent.rewind_actions["rotation"].pop_back()
	var time = parent.rewind_actions["rewindTime"].pop_back()
	timer.wait_time = time
	if(parent.rewind_actions["position"].is_empty()):
		print(maxVelocity)
		parent.collision_shape.set_deferred("disabled", false)
		rewind = false
		parent.global_position = position
		parent.rotation = rotation
		parent.velocity += maxVelocity / 2
		timer.start()
		
		var movement = Input.get_axis("move_left", "move_right")
		if(parent.is_on_floor()):
			if(movement != 0):
				return move_state
			else:
				return idle_state
		return fall_state
	parent.rotation = rotation
	parent.global_position = position
	return null
