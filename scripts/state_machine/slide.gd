extends State

@export var slideHitbox: CollisionShape2D
@export var normalHitbox: CollisionShape2D
@export var slidePolygon: Polygon2D
@export var normalPolygon: Polygon2D

@export var jump_state: State
@export var move_state: State
@export var rewind_state: State
@export var fall_state: State


func enter() -> void:
	slidePolygon.visible = true
	normalPolygon.visible = false
	
	slideHitbox.disabled = false
	normalHitbox.disabled = true

func exit() -> void:
	slidePolygon.visible = false
	normalPolygon.visible = true

	slideHitbox.disabled = true
	normalHitbox.disabled = false

func process_input(input: InputEvent) -> State:
	if input.is_action_pressed("move_jump") and parent.is_on_floor():
		return jump_state
	if input.is_action_released("move_slide"):
		return move_state
	if(input.is_action_pressed("rewind")):
		return rewind_state
	return null


func process_physics(delta: float) -> State:
	parent.velocity.x = parent.FACING * parent.SLIDING_SPEED
	parent.move_and_slide()
	if not parent.is_on_floor():
		parent.velocity.y += parent.gravity * delta
	
	return null
