extends FiniteStateMachineNode
class_name AICharacterStateMachineNode


@export var movement_node: MovementNode
@export var is_enabled: bool = true

			

func _process(delta: float):
	if not movement_node:
			movement_node = get_parent().find_child("*MovementNode*", false, false)
			
	
	
	if is_enabled:
	
		super._process(delta)
		
