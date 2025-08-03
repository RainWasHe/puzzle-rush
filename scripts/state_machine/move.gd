extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var rewind_state: State
@export var slide_state: State




func process_input(input: InputEvent) -> State:
	if(input.is_action_pressed("move_jump")):
		return jump_state
	if(input.is_action_pressed("rewind") && parent.CAN_REWIND):
		return rewind_state
	if(input.is_action_pressed("move_slide")):
		return slide_state
	return null
	

func process_physics(delta: float) -> State:
	var movement = Input.get_axis("move_left", "move_right")
	if(movement != 0):
		parent.FACING = movement
		if(parent.CAN_REWIND):
			parent.animationSprite.animation = "move_mask"
		else:
			parent.animationSprite.animation = "move"
		if(movement == 1):
			parent.animationSprite.flip_h = false
		else:
			parent.animationSprite.flip_h = true
		parent.animationSprite.play()

	parent.velocity.x = movement * parent.SPEED
	parent.move_and_slide()
	if(!parent.is_on_floor()):
		return fall_state
	if(parent.is_on_floor() && movement == 0):
		return idle_state
	return null
