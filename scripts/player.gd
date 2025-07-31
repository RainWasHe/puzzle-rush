extends CharacterBody2D
class_name Player


@export var rewind_state: State

@export var SPEED: float = 100.0
@export var SLIDING_SPEED: float = 200.0
@export var FACING: int = 1
@onready var state_machine = $stateMachine
@onready var replay_duration: Timer = $Control/CanvasLayer/TimerBar.timer
@export var collision_shape: CollisionShape2D
var rewind_actions: Dictionary = {
	"position": [],
	"rotation": [],
	"velocity": [],
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	$Control/CanvasLayer/TimerBar.visible = false
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	

func _physics_process(delta: float) -> void:
	if not (rewind_state.rewind):
		if replay_duration.wait_time * Engine.physics_ticks_per_second == rewind_actions["position"].size():
			for key in rewind_actions.keys():
				rewind_actions[key].pop_front()
		rewind_actions["position"].append(global_position)
		rewind_actions["rotation"].append(rotation)
		rewind_actions["velocity"].append(velocity)
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	$TextEdit2.text = str($stateMachine/jump.jump_buffer)
	state_machine.process_frame(delta)


func _on_timer_bar_value_changed(value):
	if(value <= 0):
		state_machine.change_state(rewind_state)
