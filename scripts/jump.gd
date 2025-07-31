extends State
	
@export var fall_state: State
@export var idle_state: State
@export var move_state: State
@export var rewind_state: State
@export var jump_force: float = 400.0
@export var jump_buffer_timer: Timer

var jump_buffer: bool = false

func enter() -> void:
	parent.velocity.y = -jump_force
	jump_buffer = false

func process_input(input: InputEvent) -> State:
	if input.is_action_pressed("move_jump") && jump_buffer == false:
		jump_buffer = true
		jump_buffer_timer.start()
		return null
	if(input.is_action_pressed("rewind")):
		return rewind_state
	return null


func process_physics(delta: float) -> State:
	parent.velocity.y += parent.gravity * delta


	if parent.velocity.y > 0:
		return fall_state
	var movement = Input.get_axis("move_left","move_right") * parent.SPEED
	
	#if movement != 0:
		#parent.animations.
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		#if jump_buffer:
			#jump_buffer = false
			#enter()
		if movement != 0:
			return move_state
		return idle_state	
	
	return null

func _on_jump_buffer_timer_timeout():
	jump_buffer = false
