extends State


@export var idle_state: State
@export var jump_state: State
@export var move_state: State
@export var rewind_state: State
@export var jump_buffer_timer: Timer
@export var wind: CPUParticles2D

func process_input(input: InputEvent) -> State:
	if(input.is_action_pressed("move_left") or input.is_action_pressed("move_right")):
		return move_state
	if(input.is_action_pressed("move_jump") and jump_state.jump_buffer == false):
		jump_buffer_timer.start()
		jump_state.jump_buffer = true
	if (input.is_action_pressed("move_jump") && parent.is_on_floor()):
		return jump_state
	if(input.is_action_pressed("rewind") && parent.CAN_REWIND):
		return rewind_state
	return null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_physics(delta: float) -> State:
	#if(abs(parent.velocity.y) > 200.0):
		#wind.visible = true
		#wind.modulate.a = lerp(0, 255, 0.1)
		#wind.speed_scale = parent.velocity.y / 32
		#wind.gravity = parent.velocity / 32
		#wind.emitting = true
	#else:
		#wind.modulate.a = lerp(255, 0, 0.1)
		#wind.visible = false
		#wind.emitting = false
		
	if !parent.is_on_floor():
		parent.velocity.y += parent.gravity * delta
		parent.move_and_slide()
	else:
		var movement = Input.get_axis("move_left","move_right") * parent.SPEED
		if(jump_state.jump_buffer):
			return jump_state
		if(movement != 0):
			return move_state
		else:
			return idle_state
	return null
