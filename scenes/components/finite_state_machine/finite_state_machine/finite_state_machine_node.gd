extends Node
class_name FiniteStateMachineNode

@export var current_state: StateNode
@export var owner_node: Node


	
func _process(delta: float):
	if not current_state:
		current_state = get_child(0)
		
		if current_state:
			current_state._enter_state()
	
	if not owner_node:
		owner_node = get_parent()
		
	if current_state:
		current_state._process_state(delta)


func change_state(new_state: StateNode):
	
	if new_state and new_state != current_state:
		if current_state:
			current_state._exit_state()
		current_state = new_state
		current_state._enter_state()
		print(current_state)
