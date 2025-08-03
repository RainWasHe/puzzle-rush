extends CharacterBody2D
class_name Player


@export var rewind_state: State
@export var animationSprite: AnimatedSprite2D

@export var SPEED: float = 100.0
@export var SLIDING_SPEED: float = 200.0
@export var FACING: int = 1
var CAN_REWIND: bool = true
@onready var state_machine = $stateMachine
#: Timer = $Control/CanvasLayer/TimerBar.timer
var replay_duration: float = 10.0
@onready var rewindingPoint: Marker2D = preload("res://scenes/rewind_point.tscn").instantiate()
@export var collision_shape: CollisionShape2D
@export var TimerBar: TimerBar
@export var stopwatch: Stopwatch
var rewind_actions: Dictionary = {
	"position": [],
	"rotation": [],
	"velocity": [],
}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	get_tree().current_scene.add_child.call_deferred(rewindingPoint)
	if(get_tree().current_scene.is_in_group("notRewindLevel")):
		CAN_REWIND = false
	if(!CAN_REWIND):
		$Control/CanvasLayer/TimerBar.visible = false
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	

func _physics_process(delta: float) -> void:
	if (!rewind_state.rewind && CAN_REWIND && !stopwatch.stopped): 
		#if replay_duration * Engine.physics_ticks_per_second == rewind_actions["position"].size():
			#for key in rewind_actions.keys():
				#rewind_actions[key].pop_front()
		rewind_actions["position"].append(global_position)
		rewind_actions["rotation"].append(rotation)
		rewind_actions["velocity"].append(velocity)
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	$TextEdit2.text = str($stateMachine/jump.jump_buffer)
	state_machine.process_frame(delta)


func _on_timer_bar_value_changed(value):
	print(value)
	if(value <= 0 && CAN_REWIND && !rewind_state.rewind):
		get_tree().reload_current_scene()
		#stopwatch.stopped = true
		#state_machine.change_state(rewind_state)
