extends Node
class_name FiniteStateMachine

@export var initial_state: State
var state: State

func _ready() -> void:
	state = initial_state

func change_state(new_state: State):
	if state is State:
		state.exit_state()
	new_state.enter_state()
	state = new_state
