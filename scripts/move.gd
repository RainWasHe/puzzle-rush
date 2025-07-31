extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var rewind_state: State


func process_input(input: InputEvent) -> State:
	if(input.is_action_pressed("move_jump")):
		return jump_state
	if(input.is_action_pressed("rewind")):
		return rewind_state
	return null
	

func process_physics(delta: float) -> State:
	var movement = Input.get_axis("move_left", "move_right")
	parent.velocity.x = movement * parent.SPEED
	parent.move_and_slide()
	if(!parent.is_on_floor()):
		return fall_state
	if(parent.is_on_floor() && movement == 0):
		return idle_state
	return null
