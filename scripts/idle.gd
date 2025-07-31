extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State
@export var rewind_state: State

func enter() -> void:
	parent.velocity.x = 0

func process_input(input: InputEvent) -> State:
	if input.is_action_pressed("move_jump") and parent.is_on_floor():
		return jump_state
	if input.is_action_pressed("move_left") or input.is_action_pressed("move_right"):
		return move_state
	if(input.is_action_pressed("rewind")):
		return rewind_state
	return null
func process_physics(delta: float) -> State:
	parent.velocity.y += parent.gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null
