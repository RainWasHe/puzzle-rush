extends Node

@export var starting_state: State
@export var current_state: State
@export var text: TextEdit

# Called when the node enters the scene tree for the first time.
func init(parent: Player) -> void:
	for child in get_children():
		child.parent = parent
	
	change_state(starting_state)


func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	
	current_state = new_state
	current_state.enter()
func process_physics(delta):
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent):
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta):
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)
