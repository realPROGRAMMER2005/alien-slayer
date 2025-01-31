extends Node
class_name FiniteStateMachine 

var current_state: State
@export var initial_state: State
var states: Dictionary = {}

func _ready():
	for state: State in get_children():
		states[state.name] = state
	current_state = initial_state

func change_state(new_state_name: String):
	if current_state:
		current_state.exit_state()
	
	current_state = states.get(new_state_name)
	
	if current_state:
		current_state.enter_state()

func _process(delta: float):
	if current_state:
		current_state.process_state(delta)
